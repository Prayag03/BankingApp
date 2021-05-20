import 'package:bankingapp/pages/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:bankingapp/pages/Customers.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:expansion_card/expansion_card.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final dbhelper = Databasehelper.instance;

  TextEditingController se = TextEditingController();
  TextEditingController re = TextEditingController();
  TextEditingController am = TextEditingController();
  String semail, remail;
  double amount;

  void initState() {
    super.initState();
    queryall2();
    
  }

  final db = Databasehelper.instance;
  var allrows;
  List<Map<String, dynamic>> items = List<Map<String, dynamic>>();
  void queryall2() async {
    allrows = await db.queryall2();
    allrows.forEach((element) {
      items.add(element);
    });
    print('===================');
    print(items);
    print('===================');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(
            items[index]['semail'],
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.red,
            ),
          );
        });
  }
}
