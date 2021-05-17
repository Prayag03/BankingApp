import 'package:bankingapp/pages/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:bankingapp/pages/Transactions.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final dbhelper = Databasehelper.instance;

  TextEditingController nc = TextEditingController();
  TextEditingController ec = TextEditingController();
  TextEditingController ac = TextEditingController();
  TextEditingController mn = TextEditingController();
  bool validated = true;
  String errtext = "";
  String name = "";
  String email = "";
  double balance;
  double mobileNo;
  var myitems = List();
  List<Widget> children = new List<Widget>();

  void adddetails() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: name,
      Databasehelper.columnEmail: email,
      Databasehelper.columnMobile: mobileNo,
      Databasehelper.columnBalance: balance,
    };
    final id = await dbhelper.insert(row);
    print(id);
    Navigator.pop(context);
    name = "";
    email = "";
    mobileNo = 0;

    setState(() {
      validated = true;
      errtext = "";
    });
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

  void initState() {
    super.initState();
    queryall();
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(
        ExpansionCard(
          borderRadius: 20.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          title: Container(
            child: ListTile(
                title: Text(
                  row['name'],
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  row['email'],
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onLongPress: () {
                  dbhelper.deletedata(row['id']);
                  setState(() {});
                }),
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Balance: ${row['balance']}',
                    //textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Mobile No: ${row['mobileNo']}',
                    //textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: RaisedButton(
                      onPressed: () {
                        print(myitems);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Transactions(
                                    balance: row['balance'],
                                    email: row['email'])));
                      },
                      color: Colors.blue,
                      child: Text(
                        "PAY",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
    return Future.value(true);
  }

  void showalertdialog() {
    nc.text = "";
    ec.text = "";
    ac.text = "";
    mn.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(
                "Add Customer",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nc,
                    autofocus: true,
                    onChanged: (_val) {
                      name = _val;
                    },
                    decoration: InputDecoration(
                      errorText: validated ? null : errtext,
                      border: OutlineInputBorder(),
                      hintText: 'Enter the name',
                    ),
                  ),
                  TextField(
                    controller: ec,
                    //autofocus: true,
                    onChanged: (_val) {
                      email = _val;
                    },
                    decoration: InputDecoration(
                        errorText: validated ? null : errtext,
                        border: OutlineInputBorder(),
                        hintText: 'Enter the email'),
                  ),
                  TextField(
                    controller: ac,
                    //autofocus: true,
                    onChanged: (_val) {
                      balance = double.parse(_val);
                    },
                    decoration: InputDecoration(
                        errorText: validated ? null : errtext,
                        border: OutlineInputBorder(),
                        hintText: 'Enter the amount'),
                  ),
                  TextField(
                    controller: mn,
                    //autofocus: true,
                    onChanged: (_val) {
                      mobileNo = double.parse(_val);
                    },
                    decoration: InputDecoration(
                        errorText: validated ? null : errtext,
                        border: OutlineInputBorder(),
                        hintText: 'Enter the Mobile Number'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Colors.purple,
                          onPressed: () {
                            adddetails();
                          },
                          child: Text(
                            "Add Data",
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text(
              "No Data",
            ),
          );
        } else {
          if (myitems.length == 0) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showalertdialog();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.purple,
              ),
              backgroundColor: Colors.grey[700],
              appBar: AppBar(
                title: Text(
                  "Customers",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                elevation: 10,
              ),
              body: Center(
                child: Text(
                  "No Customers Available!!",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showalertdialog();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.purple,
              ),
              backgroundColor: Colors.grey[600],
              appBar: AppBar(
                title: Text(
                  "Customers",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                elevation: 10,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
