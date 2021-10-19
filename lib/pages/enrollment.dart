import 'package:country_code_picker/country_code_picker.dart';
import 'package:jourdainPay/pages/login.dart';
import 'package:jourdainPay/utils/consts.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Enrollment extends StatefulWidget {
  Enrollment({Key key}) : super(key: key);

  @override
  _EnrollmentState createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> {
  int _currentStep = 0;
  List<AssetEntity> images = List<AssetEntity>();

    /*
   *******************************************
   * INITIALISATION UPLOAD CREATION
   * 
   ********************************************/
  Future<void> loadAssets() async {
    String error = 'No Error Dectected';
    int maxImage = 4;
    try {
      List<AssetEntity> assets = await AssetPicker.pickAssets(context,
          maxAssets: maxImage,
          themeColor: Color(0xffE9995D),
      );
       setState(() {
          images = assets;
        });
        // _uploadImage();
            // if(images.length==0){
            //     print("images is empty");
            // } else {
            //   setState(() {
            //     wait = true;
            //   });
              
            // }
      } on Exception catch (e) {
        error = e.toString();
        print("Erreur Creations photo " + error);
      }

      print(images);
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: new Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (int step) => setState(() => _currentStep = step),
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else if (_currentStep == 2) {
            showDialog(context);
          }
        },
        onStepCancel: _currentStep > 0
            ? () => setState(() => _currentStep -= 1)
            : () => Navigator.pop(context),
        steps: <Step>[
          new Step(
            // subtitle: Text('provide_personal'),
            title: new Text('Information personnelle'),
            content: Column(
              children: <Widget>[
                TextFormField(
                   keyboardType: TextInputType.name,
                  decoration: new InputDecoration(
                    labelText: 'Nom',
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                   keyboardType: TextInputType.name,
                  decoration: new InputDecoration(
                    labelText: 'Prénoms',
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                   keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    labelText: 'Mail',
                    icon: Icon(Icons.mail),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    labelText: 'Lieu d\'habitation',
                    icon: Icon(Icons.home),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 40,
                  child:
                  InkWell(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Icon(Icons.add_location_alt_rounded,color: Colors.grey[600]),
                      Text("Pays  ",style: TextStyle(color: Colors.grey[700]),),
                      CountryCodePicker(
                      onChanged: print,
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'CI',
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                    ],),
                  onTap: null
                )),
                 Container(
                    width: 300,
                    margin: EdgeInsets.only(left:33),
                    padding: EdgeInsets.only(bottom:12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1),
                      ),
                    )),
              // //  TextFormField(
              // //     keyboardType: TextInputType.text,
              // //     decoration: new InputDecoration(
              // //       labelText: 'Pays',
              // //       icon: Icon(Icons.add_location_alt_rounded),
              // //     ),
              // //   ),
                SizedBox(
                  height: 10,
                ),
                 TextFormField(
                   keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Téléphone',
                    icon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            isActive: _currentStep == 0,
            state: getState(myPosition: 0, currentStep: _currentStep),
          ),
          new Step(
            title: new Text('Ajout de fichier'),
            content: Column(
              children: <Widget>[
                 Container(
                  // height: 40,
                  child:
                  InkWell(
                    child: 
                    Column(
                      children:[
                        Row(
                          children: [
                            Icon(Icons.camera_alt, color: Colors.grey),
                            Text(" Photo votre carte nationale"),
                          ],),
                          SizedBox(height:20),
                         Row(
                          children: [
                            Icon(Icons.camera_alt, color: Colors.grey),
                            Text("   Selfie avec votre carte nationale"),
                            ],),  
                        ]
                      ),
                    onTap: loadAssets,
                  ),
                  
                  ),
                // TextFormField(
                //   decoration: new InputDecoration(
                //     labelText: 'Photo de pièce d\'identité',
                //     icon: Icon(Icons.camera_enhance),
                //   ),
                //   onTap: loadAssets,
                // ),
              
                SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   decoration: new InputDecoration(
                //     labelText: 'Selfie avec votre carte nationale',
                //     icon: Icon(Icons.camera_enhance),
                //   ),
                // ),
              ],
            ),
            isActive: _currentStep == 1,
            state: getState(myPosition: 1, currentStep: _currentStep),
          ),
          new Step(
            title: new Text('Information de connexion'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'username',
                    icon: Icon(Icons.supervised_user_circle),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'password',
                    icon: Icon(Icons.security),
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 2,
            state: getState(myPosition: 2, currentStep: _currentStep),
          ),
        ],
      ),
    );
  }

  void showDialog(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );
    Alert(
      closeFunction: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => new Login()));
      },
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: 'enrollment_success',
      buttons: [
        DialogButton(
          color: Consts.mainColor,
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => new Login()));
          },
        )
      ],
    ).show();
  }
}

StepState getState({int currentStep, int myPosition}) {

  if (myPosition == currentStep) return StepState.editing;

  if (myPosition < currentStep) return StepState.complete;

  if (myPosition > currentStep) return StepState.disabled;

  return null;
}
