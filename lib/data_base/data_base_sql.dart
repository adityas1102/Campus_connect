import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:campus_connect/model/student.dart';

class DataBaseSql {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');
    print(' DataBase Path: $path');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            department TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertStudent(Student student) async {
    final dbClient = await db;
    await dbClient.insert('students', student.toMap());
  }

  static Future<List<Student>> getStudents() async {
    final dbClient = await db;
    final maps = await dbClient.query('students');
    return List.generate(maps.length, (i) => Student.fromMap(maps[i]));
  }
}
