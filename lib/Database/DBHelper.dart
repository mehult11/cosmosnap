import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper{
  static final _databaseVersion = 1;


  DBHelper._();
  static final DBHelper singleInstance = DBHelper._();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await init();
    return _database!;
  }

  init() async {
    // For Androind & iOS Both
    String path = await getDatabasesPath();
    String dbPath = join(path, "nasapod.db");
    var database = await openDatabase(dbPath,
        onOpen: (db) {},
        version: _databaseVersion,
        onCreate: _onCreate,);
    return database;
  }


  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE MyFavourite ("
        "date TEXT PRIMARY KEY,"
        "title TEXT,"
        "url TEXT,"
        "explanation TEXT,"
        "media_type TEXT"
        " )");
  }

}