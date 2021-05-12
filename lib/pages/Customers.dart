import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  void showalertdialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter the name',
                    ),
                  ),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter the email'),
                  ),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
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
                          onPressed: () {},
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
            ));
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
    );
  }
}
