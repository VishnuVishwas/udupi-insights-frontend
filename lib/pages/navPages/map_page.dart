import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../controllers/place_controller.dart';
import '../../models/places_model.dart';

class MapPage extends StatelessWidget {
  final PlaceController placeController = Get.find<PlaceController>();
  final TextEditingController searchController = TextEditingController(); // Search controller
  final RxList<PlacesModel> filteredPlaces = <PlacesModel>[].obs; // To hold filtered places
  final MapController mapController = MapController(); // Controller for the map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locate Nearest Places',  style:  TextStyle(color: Colors.white)),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                // Perform search as user types
                String searchQuery = value.toLowerCase();
                filteredPlaces.value = placeController.places.where(
                      (place) => place.name.toLowerCase().contains(searchQuery),
                ).toList();
              },
              decoration: InputDecoration(
                hintText: 'Search places...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (filteredPlaces.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No places found!')),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          // Display the filtered places
          Obx(() {

            // search places
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredPlaces.length,
              itemBuilder: (context, index) {
                final place = filteredPlaces[index];
                return ListTile(
                  title: Text(place.name,),
                  subtitle: Text(place.address),
                  onTap: () {
                    // Move map to the selected place
                    final double latitude = double.parse(place.latitude);
                    final double longitude = double.parse(place.longitude);
                    mapController.move(LatLng(latitude, longitude), 13.0);
                    searchController.clear(); // Clear the search field
                    filteredPlaces.clear(); // Clear the filtered results
                  },
                );
              },
            );
          }),
          Expanded(
            child: Obx(() {
              // Show loading spinner if data is still being fetched
              if (placeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Create a list of markers from the places
              List<Marker> markers = placeController.places.map((place) {
                // Parse the latitude and longitude from strings to double
                final double latitude = double.parse(place.latitude);
                final double longitude = double.parse(place.longitude);
                return Marker(
                  point: LatLng(latitude, longitude),
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.red,
                  ),
                );
              }).toList();

              return FlutterMap(
                mapController: mapController, // Assign the map controller
                options: const MapOptions(
                  initialCenter: LatLng(13.3409, 74.7421), // Center point of the map
                  initialZoom: 13.0, // Initial zoom level
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: markers,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
