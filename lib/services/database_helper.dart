import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_info.dart';

class DatabaseHelper {
  //생성자. 내부에서만 객체 생성이 가능하다.
  //싱글톤으로 유지
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  //db 초기화
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('user_info.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    db.execute('''
      CREATE TABLE user_info(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        profileImagePath TEXT
      )
    '''
    );
  }

  //위젯에서 dbms 자겅ㅂ으 위해 호출할 함수
  Future<void> insertOrUpdateUser(UserInfo userInfo) async{
    final db = await instance.database;

    await db.delete('user_info'); //테이블 데이터 삭제
    await db.insert('user_info', userInfo.toMap()); //새로운 데이터 저장
  }

  //db 저장 데이터 획득
  Future<UserInfo?> getUser() async{
    final db = await instance.database;
    final maps = await db.query('user_info');

    if(maps.isNotEmpty) return UserInfo.fromMap(maps.first);

    return null;
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}