import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/metric_data.dart';

class DataBaseService {
  static const _databaseName = "MentisAiDB.db";
  static const _databaseVersion = 1;
  static const tableName = 'daily_metrics';

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
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY, 
        date TEXT NOT NULL UNIQUE, 
        steps INTEGER NOT NULL,
        calories INTEGER NOT NULL,
        sleepQuality REAL NOT NULL
      )
      ''');
  }

  Future<int> insertMetric(MetricData metric) async {
    final db = await database;
    return await db.insert(
      tableName,
      metric.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<MetricData?> getMetricByDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
    );

    if (maps.isNotEmpty) {
      return MetricData.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> seedDatabase() async {
    final db = await database;

    await db.delete(tableName);

    final now = DateTime.now().toUtc().copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final dateString = date.toIso8601String().split('T').first; 

      
      final steps = 10000 - (i * 500) + (i % 2 == 0 ? 300 : -200); 
      final calories = 2500 - (i * 50);
      final sleepQuality = (0.9 - (i * 0.05)).clamp(0.4, 0.9); 

      final data = MetricData(
        date: dateString,
        steps: steps.toInt(),
        calories: calories,
        sleepQuality: sleepQuality,
      );

      await db.insert(
        tableName,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

