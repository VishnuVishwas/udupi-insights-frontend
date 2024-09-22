// lib/services/api_services.dart

import 'dart:convert';

import 'package:travel_app_getx/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app_getx/models/places_model.dart';

import '../models/photo_model.dart';
import '../models/user_model.dart';

class ApiServices {
  final String baseUrl = ApiConstants.baseUrl;

  // get all the places
   Future<List<PlacesModel>> getPlaces() async {

    final response = await http.get(Uri.parse('$baseUrl/places'));

    if(response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(response.body);
      return data.map((json) => PlacesModel.fromJson(json)).toList();
    }
    else {
      throw Exception('Failed to load places');
    }
  }

  // get all the photos
  Future<List<PhotoModel>> getPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/photos')); // Make sure this endpoint exists
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  // Get all users
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }


}
