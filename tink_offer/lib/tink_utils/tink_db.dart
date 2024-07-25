import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tink_offer/tink_models/tink_credential_model.dart';
import 'package:tink_offer/tink_models/tink_event_model.dart';
import 'package:tink_offer/tink_models/tink_payment_model.dart';
import 'package:tink_offer/tink_models/tink_private_model.dart';

class TinkDBHelper {
  static final _dbHelper = TinkDBHelper._createInstance();

  Database? _db = null;

  TinkDBHelper._createInstance();

  factory TinkDBHelper() {
    return _dbHelper;
  }

  Future<Database> get database async {
    _db ??= await initDb();

    return _db!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'tink.db');

    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  // Если бд нет в директории прилы, то создаем ее
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE Payments (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, amount TEXT, info TEXT, day TEXT, month TEXT, year TEXT, time TEXT, remind TEXT)');
    await db.execute(
        'CREATE TABLE Events (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, info TEXT, day TEXT, month TEXT, year TEXT, time TEXT, remind TEXT)');
    await db.execute(
        'CREATE TABLE PrivateInfo (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, note TEXT)');
    await db.execute(
        'CREATE TABLE Credentials (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, note TEXT, login TEXT, pass TEXT)');
  }

  Future<int> addTinkPayment(TinkPaymentModel tinkPaymentModel) async {
    Database db = await database;
    int result = await db.insert('Payments', tinkPaymentModel.toTinkMap());

    return result;
  }

  Future<int> addTinkEvent(TinkEventModel tinkEventModel) async {
    Database db = await database;
    int result = await db.insert('Events', tinkEventModel.toTinkMap());

    return result;
  }

  Future<int> addTinkPrivate(TinkPrivateModel tinkPrivateModel) async {
    Database db = await database;
    int result = await db.insert('PrivateInfo', tinkPrivateModel.toTinkMap());

    return result;
  }

  Future<int> addTinkCredentail(TinkCredentailModel tinkCredentailModel) async {
    Database db = await database;
    int result =
        await db.insert('Credentials', tinkCredentailModel.toTinkMap());

    return result;
  }

  Future<int> deteleTinkPayment(TinkPaymentModel tinkPaymentModel) async {
    Database db = await database;
    int result = await db
        .delete('Payments', where: 'id = ?', whereArgs: [tinkPaymentModel.id]);

    return result;
  }

  Future<int> deteleTinkEvent(TinkEventModel tinkEventModel) async {
    Database db = await database;
    int result = await db
        .delete('Events', where: 'id = ?', whereArgs: [tinkEventModel.id]);

    return result;
  }

  Future<int> deteleTinkPrivate(TinkPrivateModel tinkPrivateModel) async {
    Database db = await database;
    int result = await db.delete('PrivateInfo',
        where: 'id = ?', whereArgs: [tinkPrivateModel.id]);

    return result;
  }

  Future<int> deteleTinkCredentail(
      TinkCredentailModel tinkCredentailModel) async {
    Database db = await database;
    int result = await db.delete('Credentials',
        where: 'id = ?', whereArgs: [tinkCredentailModel.id]);

    return result;
  }

  Future<int> updateTinkPayment(TinkPaymentModel tinkPaymentModel) async {
    Database db = await database;
    int result = await db.update('Payments', tinkPaymentModel.toTinkMap(),
        where: 'id = ?', whereArgs: [tinkPaymentModel.id]);

    return result;
  }

  Future<int> updateTinkEvent(TinkEventModel tinkEventModel) async {
    Database db = await database;
    int result = await db.update('Events', tinkEventModel.toTinkMap(),
        where: 'id = ?', whereArgs: [tinkEventModel.id]);

    return result;
  }

  Future<int> updateTinkPrivate(TinkPrivateModel tinkPrivateModel) async {
    Database db = await database;
    int result = await db.update('PrivateInfo', tinkPrivateModel.toTinkMap(),
        where: 'id = ?', whereArgs: [tinkPrivateModel.id]);

    return result;
  }

  Future<int> updateTinkCredentail(
      TinkCredentailModel tinkCredentailModel) async {
    Database db = await database;
    int result = await db.update('Credentials', tinkCredentailModel.toTinkMap(),
        where: 'id = ?', whereArgs: [tinkCredentailModel.id]);

    return result;
  }

  Future<List<TinkPaymentModel>> getAllPaymnets(
      String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'month = ? and year = ?',
        whereArgs: [selMonth, selYear],
        orderBy: 'id DESC');

    return mapList.map((e) => TinkPaymentModel.fromTinkMap(e)).toList();
  }

  Future<int> getAllPaymnetsRent(String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'month = ? and year = ? and type = ?',
        columns: ['amount'],
        whereArgs: [selMonth, selYear, 'Rent'],
        orderBy: 'id DESC');

    final list = mapList.map((e) => int.parse(e['amount'])).toList();

    if (list.isEmpty) {
      return 0;
    } else if (list.length == 1) {
      return list.first;
    } else {
      return list.reduce((a, b) => a + b);
    }
  }

  Future<int> getAllPaymnetsSalary(String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'month = ? and year = ? and type = ?',
        columns: ['amount'],
        whereArgs: [selMonth, selYear, 'Salary'],
        orderBy: 'id DESC');

    final list = mapList.map((e) => int.parse(e['amount'])).toList();

    if (list.isEmpty) {
      return 0;
    } else if (list.length == 1) {
      return list.first;
    } else {
      return list.reduce((a, b) => a + b);
    }
  }

  Future<int> getAllPaymnetsCredit(String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'month = ? and year = ? and type = ?',
        columns: ['amount'],
        whereArgs: [selMonth, selYear, 'Credit'],
        orderBy: 'id DESC');

    final list = mapList.map((e) => int.parse(e['amount'])).toList();

    if (list.isEmpty) {
      return 0;
    } else if (list.length == 1) {
      return list.first;
    } else {
      return list.reduce((a, b) => a + b);
    }
  }

  Future<int> getAllPaymnetsAnother(String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'month = ? and year = ? and type = ?',
        columns: ['amount'],
        whereArgs: [selMonth, selYear, 'Another'],
        orderBy: 'id DESC');

    final list = mapList.map((e) => int.parse(e['amount'])).toList();

    if (list.isEmpty) {
      return 0;
    } else if (list.length == 1) {
      return list.first;
    } else {
      return list.reduce((a, b) => a + b);
    }
  }

  Future<List<TinkPaymentModel>> getAllPaymnetsDaily(
      String selDay, String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'day = ? and month = ? and year = ?',
        whereArgs: [selDay, selMonth, selYear],
        orderBy: 'id DESC');

    return mapList.map((e) => TinkPaymentModel.fromTinkMap(e)).toList();
  }

  Future<List<String>> getAllPaymnetsDate(
      String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Payments',
        where: 'month = ? and year = ?',
        columns: ['day'],
        whereArgs: [selMonth, selYear],
        orderBy: 'id DESC');

    return mapList.map((e) => e['day'].toString()).toList();
  }

  Future<List<TinkEventModel>> getAllEvents(
      String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Events',
        where: 'month = ? and year = ?',
        distinct: true,
        whereArgs: [selMonth, selYear],
        orderBy: 'id DESC');

    return mapList.map((e) => TinkEventModel.fromTinkMap(e)).toList();
  }

  Future<List<TinkEventModel>> getAllEventsDaily(
      String selDay, String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Events',
        where: 'day = ? and month = ? and year = ?',
        distinct: true,
        whereArgs: [selDay, selMonth, selYear],
        orderBy: 'id DESC');

    return mapList.map((e) => TinkEventModel.fromTinkMap(e)).toList();
  }

  Future<List<String>> getAllEventsDate(String selMonth, String selYear) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('Events',
        where: 'month = ? and year = ?',
        distinct: true,
        columns: ['day'],
        whereArgs: [selMonth, selYear],
        orderBy: 'id DESC');

    return mapList.map((e) => e['day'].toString()).toList();
  }

  Future<List<TinkPrivateModel>> getAllPrivates() async {
    Database db = await database;
    List<Map<String, dynamic>> mapList =
        await db.query('PrivateInfo', orderBy: 'id DESC');

    return mapList.map((e) => TinkPrivateModel.fromTinkMap(e)).toList();
  }

  Future<List<TinkCredentailModel>> getAllCredentials() async {
    Database db = await database;
    List<Map<String, dynamic>> mapList =
        await db.query('Credentials', orderBy: 'id DESC');

    return mapList.map((e) => TinkCredentailModel.fromTinkMap(e)).toList();
  }
}
