import 'package:bankingapp/pages/Customers.dart';
import 'package:bankingapp/pages/Transactions.dart';
import 'package:bankingapp/pages/History.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BankingApp",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text(
          "BankingApp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome to our App!!",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.yellow,
                          splashColor: Colors.grey,
                          child: Text(
                            "View All Customers",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Customers()));
                          },
                        ),
                        RaisedButton(
                          color: Colors.yellow,
                          splashColor: Colors.grey,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => History()));
                          },
                          child: Text(
                            "Transaction History",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ])
                ],
              ),
            ]),
      ),
    );
  }
}
