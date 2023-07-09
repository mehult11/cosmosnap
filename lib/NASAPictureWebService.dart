import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class NASAPictureWebService{
  final String apiKey = "T4IyOaYakKQvjta8fV8COr3uPEIxGEzgZjVz44Gb";

  Future<dynamic> getImageFromAPI(String date) async{
    Completer<Map<String,dynamic>> completer = Completer<Map<String,dynamic>>();
    Map<String,dynamic> dataMap = Map<String,dynamic>();
    Uri uri = Uri(
        scheme: 'https',
        host: 'api.nasa.gov',
        path: '/planetary/apod',
        queryParameters: {'api_key': apiKey, 'date':date},
    );
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      dataMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
      completer.complete(dataMap);
    } else {
      completer.completeError(response.statusCode);
    }
    return completer.future;
  }

}