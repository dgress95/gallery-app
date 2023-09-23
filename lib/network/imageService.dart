import 'dart:convert';

import 'package:flutter_app_gallery/models/webImageList.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:http/http.dart' as http;

//Web service for calling picsum api
class ImageWebService{
  final http.Client _client;
  final EndPoints endPoints = EndPoints();

  ImageWebService(this._client);

  // fetches a list of images and parses them into a list of web image objects
  Future<WebImageList> fetchListOfWebImages() async {
    try{
      final response = await _client.get(Uri.parse(endPoints.getListOfImages()));
      if(response.statusCode == 200){
        List<dynamic> parsedJson = jsonDecode(response.body);
        List<WebImage> images = parsedJson.map((i) => WebImage.fromJson(i)).toList();
        return WebImageList(webimages: images);
      } else {
        print(response.body);
        throw Exception(response.statusCode);
      }
    } catch(e) {
        return Future.error(e);
    }
  }

  //Use this function to fetch a web image's full info json
  Future<WebImage> fetchWebImageInfo(int id) async{
    try{
      final response =  await _client
    .get(Uri.parse(endPoints.getImageFromId(id)));
      if(response.statusCode == 200){
        return WebImage.fromJson(jsonDecode(response.body));
      }else{
        print(response.body);
        throw Exception(response.statusCode);
      }
    }
    catch(e){
      return Future.error(e);
    }
  }

}