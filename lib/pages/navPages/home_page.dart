import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app_getx/pages/explore_more_page.dart';
import 'package:travel_app_getx/pages/navPages/map_page.dart';
import 'package:travel_app_getx/pages/navPages/profile_page.dart';
import 'package:travel_app_getx/pages/navPages/wishList_page.dart';
import '../../constants/colors.dart';
import '../../constants/explore_items_home.dart';
import '../../constants/explore_more_items.dart';
import '../../controllers/place_controller.dart';
import '../details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final PlaceController placeController = Get.find<PlaceController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    placeController.fetchPlaces(); // Fetch places when HomePage initializes
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Drawer Icon
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.transparent),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),

              // Profile Picture
              GestureDetector(
                onTap: () {
                  Get.to(() => const ProfilePage());
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/users/avatar.jpg',
                  ),
                  radius: 25, // Adjust the size as needed
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  'Udupi Insights',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Locations'),
                onTap: () {
                  // Navigate to locations page
                  Navigator.pop(context);
                  Get.to(() => MapPage()); // You need to create LocationsPage
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: () {
                  // Navigate to favorites page
                  Navigator.pop(context);
                  Get.to(() => const WishlistPage()); // You need to create FavoritesPage
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  // Navigate to profile page
                  Navigator.pop(context);
                  Get.to(() => const ProfilePage()); // You need to create ProfilePage
                },
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only( right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Heading Discover
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Discover',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tab bar
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: Align(
                  alignment: Alignment.centerLeft, // Aligns the TabBar to the left
                  child: TabBar(
                    controller: _tabController,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(fontSize: 16),
                    unselectedLabelColor: Colors.grey,
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'Places'),
                      Tab(text: 'Inspiration'),
                      Tab(text: 'Emotions'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Tab bar contents
              Container(
                padding: const EdgeInsets.only(right: 10),
                height: 300,
                width: double.maxFinite,
                child: Obx(() {
                  if (placeController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        // First tab view content - Places
                        ListView.builder(
                          itemCount: placeController.places.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final place = placeController.places[index];
                            final photos = placeController.photos
                                .where((photo) => photo.placeId == place.id)
                                .toList();

                            return GestureDetector(
                              onTap: () {
                                // Navigate directly to the DetailsPage and pass the place ID
                                Get.to(() => DetailsPage(placeId: place.id));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15, top: 13),
                                height: 200,
                                width: 190,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    photos.isNotEmpty
                                        ? photos[0].photoUrl
                                        : 'https://example.com/default_image.jpg', // Default image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // Second tab view content - Inspiration
                        ListView(
                          padding: const EdgeInsets.all(8.0),
                          children: const [
                            ListTile(
                              title: Text("Explore Udupi's Beaches"),
                              subtitle: Text("Discover the tranquil beauty of Malpe and Kaup Beach."),
                            ),
                            ListTile(
                              title: Text("Cultural Heritage"),
                              subtitle: Text("Visit historical temples like Shri Krishna Temple."),
                            ),
                            ListTile(
                              title: Text("Adventure Awaits"),
                              subtitle: Text("Go trekking at Koodlu Falls for an exhilarating experience."),
                            ),
                            ListTile(
                              title: Text("Local Cuisine"),
                              subtitle: Text("Try the delicious Udupi Sambar and Mangalorean Fish Curry."),
                            ),
                          ],
                        ),
                        // Third tab view content - Emotions
                        ListView(
                          padding: const EdgeInsets.all(8.0),
                          children: const [
                            ListTile(
                              title: Text("For Relaxation"),
                              subtitle: Text("Visit Arbi Falls for a peaceful retreat."),
                            ),
                            ListTile(
                              title: Text("For Adventure"),
                              subtitle: Text("Explore St. Mary's Island for thrilling water sports."),
                            ),
                            ListTile(
                              title: Text("Quote"),
                              subtitle: Text("Traveling – it leaves you speechless, then turns you into a storyteller. – Ibn Battuta"),
                            ),
                            ListTile(
                              title: Text("Quote"),
                              subtitle: Text("The journey not the arrival matters. – T.S. Eliot"),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),

              const SizedBox(height: 40),

              // Explore more section
              Container(
                margin: const EdgeInsets.only(left: 8, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore more',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    Text(
                      'See all',
                      style: GoogleFonts.raleway(
                        color: AppColors.textColor1,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Explore section contents
              // Inside HomePage
              Container(
                height: 120,
                child: ListView.builder(
                  itemCount: exploreMoreItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to ExploreMorePage with the selected activity
                        Get.to(() => ExploreMorePage(exploreMoreItem: exploreMoreItems[index]));
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  exploreItemImages[index],
                                ),
                                scale: 10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Label
                          Text(
                            exploreItemHeadings[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
