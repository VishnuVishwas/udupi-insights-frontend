import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/place_controller.dart';
import '../../models/user_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Find PlaceController
    final PlaceController placeController = Get.find<PlaceController>();

    return Scaffold(
      body: Obx(() {
        // Check if user data is available
        if (placeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (placeController.users.isEmpty) {
          return const Center(child: Text('No user data available'));
        } else {
          // Assuming we are displaying the first user for the profile
          UserModel user = placeController.users.first;

          return Column(
            children: [
              buildProfileHeader(context, user),
              const SizedBox(height: 20.0),
              buildProfileDetail("Name", user.name, Icons.person),
              const SizedBox(height: 30.0),
              buildProfileDetail("Email", user.email, Icons.email),
              const SizedBox(height: 30.0),
              buildTermsAndConditions(),
              const SizedBox(height: 30.0),
              buildActionButton("Delete Account", Icons.delete),
              const SizedBox(height: 30.0),
              buildActionButton("LogOut", Icons.logout),
            ],
          );
        }
      }),
    );
  }

  Widget buildProfileHeader(BuildContext context, UserModel user) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
          height: MediaQuery.of(context).size.height / 4.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6.5),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: buildProfileImage(user.profilePictureUrl),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Center(
            child: Text(
              user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileImage(String? profileImageUrl) {
    if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/users/avatar.jpg',
        image: profileImageUrl,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/users/avatar.jpg',
            fit: BoxFit.cover,
            width: 120,
            height: 120,
          );
        },
      );
    } else {
      return Image.asset(
        'assets/users/avatar.jpg',
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      );
    }
  }

  Widget buildProfileDetail(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTermsAndConditions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Icon(Icons.description, color: Colors.black),
              SizedBox(width: 20.0),
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Placeholder for future functionality
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 2.0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black),
                const SizedBox(width: 20.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
