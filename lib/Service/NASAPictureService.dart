
import 'dart:async';

import 'package:nasa_apod/Entity/NASAPicture.dart';
import 'package:nasa_apod/DatabaseLayer/NASAPictureDao.dart';
import 'package:nasa_apod/WebService/NASAPictureWebService.dart';

class NASAPictureService{

  NASAPictureWebService nasaPictureWebService = NASAPictureWebService();
  NASAPictureDao nasaPictureDao = NASAPictureDao();
  Future<dynamic> getImg(String date) async{
    Completer completer = Completer();
    try{
      Map<String,dynamic> response = await nasaPictureWebService.getImageFromAPI(date);
      NASAPicture picture = NASAPicture.fromJson(response);
      completer.complete(picture);
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }

  addFavImg(NASAPicture image) async {
    Completer completer = Completer();
    try{
      await nasaPictureDao.addImageToDB(image);
      completer.complete();
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }

  removeFavImg(String date) async {
    Completer completer = Completer();
    try{
      await nasaPictureDao.removeImageFromDB(date);
      completer.complete();
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;

  }

  Future<Map<String,dynamic>> getAllFavImg() async{
    Completer<Map<String,dynamic>> completer = Completer<Map<String,dynamic>>();
    nasaPictureDao.getAllImagesFromDB().then((List<NASAPicture> value) {
      Map<String,dynamic> map = Map<String,dynamic>();
      for (var element in value) {
        map[element.date!] = element;
      }
      completer.complete(map);
    });
    return completer.future;
  }

  Future<bool> checkIsFavImage(String date) async{
    Completer<bool> completer = Completer<bool>();
    nasaPictureDao.checkImageIsExist(date).then((bool value) {
      completer.complete(value);
    }).catchError((e,s){
      completer.completeError(e,s);
    });
    return completer.future;

  }
}