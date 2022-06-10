import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hupad_in_app_purchase/in_app_purchase_method_channel.dart';

void main() {
  MethodChannelInAppPurchase platform = MethodChannelInAppPurchase();
  const MethodChannel channel = MethodChannel('in_app_purchase');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
