import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jourdainPay/pages/login.dart';
import 'package:jourdainPay/utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController controller;
  SharedPreferences sharedPreferences;

  var token;
  var role;
  static const spinkit = SpinKitThreeBounce(
    color: Consts.goldColor,
    size: 35.0,
  );

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null ||
        sharedPreferences.getString("role") != null) {
      setState(() {
        token = sharedPreferences.getString("token");
        role = sharedPreferences.getString("role");
      });
      return sharedPreferences.getString("token");
    }
  }

  @override
  void initState() {
    super.initState();
     controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    Timer(Duration(seconds: 6), () {
      navigateFromSplash();
    });
    // checkLoginStatus();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Consts.thirdColor,
              // image: DecorationImage(
              //   alignment: Alignment.bottomCenter,
              //   image: AssetImage("assets/images/bg6.jpg"),
              //   fit: BoxFit.cover,
              //   ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 270,
                    left: 0,
                    right: 0,
                    child: Container(
                      child: Image.asset("assets/images/logo-white.png"),
                    )),
                Positioned(
                    top: 260,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: 85, left: 70, right: 70),
                      height: 4,
                      width: 30,
                      child:LinearProgressIndicator(
                          value: controller.value,
                          semanticsLabel: 'Linear progress indicator',
                           backgroundColor: Colors.white,
                           valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber[600])
                        ),
                    ))
                // Positioned(
                //     top: 500,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //       margin: EdgeInsets.only(top: 85),
                //       height: 40,
                //       width: 30,
                //       child: spinkit,
                //     ))
              ],
            )),
      ),
    );
  }

  Future navigateFromSplash() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}
