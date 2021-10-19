import 'dart:ui';
import 'package:jourdainPay/models/base_model.dart';
import 'package:jourdainPay/pages/enrollment.dart';
import 'package:jourdainPay/pages/home.dart';
import 'package:jourdainPay/pages/security_code.dart';
import 'package:jourdainPay/pages/settings.dart';
import 'package:jourdainPay/utils/consts.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.mainColor,
      body: Stack(
        children: <Widget>[
          getBackgroundImg(),
          getLoginForm(context),
          
          // SafeArea(
          //   child:
          //   // Align(
          //   //   alignment: Alignment.topRight,
          //   //   child: IconButton(
          //   //     icon: Icon(Icons.settings),
          //   //     onPressed: () => Navigator.push(
          //   //       context,
          //   //       MaterialPageRoute(
          //   //         builder: (_) => SettingsPage(
          //   //           isLoggedIn: false,
          //   //         ),
          //   //       ),
          //   //     ),
          //   //   ),
          //   // ),
          // )
        ],
      ),
    );
  }

  Align getLoginForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .98,
                      height: MediaQuery.of(context).size.height * .60,
                      decoration: new BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.shade100.withOpacity(0.4),
                            width: 3),
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(22.0),
                          topRight: const Radius.circular(22.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            getCoopLogo(),
                            getWelcomeUser(),
                            Expanded(
                              child: LoginForm(),
                              flex: 12,
                            ),
                            getSignUp(context)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded getSignUp(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Mot de passe oublier?',
            style: TextStyle(
                fontSize: 14,
                decoration: TextDecoration.underline,
                color: Colors.blue),
          ),
          Text(
            ' Ou ',
            style: TextStyle(fontSize: 16),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Consts.mainColor,
              onTap: () {
                if (widget != null)
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => new Enrollment()));
              },
              child: Text(
                'S\'inscrire',
                style: TextStyle(
                    color: Consts.goldColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded getWelcomeUser() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Connexion',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Expanded getCoopLogo() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Image.asset(
          'assets/images/logo.png',
          width: 300,
        ),
      ),
    );
  }

  Container getBackgroundImg() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: new BoxDecoration(
        color: Color(0xff1375bf),
        image: new DecorationImage(
          image: new AssetImage("assets/images/bg5.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getUsernameTextField(),
              SizedBox(
                height: 15,
              ),
              getPasswordTextField(),
              // SizedBox(
              //   height: 10,
              // ),
              // InkWell(
              //   child: Text(
              //     'Mot de passe oublier?',
              //     style: TextStyle(
              //         fontSize: 14,
              //         decoration: TextDecoration.underline,
              //         color: Colors.blue),
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 70,
                  child: RaisedButton(
                    disabledColor: Consts.mainColor,
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              var goToSecurityScreen =
                                  !Provider.of<BaseModel>(context)
                                      .wasAuthWithSecurityCode();

                              await Future.delayed(const Duration(seconds: 3));
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => goToSecurityScreen
                                          ? new PinCodeVerificationScreen(
                                              '939-241-2976')
                                          : new MyHomePage()));
                            }
                          },
                    color: Consts.secondColor,
                    elevation: 6,

                    child: !_isLoading
                        ? Text(
                            'Se connecter',
                            style: TextStyle(
                                fontSize: 19,
                                color: Consts.blackColor,
                                fontWeight: FontWeight.w500),
                          )
                        : SpinKitThreeBounce(
                            color: Colors.white,
                            size: 25,
                          ),
                    // increaseHeightBy: 25,
                    // increaseWidthBy: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container getPasswordTextField() {
    return Container(
        height: 50,
        child: TextFormField(
          enabled: !_isLoading,
          initialValue: 'test1234',
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              prefixIcon: Icon(Icons.security),
              labelText: 'password'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          obscureText: !_showPassword,
        ));
  }

  Container getUsernameTextField() {
    return Container(
        height: 50,
        child: TextFormField(
          enabled: !_isLoading,
          initialValue: 'Melissa Kouadio',
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              labelText: 'username'),
          validator: (value) {
            if (value.isEmpty) return 'Please enter your username';

            return null;
          },
      ));
  }
}
