import 'package:flutter/material.dart';
import 'package:hupad_in_app_purchase/in_app_purchase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _inAppPurchasePlugin = InAppPurchase();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      title: "In app purchase",
      home: Scaffold(
        body: InkWell(
            onTap: () {
              _inAppPurchasePlugin.buy("f70a7225-e413-4138-9431-104958489623",
                  (String productId, String trackingCode) {
                debugPrint(
                    'productId: $productId, trackingCode: $trackingCode');
                _messangerKey.currentState?.showSnackBar(SnackBar(
                    content:
                        Text('Payment was successful \ntxid: $trackingCode')));
              }, (error) {
                _messangerKey.currentState
                    ?.showSnackBar(SnackBar(content: Text(error)));
              });
            },
            child: Stack(
              children: [
                Image.asset('assets/background.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill),
              ],
            )),
      ),
    );
  }
}
