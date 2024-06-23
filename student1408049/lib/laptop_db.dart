import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LaptopDB {
  static final LaptopDB _instance = LaptopDB._internal();
  static Database? _database;

  LaptopDB._internal();

  factory LaptopDB() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'LaptopDB.db');
    print('Database path: $path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE laptops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price TEXT
      )
    ''');
  }

  Future<int> insertLaptops(Map<String, dynamic> laptop) async {
    Database db = await database;
    return await db.insert('laptops', laptop);
  }

  Future<List<Map<String, dynamic>>> getLaptops() async {
    Database db = await database;
    return await db.query('laptops');
  }

  Future<List<Map<String, dynamic>>> searchLaptops(String query) async {
    Database db = await database;
    return await db.query(
      'laptops',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }

  Future<void> deleteLaptop(int id) async {
    Database db = await database;
    await db.delete(
      'laptops',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
