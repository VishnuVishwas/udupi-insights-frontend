// lib/database/bookings_schema.dart

class BookingsSchema {
  // Bookings
  static const String createTable = '''
    CREATE TABLE bookings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      place_id INTEGER,
      booking_date TEXT,
      number_of_people INTEGER, 
      FOREIGN KEY (place_id) REFERENCES places(id)
    )
  ''';
}
