import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/data/models/hotel_model.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:hotel_appv1/representation/widgets/dashline_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_utility_hotel_widget.dart';

class ItemRoomBookingWidget extends StatelessWidget {
  const ItemRoomBookingWidget({
    Key? key,
    required this.roomImage,
    required this.roomname,
    required this.roomPrice,
    required this.roomType,
    required this.roomUtility,
    this.onTap,
    this.numberOfRoom,
  }) : super(key: key);

  final String roomImage;
  final String roomname;
  final int roomPrice;
  final String roomType;
  final String roomUtility;
  final Function()? onTap;

  final int? numberOfRoom;

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
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(roomname),
                    SizedBox(
                      height: kMediumPadding,
                    ),
                    Text(
                      'Loại phòng: $roomType',
                    ),
                    SizedBox(
                      height: kMediumPadding,
                    ),
                    Text(
                      roomUtility,
                    ),
                  ],
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                // ImageHelper.loadFromAsset(
                //   roomImage,
                //   radius: BorderRadius.all(
                //     Radius.circular(
                //       kMediumPadding,
                //     ),
                //   ),
                // )
                Expanded(
                  child: CachedNetworkImage(
                    // Sử dụng cached_network_image
                    imageUrl: roomImage,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kItemPadding),
              child: ItemUtilityHotelWidget(),
            ),
            DashLineWidget(),
            SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: '\$$roomPrice/đêm',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      //TextSpan(text: '/đêm'),
                    ],
                  ),
                ),
                Spacer(),
                numberOfRoom == null
                    ? ButtonWidget(
                        title: '        Chọn        ',
                      )
                    : Text('$numberOfRoom room'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
