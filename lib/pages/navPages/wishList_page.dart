import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/place_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaceController placeController = Get.find<PlaceController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
      ),
      body: Obx(() {
        final favoritePlaces = placeController.places
            .where((place) => place.isFavorite)
            .toList();

        if (favoritePlaces.isEmpty) {
          return const Center(child: Text('No places in your wishlist.'));
        }

        return ListView.builder(
          itemCount: favoritePlaces.length,
          itemBuilder: (context, index) {
            final place = favoritePlaces[index];
            return ListTile(
              title: Text(place.name),
              subtitle: Text(place.address),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  // Remove from favorites (optional implementation)
                  place.isFavorite = false; // Update the place model
                  placeController.places.refresh(); // Refresh observable list
                },
              ),
            );
          },
        );
      }),
    );
  }
}
