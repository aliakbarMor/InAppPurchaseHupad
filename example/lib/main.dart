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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "In app purchase",
      home: Scaffold(
        body: InkWell(
            onTap: () {
              _inAppPurchasePlugin.buy("test in app purchase",
                  (productId, resualt) {
                print('in app purchase result => $productId,$resualt');
              });
            },
            child: Stack(
              children: [
                Image.asset('assets/background.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill),
                Wrap(
                  children: [],
                )
              ],
            )),
      ),
    );
  }
}
