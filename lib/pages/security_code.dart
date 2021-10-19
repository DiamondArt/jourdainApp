import 'package:jourdainPay/models/base_model.dart';
import 'package:jourdainPay/pages/home.dart';
import 'package:jourdainPay/utils/consts.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  PinCodeVerificationScreen(this.phoneNumber);
  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var _isLoading = false;

  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SafeArea(
        bottom: false,
        child:
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30),
                  // Container(
                  //   height: MediaQuery.of(context).size.height / 3,
                  //   child: FlareActor(
                  //     "assets/images/pin_anim.flr",
                  //     animation: "otp",
                  //     // color: Colors.red,
                  //     fit: BoxFit.fitHeight,
                  //     alignment: Alignment.center,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('securité',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Consts.mainColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: 'Definissez un code de  4 chiffres ',
                          children: [
                            TextSpan(
                                text: "Pour votre prochaine authentification",
                                style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                          ],
                          style:
                              TextStyle(color: Colors.black54, fontSize: 18)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        length: 4,
                        obsecureText: false,
                        animationType: AnimationType.fade,
                        shape: PinCodeFieldShape.box,
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        backgroundColor: Colors.white,
                        fieldWidth: 40,
                        inactiveColor: Colors.blue,
                        controller: textEditingController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? 'Code obligatoire' : "",
                      style:
                          TextStyle(color: Colors.red.shade300, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     scaffoldKey.currentState.showSnackBar(SnackBar(
                  //       content: Text('new_code' + widget.phoneNumber),
                  //       duration: Duration(seconds: 3),
                  //     ));
                  //   },
                  //   child: RichText(
                  //     textAlign: TextAlign.center,
                  //     text: TextSpan(
                  //         text: 'no_code',
                  //         style: TextStyle(color: Colors.black54, fontSize: 15),
                  //         children: [
                  //           TextSpan(
                  //               text: 'resend',
                  //               //recognizer: onTapRecognizer,
                  //               style: TextStyle(
                  //                   color: Consts.mainColor,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 16))
                  //         ]),
                  //   ),
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                // conditions for validating
                                if (currentText.length != 4 ||
                                    currentText != "1234") {
                                  setState(() {
                                    hasError = true;
                                  });
                                } else {
                                  setState(() {
                                    hasError = false;
                                    _isLoading = true;
                                    Provider.of<BaseModel>(context)
                                        .setAuthWithSecurityCode(true);
                                  });

                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => new MyHomePage()));
                                }
                              },
                        child: Center(
                            child: !_isLoading
                                ? Text('Continuer',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 25,
                                  )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Consts.mainColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade200,
                              offset: Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.blue.shade200,
                              offset: Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                  )),
                   Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: FlareActor(
                      "assets/images/pin_anim.flr",
                      animation: "otp",
                      // color: Colors.red,
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     FlatButton(
                  //       child: Text('Effacer'),
                  //       onPressed: () {
                  //         textEditingController.clear();
                  //       },
                  //     ),
                  //     FlatButton(
                  //       child: Text('Sauter cette etape'),
                  //       onPressed: () {
                  //         textEditingController.text = "1234";
                  //       },
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
