import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class ResponsiveButtons extends StatelessWidget {
  const ResponsiveButtons({super.key, this.width = 260, this.isResponsive});

  final double? width;
  final bool? isResponsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isResponsive == true ? double.maxFinite : width,
      height: 55,  // Adjusted height to match the second code
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainColor,
      ),
      child: Row(
        mainAxisAlignment: isResponsive == true
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (isResponsive == false)
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    'View Wishlist',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                  ),
                ),
                const SizedBox(width: 17),
              ],
            ),
          // Use the image instead of the icon
          Image.asset(
            'assets/img/next.png',
            scale: 25,  // Adjust scale as necessary
          ),
        ],
      ),
    );
  }
}
