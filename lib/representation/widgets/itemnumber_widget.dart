import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';

class ItemNumberWidget extends StatelessWidget {
  const ItemNumberWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.destination,
    this.onTap,
    this.selectedCity,
  }) : super(key: key);

  final String icon;
  final String title;
  final String destination;
  final Function()? onTap;
  final String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kItemPadding),  
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 25,
              height: 25,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primaryColor,
                ),
            ),
            SizedBox(width: 8), // Khoảng cách giữa hai đoạn văn bản
            Text(
              destination,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primaryColor,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
