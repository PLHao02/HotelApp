import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';

class ItemBookingWidget extends StatelessWidget {
  const ItemBookingWidget({
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
          borderRadius: BorderRadius.all(
            Radius.circular(
              kItemPadding,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 55,
              height: 55,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  destination,
                  style: TextStyle(
                    fontSize: 18,
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
