// lib/database/places_schema.dart

class PlacesSchema {
  // create places table
  static const String createTable = '''
    CREATE TABLE places (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      address TEXT,
      latitude REAL,
      longitude REAL,
      description TEXT,
      is_favorite INTEGER DEFAULT 0,
      rating REAL DEFAULT 0.0
    )
  ''';
}
