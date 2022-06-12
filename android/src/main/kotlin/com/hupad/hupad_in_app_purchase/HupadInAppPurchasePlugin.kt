package com.hupad.hupad_in_app_purchase

import android.app.Activity
import android.content.ComponentName
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** HupadInAppPurchasePlugin */
class HupadInAppPurchasePlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var result: Result

    private var activity: Activity? = null
    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (resultCode == Activity.RESULT_OK) {
            if (requestCode == 521378) {
                val args: MutableList<Any?> = ArrayList()
                args.add(data?.getStringExtra("productId"))
                args.add(data?.getStringExtra("trackingCode"))
                result.success(args)
            } else {
                result.error("400", "field", null)
            }
        }
        return true
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hupad_in_app_purchase")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "buy" -> {
                this.result = result
                    val productId = call.argument<String>("productId")
                    val intent = Intent(Intent.ACTION_MAIN).apply {
                        component = ComponentName(
                            "com.example.hupad_market",
                            "com.example.hupad_market.IAPActivity"
                        )
                        putExtra(
                            "appName",
                            activity!!.applicationInfo.loadLabel(activity!!.packageManager)
                                .toString()
                        )
                        putExtra("packageName", activity!!.packageName)
                        putExtra("productId", productId)
                    }
                try {

                    activity!!.startActivityForResult(intent, 521378)

                } catch (e: Exception) {
                    result.error("404", "Hupad store is not installed on this device", null)
                }

            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}
