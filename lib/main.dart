import 'package:jourdainPay/pages/plash.dart';
import 'package:jourdainPay/utils/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'pages/login.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const FONT_FAMILY = 'Montserrat';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'e-JourdainPay',
        theme: ThemeData(
          fontFamily: FONT_FAMILY,
          primaryColor: Consts.mainColor,
        ),
        home: Center(child: Center(child: SplashScreen())),
    );
  }
}
