import 'package:flutter/material.dart';
import 'package:jourdainPay/pages/home.dart';
import 'package:jourdainPay/pages/payments.dart';
import 'package:jourdainPay/pages/settings.dart';
import 'package:jourdainPay/utils/consts.dart';

import 'activate_card.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             SizedBox(
              height: 30.0,
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 10.0),
            //   child: FlatButton.icon(
            //     icon: Icon(
            //       Icons.arrow_back,
            //       color: Color(0xFF015FFF),
            //     ),
            //     onPressed: null,
            //     label: Text("Back",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 16.0,
            //             color: Colors.black)),
            //     color: Colors.black,
            //   ),
            // ),
            buildMenuItem(Icons.account_balance, "MON COMPTE",
            MyHomePage(),
                opacity: 1.0, color: Consts.mainColor),
            Divider(),    
            buildMenuItem(Icons.credit_card_rounded, "ACHETER UNE CARTE",MyHomePage(),),   
            Divider(),
            buildMenuItem(Icons.receipt, "RECHARGER UNE CARTE",MyHomePage(),),
            Divider(),
            buildMenuItem(Icons.compare_arrows, "EXCHANGE",MyHomePage(),),
            Divider(),
            buildMenuItem(Icons.phone, "SUPPORT",MyHomePage(),),
            Divider() ,
            
            buildMenuItem(Icons.account_circle_outlined, "PROFIL",MyHomePage(),),
            Divider(),
          ],
        ),
      ),
    );
  }

  Opacity buildMenuItem(IconData icon, String title,routename,
      {double opacity = 0.3, Color color = Colors.black}) {
    return Opacity(
      opacity: opacity,
      child: InkWell(
        onTap: (){
          if(routename !=null)
           {
             Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => routename));
           }
          
        },
        child:
      Center(
        child: Column(
          children: <Widget>[
           
            Icon(
              icon,
              size: 50.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 13.0, color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    ));
  }
}
