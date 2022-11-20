import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class WeatherInformationMachine{
  Future<Map<String, dynamic>> getDataWithCity(String cityName) async{
    final queryParameter = {
      "q" : cityName,
      "key" : "006abc5093bb49d3af733331222011"
    };
    final uri = Uri.https("api.weatherapi.com", "/v1/forecast.json",queryParameter);
    final response = await get(uri);
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
    }
    return data;
  }


  Future<Map<String, dynamic>> getDataWithLongLat(String lon, String lat) async{
    if (kDebugMode) {
      print(lon + lat);
    }
    final queryParameter = {
      "q" : lat+","+lon,
      "key" : "006abc5093bb49d3af733331222011"
      //"units" : "imperial"
    };
    final uri = Uri.https("api.weatherapi.com", "/v1/forecast.json",queryParameter);
    final response = await get(uri);
    final data =  jsonDecode(response.body) as Map<String,dynamic>;
    if (kDebugMode) {
      print(data);
    }
    return data;
  }
}