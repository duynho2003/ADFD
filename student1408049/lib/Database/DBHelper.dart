import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:student1408049/models/Contact.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'ContactDB.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY,
        name TEXT,
        phone TEXT
      )
    ''');

    List<Contact> initialContacts = [
      Contact(name: 'Thuan', phone: '1234567890'),
      Contact(name: 'Dung', phone: '0987654321'),
      // Add more contacts here
    ];

    for (Contact contact in initialContacts) {
      await db.insert('contacts', contact.toMap());
    }
  }

  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
