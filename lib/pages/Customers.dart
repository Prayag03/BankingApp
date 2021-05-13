import 'package:bankingapp/pages/dbhelper.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final dbhelper = Databasehelper.instance;

  TextEditingController nc = TextEditingController();
  TextEditingController ec = TextEditingController();
  TextEditingController ac = TextEditingController();
  bool validated = true;
  String errtext = "";
  String name = "";
  String email = "";
  double amount;
  var myitems = List();
  List<Widget> children = new List<Widget>();

  void adddetails() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: name,
      Databasehelper.columnEmail: email,
      Databasehelper.columnAmount: amount
    };
    final id = await dbhelper.insert(row);
    print(id);
    Navigator.pop(context);
    name = "";
    email = "";
    amount = 0;
    setState(() {
      validated = true;
      errtext = "";
    });
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(
        Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                row['name'],
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                row['email'],
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 15.0,
                ),
              ),
              trailing: Text(
                row['amount'],
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 15.0,
                ),
              ),
              //isThreeLine: true,
              //dense: true,
              onLongPress: () {
                dbhelper.deletedata(row['id']);
                setState(() {});
              },
            ),
          ),
        ),
      );
    });
    return Future.value(true);
  }

  void showalertdialog() {
    nc.text = "";
    ec.text = "";
    ac.text = "";
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
                      amount = double.parse(_val);
                    },
                    decoration: InputDecoration(
                        errorText: validated ? null : errtext,
                        border: OutlineInputBorder(),
                        hintText: 'Enter the amount'),
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
                            if (nc.text.isEmpty ||
                                ec.text.isEmpty ||
                                ac.text.isEmpty) {
                              setState(() {
                                errtext = "Can't be empty";
                                validated = false;
                              });
                            } else if (nc.text.length > 512 ||
                                ec.text.length > 512 ||
                                ac.text.length > 10) {
                              setState(() {
                                errtext = "Too Many Characters";
                                validated = false;
                              });
                            } else {
                              adddetails();
                            }
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

  Widget mycard(String name, String email, double amount) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            '$name',
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            "$email",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 15.0,
            ),
          ),
          trailing: Text(
            "INR $amount",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 15.0,
            ),
          ),
          //isThreeLine: true,
          //dense: true,
          onLongPress: () {
            print("Delete thavu joie");
          },
        ),
      ),
    );
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
              backgroundColor: Colors.grey[700],
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

/*
Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            mycard("Shiladitya Gohil", "abv@gmail.com", 5000),
            mycard("Eha Gohil", "123@gmail.com", 5000),
            mycard("Ha moj ha Gohil", "dfc@gmail.com", 5000),
            mycard("Aditya Gohil", "ggs@gmail.com", 5000),
            mycard("Haalo Gohil", "fhv@gmail.com", 5000),
            mycard("Aditya Gohil", "ggs@gmail.com", 5000),
            mycard("Aditya Gohil", "ggs@gmail.com", 5000),
            mycard("Aditya Gohil", "ggs@gmail.com", 5000),
            mycard("Aditya Gohil", "ggs@gmail.com", 5000),
            mycard("Aditya Gohil", "ggs@gmail.com", 5000),
          ],
        ),
      ),
    );*/
