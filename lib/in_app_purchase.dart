import 'package:flutter/services.dart';
import 'in_app_purchase_platform_interface.dart';

class InAppPurchase {
  final methodChannel = const MethodChannel('in_app_purchase');

  Future<void> buy(String productId,
      Function(String productId, bool result) callback) async {
    var buy = await InAppPurchasePlatform.instance.buy(productId);
    callback(buy![0], buy[1]);
  }
}
