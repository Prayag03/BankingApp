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
  String email;
  double balance;

  void showdata(String email, double balance) async {
    var row = await dbhelper.updatedata(email, balance);
    print(email);
  }

  void initState() {
    super.initState();
    se.text = email;
    //re.text =
  }

  final db = Databasehelper.instance;
  var allrows;
  List<Map<String, dynamic>> items = List<Map<String, dynamic>>();
  void queryall() async {
    allrows = await db.queryall();
    allrows.forEach((element) {
      items.add(element);
    });
    /*print('===================');
    print(items);
    print('===================');*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionCard(
        borderRadius: 20.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        title: Container(
          child: ListTile(
            title: Text(
              'From: ${se.text}',
              style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              '##', //row['email'],
              style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            /*onLongPress: () {
                  dbhelper.deletedata(row['id']);
                  setState(() {});
                }*/
          ),
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "##", //'Balance:${row['balance']}',
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
