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
    return Scaffold(
      backgroundColor: Colors.grey[700],
        appBar: AppBar(title: Text('Transaction History')),
        body: RefreshIndicator(
          onRefresh: (){
            setState(() {
              items;
            });
            return Future.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new Card(
                  color:Colors.cyanAccent[100],
                  child: ExpansionTile(
                    title: Text(
                      '\nSender:\t\t\t\t${items[index]['semail']}\n\nReceiver:\t${items[index]['remail']}\n',
                      style:
                          TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Amount:${items[index]['amount']}',
                          style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
      /*backgroundColor: Colors.grey[700],
      appBar: AppBar(
          title: Text("Transaction History"),
        ),
      body: Container(
        child: ExpansionCard(
          borderRadius: 20.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          title: Container(
            child: ListTile(
              title: Text(
                'Sender: ${'semail'}',
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Receiver: ${['remail']}',
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
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
                    'Amount: ${['amount']}',
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
      ),
    );*/

  }
}
