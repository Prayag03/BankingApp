// packages
import 'dart:io';
import 'package:path/path.dart';
// should install these
// refer description for more
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// the database helper class
class Databasehelper {
  // database name
  static final _databasename = "customers.db";
  static final _databaseversion = 1;

  // the table name
  static final table = "my_table";

  // column names
  static final columnID = 'id';
  static final columnName = "name";
  static final columnEmail = 'email';
  static final columnMobile = 'mobileNo';
  static final columnBalance = 'balance';

  // a database
  static Database _database;

  // privateconstructor
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  // asking for a database
  Future<Database> get databse async {
    if (_database != null) return _database;

    // create a database if one doesn't exist
    _database = await _initDatabase();
    return _database;
  }

  // function to return a database
  _initDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  // create a database since it doesn't exist
  Future _onCreate(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnEmail VARCHAR NOT NULL,
        $columnMobile INTEGER NOT NULL,
        $columnBalance DOUBLE NOT NULL
      );
      ''');
  }

  // functions to insert data
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  // function to query all the rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.databse;
    return await db.query(table);
  }

  // function to delete some data
  Future<int> deletedata(int id) async {
    Database db = await instance.databse;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> updatedata2(String email, double balance) async {
    Database db = await instance.databse;
     int updateCount = await db.update(
        Databasehelper.table,
        { Databasehelper.columnBalance  : balance, },
        where: '${Databasehelper.columnEmail} = ?',
        whereArgs: [email]);
  }
  Future<int> updatedata(String email, double balance) async {
    Database db = await instance.databse;
     int updateCount = await db.update(
        Databasehelper.table,
        { Databasehelper.columnBalance  : balance, },
        where: '${Databasehelper.columnEmail} = ?',
        whereArgs: [email]);
    
  }


  Future<int> showdata(String email, double balance) async {
    Database db = await instance.databse;
     int updateCount = await db.update(
        Databasehelper.table,
        { Databasehelper.columnBalance  : balance, },
        where: '${Databasehelper.columnEmail} = ?',
        whereArgs: [email]);
    
  }
}
