import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_management/models/user.dart';

class DatabaseService {
  final SQL_CREATE_USERS =
      'CREATE TABLE Users(id TEXT PRIMARY KEY, name TEXT, email TEXT, age INTEGER)';
  final SQL_SELECT_ALL_USER = 'SELECT * FROM USERS';
  final SQL_INSERT_USER =
      'INSERT INTO USERS (id, name, email, age) VALUE (?, ?, ?, ?)';
  final SQL_UPDATE_USER =
      'UPDATE USERS SET name = ?, email = ?, age = ? WHERE id = ?';
  final SQL_DELETE_USER = 'DELETE FROM USERS WHERE id = ?';

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
    String pathdb = join(getDirectory, 'users.db');
    print('DB Path: $pathdb');

    return openDatabase(
      pathdb,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database database, int version) {
    database.execute(SQL_CREATE_USERS);
  }

  //Raw query
  Future<List<UserModel>> getUsersRaw() async {
    Database db = await _databaseService.database;
    var data = await db.rawQuery(SQL_SELECT_ALL_USER);
    List<UserModel> users =
        List.generate(data.length, (index) => UserModel.formJson(data[index]));
    return users;
  }

  Future<void> insertUserRaw(UserModel user) async {
    Database db = await _databaseService.database;
    db.rawInsert(SQL_INSERT_USER, [user.id, user.name, user.email, user.age]);
  }

  Future<void> updateUserRaw(UserModel user) async {
    Database db = await _databaseService.database;
    db.rawUpdate(SQL_UPDATE_USER, [user.name, user.email, user.age, user.id]);
  }

  Future<void> deleteUserRaw(UserModel user) async {
    Database db = await _databaseService.database;
    db.rawDelete(SQL_DELETE_USER, [user.id]);
  }
}
