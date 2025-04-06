import 'package:flutter/material.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final String badgeImage;
  final String iconPath; // Path to the image asset
  final VoidCallback onTap;

  const AchievementCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.badgeImage,
    required this.iconPath, // New field for icon image
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // Icon and title in the same row
              children: [
                Image.asset(
                  iconPath,
                  width: 27, // Adjust size as needed
                  height: 25,
                ),
                SizedBox(width: 7), // Spacing between icon and title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Image.asset(
                  badgeImage,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      color: AppColors.TextMUSTARD_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
