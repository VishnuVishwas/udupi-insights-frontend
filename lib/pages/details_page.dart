import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:travel_app_getx/pages/navPages/wishList_page.dart';
import '../constants/colors.dart';
import '../controllers/place_controller.dart';
import '../models/photo_model.dart';
import '../models/places_model.dart';
import '../services/api_services.dart';
import '../widgets/app_buttons.dart';
import '../widgets/responsive_buttons.dart';
import 'navPages/map_page.dart';

class DetailsPage extends StatelessWidget {
  final int placeId;

  const DetailsPage({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    final PlaceController placeController = Get.find<PlaceController>();
    final ApiServices apiServices = ApiServices();

    // Fetch the details for the selected place
    placeController.fetchPlaces();

    // State to track favorite status
    final isFavorite = RxBool(
      placeController.places.firstWhere((place) => place.id == placeId).isFavorite,
    );

    return Scaffold(
      body: Obx(() {
        if (placeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final place = placeController.places.firstWhere(
              (place) => place.id == placeId,
          orElse: () => PlacesModel(
            id: 0,
            name: '',
            address: '',
            latitude: '',
            longitude: '',
            description: '',
            rating: 0,
          ),
        );

        return FutureBuilder<List<PhotoModel>>(
          future: apiServices.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No photos available.'));
            }

            final photos = snapshot.data!
                .where((photo) => photo.placeId == placeId)
                .toList();

            return Stack(
              children: [
                Container(color: Colors.transparent),
                Positioned(
                  child: Container(
                    height: 350,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(photos.isNotEmpty
                            ? photos[0].photoUrl
                            : 'https://example.com/default_image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 30,
                  child: GestureDetector(
                    onTap: () {
                      Get.back(); // Navigate back
                    },
                    child: const Icon(Icons.arrow_back_outlined, color: Colors.white, size: 30),
                  ),
                ),
                Positioned(
                  top: 320,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 32, 35, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 600,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              place.name,
                              style: GoogleFonts.raleway(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        GestureDetector(
                          onTap: () {
                            Get.to(MapPage());
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, color: AppColors.mainColor, size: 22),
                              const SizedBox(width: 7),
                              Text(
                                place.address,
                                style: GoogleFonts.raleway(
                                  color: AppColors.textColor1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < place.rating.round() ? Icons.star : Icons.star_border,
                                  color: AppColors.starColor,
                                  size: 25,
                                );
                              }),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '(${place.rating})',
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'People',
                          style: GoogleFonts.raleway(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Number of people in your group',
                          style: GoogleFonts.raleway(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          children: List.generate(5, (index) {
                            return InkWell(
                              onTap: () {
                                // Handle selection
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: AppButtons(
                                  color: Colors.black,
                                  backgroundColor: AppColors.buttonBackground,
                                  borderColor: AppColors.buttonBackground,
                                  size: 50,
                                  text: (index + 1).toString(),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 26),
                        Text(
                          'Description',
                          style: GoogleFonts.raleway(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          place.description,
                          style: GoogleFonts.raleway(
                            color: AppColors.textColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            isFavorite.value = !isFavorite.value; // Toggle local state
                            place.isFavorite = isFavorite.value; // Update the place model
                            placeController.places.refresh(); // Refresh observable list
                          },
                          child: AppButtons(
                            color: AppColors.textColor1,
                            backgroundColor: Colors.white,
                            borderColor: AppColors.textColor1,
                            size: 60,
                            isIcon: true,
                            icon: isFavorite.value ? Icons.favorite : Icons.favorite_border,
                          ),
                        );
                      }),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const WishlistPage());
                        },
                      child: const ResponsiveButtons(isResponsive: false),),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
