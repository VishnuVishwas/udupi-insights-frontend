import 'package:flutter/material.dart';


import '../constants/colors.dart';
import '../constants/welcome_page_consts.dart';
import '../widgets/welcome_text_widget.dart';
import 'main_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: imagePath.length,
        itemBuilder: (_, index) {
          return Stack(
            children: [
              // Image container
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Shadow overlay on image
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.4)),
              ),
              // Text and slider
              Positioned(
                bottom: 45,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text section
                    Expanded(
                      child: WelcomeTextWidget(
                        heading: contentWelcomePage[index]['heading']!.toString(),
                        subHeading: contentWelcomePage[index]['subheading']!.toString(),
                        paragrpah: contentWelcomePage[index]['description']!.toString(),
                      ),
                    ),
                    // Carousel (Page indicator)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(imagePath.length, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          width: 8,
                          height: index == indexDots ? 60 : 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.sliderColorWelcome,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // Button to navigate to MainPage
              if (index == imagePath.length - 1) // Show only on the last page
                Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(), // Navigate to MainPage
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),

                      backgroundColor: AppColors.sliderColorWelcome,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),

                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
