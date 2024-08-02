import 'dart:async';

import 'package:laptop_management/models/laptop.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final SQL_CREATE_LAPTOPS =
      'CREATE TABLE LAPTOPS(id TEXT PRIMARY KEY, model TEXT, price TEXT, thin INTEGER)';
  final SQL_SELECT_ALL_LAPTOP = 'SELECT * FROM LAPTOPS';
  final SQL_INSERT_LAPTOP =
      'INSERT INTO LAPTOPS(id, model, price, thin) VALUE (?, ?, ?, ?)';
  final SQL_UPDATE_LAPTOP =
      'UPDATE LAPTOPS SET model = ?, price = ?, thin = ? WHERE id = ?';
  final SQL_DELETE_LAPTOP = 'DELETE FROM LAPTOPS WHERE id = ?';

  static DatabaseService _databaseService = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getDatabasesPath();
    String pathdb = join(getDirectory, 'laptops.db');
    print('DB Path: $pathdb');

    return openDatabase(
      pathdb,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database database, int version) {
    database.execute(SQL_CREATE_LAPTOPS);
  }

  //RAW QUERRY
  Future<List<LaptopModel>> getLaptopsRaw() async {
    Database db = await _databaseService.database;
    var data = await db.rawQuery(SQL_SELECT_ALL_LAPTOP);
    List<LaptopModel> laptops =
        List.generate(data.length, (index) => LaptopModel.formJson(data[index]));
    return laptops;
  }

  Future<void> inserLaptopRaw(LaptopModel laptop) async {
    Database db = await _databaseService.database;
    db.rawInsert(SQL_INSERT_LAPTOP, [laptop.id, laptop.model, laptop.price, laptop.thin]);
  }

  Future<void> updateLaptopRaw(LaptopModel laptop) async {
    Database db = await _databaseService.database;
    db.rawUpdate(SQL_UPDATE_LAPTOP, [laptop.model, laptop.price, laptop.thin, laptop.id]);
  }

  Future<void> deleteLaptopRaw(LaptopModel laptop) async {
    Database db = await _databaseService.database;
    db.rawDelete(SQL_DELETE_LAPTOP, [laptop.id]);
  }

  //MODEL
  Future<List<LaptopModel>> getLaptops() async {
    Database db = await _databaseService.database;
    var data = await db.query('LAPTOPS');
    List<LaptopModel> laptops =
        List.generate(data.length, (index) => LaptopModel.formJson(data[index]));
    return laptops;
  }

  Future<void> insertLaptop(LaptopModel laptop) async {
    Database db = await _databaseService.database;
    var result = await db.insert('LAPTOPS', laptop.toMap());
    if (result == 0) {
      print('Insert laptop error');
    } else {
      print('Insert laptop successed');
    }
  }

  Future<void> updateLaptop(LaptopModel laptop) async {
    Database db = await _databaseService.database;
    db.update('LAPTOPS', laptop.toMap(), where: 'id = ?', whereArgs: [laptop.id]);
  }

  Future<void> deleteLaptop(String id) async {
    Database db = await _databaseService.database;
    db.delete('LAPTOPS', where: 'id = ?', whereArgs: [id]);
  }
}
