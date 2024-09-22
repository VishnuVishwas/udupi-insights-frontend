// lib/models/photo_model.dart

class PhotoModel {
  final int id;
  final int placeId;
  final String photoUrl;

  PhotoModel({
    required this.id,
    required this.placeId,
    required this.photoUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      placeId: json['place_id'],
      photoUrl: json['photo_url'],
    );
  }
}
