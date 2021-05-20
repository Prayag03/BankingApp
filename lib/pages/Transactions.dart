import 'package:bankingapp/main.dart';
import 'package:bankingapp/pages/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:bankingapp/pages/Customers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bankingapp/pages/History.dart';
import 'dart:async';
import 'dart:io';

class Transactions extends StatefulWidget {
  final String email;
  final double balance;

  const Transactions({Key key, this.email, this.balance}) : super(key: key);
  @override
  _TransactionsState createState() => _TransactionsState(email, balance);
}

class _TransactionsState extends State<Transactions> {
  final dbhelper = Databasehelper.instance;

  TextEditingController se = TextEditingController();
  TextEditingController re = TextEditingController();
  TextEditingController am = TextEditingController();
  final String email;
  final double balance;
  bool validated = true;
  String semail = "";
  String remail = "";
  String errtext = "";
  double payamount = 0;
  double amount = 0;
  bool validate = true;

  _TransactionsState(this.email, this.balance);

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

  void adddetails() async {
    Map<String, dynamic> row = {
      Databasehelper.columnSEmail: email,
      Databasehelper.columnREmail: re.text,
      Databasehelper.columnAmount: double.parse(am.text),
    };
    final id = await dbhelper.insert2(row);
    print(id);
    Navigator.pop(context);
    semail = "";
    remail = "";
    amount = 0;
  }

  void initState() {
    super.initState();
    se.text = email;
  }

  void updatedata(String email, double balance) async {
    var row = await dbhelper.updatedata(email, balance);
    print(email);
  }

  void updatedata2(String email, double balance) async {
    var row = await dbhelper.updatedata2(email, balance);
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transaction"),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    controller: se,
                    autofocus: true,
                    onChanged: (_val) {
                      semail = _val;
                    },
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: "Enter the Sender's email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    controller: re,
                    onChanged: (_val) {
                      remail = _val;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the Receiver's email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    controller: am,
                    onChanged: (_val) {
                      payamount = double.parse(_val);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the Amount",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: RaisedButton(
                    onPressed: () {
                      updatedata(email, balance - double.parse(am.text));
                      print('------');
                      print(email);
                      print('------');
                      print(balance);
                      print('------');
                      updatedata2(re.text, balance + double.parse(am.text));
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                          adddetails();
                    },
                    color: Colors.blue,
                    child: Text(
                      "TRANSFER",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
