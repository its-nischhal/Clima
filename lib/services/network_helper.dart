import 'dart:convert';
import 'package:http/http.dart';

class DataFetcher{
  final String url;
   late Uri uri;
  DataFetcher({required this.url});
  Future fetchWeatherData() async {
    uri = Uri.parse(url);
    try{
      Response weatherData =await get(uri);
      return jsonDecode(weatherData.body);
    }
    catch(e){
    }
  }



}