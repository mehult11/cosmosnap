import 'package:nasa_apod/NASAPicture.dart';
import 'package:nasa_apod/Database/DBHelper.dart';
import 'package:sqflite/sqlite_api.dart';
class NASAPictureDao{
  final String myFavoriteTable = "MyFavourite";
  Future<Database> getDataBaseHandler() async {
    final dbHelper = DBHelper.singleInstance;
    final db = await dbHelper.database;
    return db;
  }

  Future<int> addImageToDB(NASAPicture image) async{
    Database db = await getDataBaseHandler();
    int futureId = await db.insert(
      myFavoriteTable,
      image.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Image added successfully");
    return futureId;
  }

  Future<int> removeImageFromDB(String date) async{
    Database db = await getDataBaseHandler();
    int futureId = await db.delete(
        myFavoriteTable,
        where: " date = ?",
        whereArgs: [date]
    );
    print("Image Deleted successfully");
    return futureId;
  }

  Future<List<NASAPicture>> getAllImagesFromDB() async{
    Database db = await getDataBaseHandler();
    List<Map<String, dynamic>> maps  = await db.rawQuery("SELECT * From $myFavoriteTable");
    List<NASAPicture> images = [];
    images = List.generate(maps.length, (i) {
      return NASAPicture.fromJson(maps[i]);
    });
    return images;
  }

  Future<bool> checkImageIsExist(String date) async{
    Database db = await getDataBaseHandler();
    try{
      final result = await db.query(
        myFavoriteTable,
        where: 'date = ?',
        whereArgs: [date],
        limit: 1,
      );
      return (result.isEmpty)?false:true;
    }catch(e){
      print(e);
      return false;
    }
  }

}