import 'package:mentis_ai/models/user_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/metric_data.dart';

class DataBaseService {
  static const _databaseName = "MentisAiDB.db";
  static const _databaseVersion = 1;
  static const tableNameUser = 'user';
  static const tableNameMetrics = 'daily_metrics';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    // await db.execute('''
    //   CREATE TABLE $tableNameMetrics (
    //     id INTEGER PRIMARY KEY, 
    //     date TEXT NOT NULL UNIQUE, 
    //     steps INTEGER NOT NULL,
    //     calories INTEGER NOT NULL,
    //     sleepQuality REAL NOT NULL
    //   )
    // ''');

    await db.execute('''
      CREATE TABLE $tableNameUser (
        id INTEGER PRIMARY KEY, 
        gender TEXT NOT NULL,
        dateOfBirth TEXT NOT NULL, 
        maritalStatus TEXT NOT NULL, 
        educationLevel TEXT NOT NULL,
        profession TEXT NOT NULL,
        income REAL NOT NULL, 
        familyArrangement TEXT NOT NULL,
        children TEXT NOT NULL,
        residence TEXT NOT NULL, 
        smartwatch TEXT NOT
      )
    ''');
  }

  Future<int> saveUser(UserData user) async {
    final db = await database;
    return await db.insert(
      tableNameUser, 
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<UserData?> getUser(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableNameUser,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserData.fromMap(maps.first);
    } 
    return null;
  }

  // Future<int> insertMetric(MetricData metric) async {
  //   final db = await database;
  //   return await db.insert(
  //     tableNameMetrics,
  //     metric.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<MetricData?> getMetricByDate(String date) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     tableNameMetrics,
  //     where: 'date = ?',
  //     whereArgs: [date],
  //   );

  //   if (maps.isNotEmpty) {
  //     return MetricData.fromMap(maps.first);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> seedDatabase() async {
  //   final db = await database;

  //   await db.delete(tableNameMetrics);

  //   final now = DateTime.now().toUtc().copyWith(
  //       hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  //   for (int i = 0; i < 7; i++) {
  //     final date = now.subtract(Duration(days: i));
  //     final dateString = date.toIso8601String().split('T').first;

  //     final steps = 10000 - (i * 500) + (i % 2 == 0 ? 300 : -200);
  //     final calories = 2500 - (i * 50);
  //     final sleepQuality = (0.9 - (i * 0.05)).clamp(0.4, 0.9);

  //     final data = MetricData(
  //       date: dateString,
  //       steps: steps.toInt(),
  //       calories: calories,
  //       sleepQuality: sleepQuality,
  //     );

  //     await db.insert(
  //       tableNameMetrics,
  //       data.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   }
  // }
}
