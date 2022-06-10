import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'in_app_purchase_platform_interface.dart';

/// An implementation of [InAppPurchasePlatform] that uses method channels.
class MethodChannelInAppPurchase extends InAppPurchasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hupad_in_app_purchase');
  @override
  Future<List?> buy(String productId) async {
    return
      await methodChannel.invokeMethod<List>('buy',{'productId':productId});
  }
}
