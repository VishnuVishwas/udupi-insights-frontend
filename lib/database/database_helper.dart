// lib/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'places_schema.dart';
import 'photos_schema.dart';
import 'bookings_schema.dart';

class DatabaseHelper {
  static final _databaseName = "udupi_insights.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(PlacesSchema.createTable);
    await db.execute(PhotosSchema.createTable);
    await db.execute(BookingsSchema.createTable);
  }

  // check if db tables created or not
  Future<List<String>> getTableNames() async {
    final db = await database;
    final result = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    return result.map((row) => row['name'] as String).toList();
  }

  // get db path
  Future<String> getDatabasePath() async {
    return join(await getDatabasesPath(), _databaseName);
  }

  // CRUD Operations for Places

  Future<int> insertPlace(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('places', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllPlaces() async {
    Database db = await database;
    return await db.query('places');
  }

  Future<int> updatePlace(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('places', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePlace(int id) async {
    Database db = await database;
    return await db.delete('places', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD Operations for Photos

  Future<int> insertPhoto(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('photos', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllPhotos() async {
    Database db = await database;
    return await db.query('photos');
  }

  Future<int> updatePhoto(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('photos', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePhoto(int id) async {
    Database db = await database;
    return await db.delete('photos', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD Operations for Bookings

  Future<int> insertBooking(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('bookings', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllBookings() async {
    Database db = await database;
    return await db.query('bookings');
  }

  Future<int> updateBooking(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('bookings', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBooking(int id) async {
    Database db = await database;
    return await db.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }
}
