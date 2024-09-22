// lib/controllers/place_controller.dart

import 'package:get/get.dart';
import 'package:travel_app_getx/models/user_model.dart';
import '../models/places_model.dart';
import '../models/photo_model.dart';
import '../services/api_services.dart';

class PlaceController extends GetxController {
  var places = <PlacesModel>[].obs;
  var photos = <PhotoModel>[].obs; // Observable list for photos
  var users = <UserModel>[].obs;
  var isLoading = true.obs;

  final ApiServices apiServices = ApiServices();

  @override
  void onInit() {
    fetchPlaces();
    fetchPhotos(); // Fetch photos on initialization
    fetchUsers();
    super.onInit();
  }

  void fetchPlaces() async {
    try {
      isLoading(true);
      var placesList = await apiServices.getPlaces();
      places.assignAll(placesList);
    } finally {
      isLoading(false);
    }
  }

  void fetchPhotos() async {
    try {
      var photoList = await apiServices.getPhotos();
      photos.assignAll(photoList); // Store fetched photos
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  // fetch user details
  void fetchUsers() async {
    try {
      var userList = await apiServices.getUsers();
      users.assignAll(userList);
    }
    catch (e) {
      print('Error fetching users: $e');
    }
  }


}
