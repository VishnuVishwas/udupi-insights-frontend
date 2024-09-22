// lib/models/places_model.dart

class PlacesModel {
  final int id;
  final String name;
  final String address;
  final String latitude;
  final String longitude;
  final String description;
  final double rating;
  bool isFavorite;

  PlacesModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.rating,
    this.isFavorite = false,
  });

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'].toString(),  // Ensure toString() for String type
      longitude: json['longitude'].toString(),  // Ensure toString() for String type
      description: json['description'],
      rating: json['rating'],
    );
  }
}
