import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactDB {
  static final ContactDB _instance = ContactDB._internal();
  static Database? _database;

  ContactDB._internal();

  factory ContactDB() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ContactDB.db');
    print('Database path: $path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phoneNumber TEXT,
        email TEXT
      )
    ''');
  }

  Future<int> insertContact(Map<String, dynamic> contact) async {
    Database db = await database;
    return await db.insert('contacts', contact);
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    Database db = await database;
    return await db.query('contacts');
  }

  Future<List<Map<String, dynamic>>> searchContacts(String query) async {
    Database db = await database;
    return await db.query(
      'contacts',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }
}
