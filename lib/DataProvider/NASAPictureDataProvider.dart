
import 'dart:async';

import 'package:nasa_apod/Entity/NASAPicture.dart';
import 'package:nasa_apod/Service/NASAPictureService.dart';
import 'package:rxdart/subjects.dart';
import 'package:intl/intl.dart';
class NASAPictureDataProvider{

  static NASAPictureDataProvider? _instance;

  NASAPictureDataProvider._(); // Private constructor

  static NASAPictureDataProvider get instance {
    _instance ??= NASAPictureDataProvider._();
    return _instance!;
  }

  NASAPictureService nasaPictureService = NASAPictureService();

  Stream<Map<String,dynamic>> get getImagesFromDBStream => _imagesFromDBStreamBehavior.stream;
  final _imagesFromDBStreamBehavior = BehaviorSubject<Map<String,dynamic>>();

  Stream<bool> get getIsFavoriteStream => _isFavoriteStreamBehavior.stream;
  final _isFavoriteStreamBehavior = BehaviorSubject<bool>();

  Future<NASAPicture> getImage(String date)async{
    Completer<NASAPicture> completer = Completer<NASAPicture>();
    try{
      NASAPicture nasaPicture = await nasaPictureService.getImg(date);
      completer.complete(nasaPicture);
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }


  Future<void> addFavoriteImage(NASAPicture image)async{
    Completer completer = Completer();
    try{
      await nasaPictureService.addFavImg(image);
      completer.complete();
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<void> removeFavoriteImage(String date)async{
    Completer completer = Completer();
    try{
      await nasaPictureService.removeFavImg(date);
      Map<String,dynamic> imageMap = _imagesFromDBStreamBehavior.value;
      imageMap.remove(date);
      _imagesFromDBStreamBehavior.add(Map());
      _imagesFromDBStreamBehavior.add(imageMap);
      completer.complete();
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }

  setAllFavoritePictureIntoStream()async{
    Map<String,dynamic> imgMap = await nasaPictureService.getAllFavImg();
    _imagesFromDBStreamBehavior.add(imgMap);
  }

  setIsFavoriteImageStream(String date)async{
    try{
      bool isFav = await nasaPictureService.checkIsFavImage(date);
      _isFavoriteStreamBehavior.add(isFav);
    }catch(e){
      print(e);
    }
  }
  setIsFavoriteImage(bool value){
    _isFavoriteStreamBehavior.add(value);
  }


}