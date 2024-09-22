// lib/database/photos_schema.dart

class PhotosSchema {
  // photo table schema
  static const String createTable = '''
    CREATE TABLE photos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      place_id INTEGER,
      photo_url TEXT NOT NULL, 
      FOREIGN KEY (place_id) REFERENCES places(id)
    )
  ''';
}
