import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'in_app_purchase_platform_interface.dart';

class InAppPurchase {
  final methodChannel = const MethodChannel('in_app_purchase');

  Future<void> buy(
      String productId,
      Function(String productId, String trackingCode) callback,
      Function(String error) onError) async {
    try {
      var buy = await InAppPurchasePlatform.instance.buy(productId);
      String? trackingCode = buy![1];
      if (trackingCode != null) {
        var data =
            (await Dio(BaseOptions(baseUrl: 'https://master.hupadstore.ir/'))
                    .post('/api/Wallet/CheckPurchase',
                        data: {'txid': trackingCode}))
                .data;
        if (data['status'] == 1) {
          callback(buy[0], data['entity']);
        } else {
          onError(data['error']?['message']);
        }
      } else {
        onError('field');
      }
    } on PlatformException catch (e) {
      onError(e.message.toString());
    }
  }
}
