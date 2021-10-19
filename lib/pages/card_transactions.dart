import 'dart:ui';

import 'package:jourdainPay/models/base_model.dart';
import 'package:jourdainPay/utils/consts.dart';
import 'package:jourdainPay/widgets/pie_chart.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatefulWidget {
  TransactionsPage({Key key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  bool _showPieChart = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('transactions'),
      
      ),
      body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: _showPieChart ? 6 : 0,
                child: Column(
                  children: <Widget>[
                    _showPieChart ? PieChartWidget() : Container(),
                    Padding(
                      padding: _showPieChart
                          ? EdgeInsets.all(0)
                          : EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                             heroTag: '2',
                            backgroundColor: Consts.mainColor,
                            child: !_isLoading
                                ? Icon(Icons.refresh)
                                : CircularProgressIndicator(),
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await Future.delayed(const Duration(seconds: 3));

                              setState(() {
                                _isLoading = false;
                              });

                              Provider.of<BaseModel>(context)
                                  .getShuffledList();
                            },
                          ),
                          FlatButton(
                            
                            color: Consts.mainColor,
                            child: _showPieChart
                                ? Text('Cacher le' + " Pie Chart", style: TextStyle(color: Colors.white),)
                                : Text('Afficher' + " Pie Chart", style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              setState(() {
                                _showPieChart = !_showPieChart;
                              });
                            },
                          ),
                          // FloatingActionButton(
                          //   heroTag: '1',
                          //   child: Icon(Icons.filter_list),
                          //   backgroundColor: Consts.mainColor,
                          //   onPressed: () {},
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AnimationLimiter(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: Provider.of<BaseModel>(context)
                          .getTransactions()
                          .length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: Provider.of<BaseModel>(context)
                                  .getTransactions()[index],
                            ),
                          ),
                        );
                      }),
                ),
                ),
              )
            ],
          )),
    );
  }
}
