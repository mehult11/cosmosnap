
import 'package:nasa_apod/Constant/KeyConst.dart';

class NASAPicture{
  String? date;
  String? title;
  String? explanation;
  String? url;
  String? mediaType;

  NASAPicture({
   this.date,
   this.title,
   this.explanation,
   this.url,
   this.mediaType,
  });

  factory NASAPicture.fromJson(Map<String,dynamic> data){
    return NASAPicture(
      date: data[KeyConst.date].toString().trim(),
      title: data[KeyConst.title],
      explanation: data[KeyConst.explanation],
      url: data[KeyConst.url],
      mediaType: data[KeyConst.mediaType],
    );
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "title": title,
    "explanation": explanation,
    "url": url,
    "media_type": mediaType
  };

}