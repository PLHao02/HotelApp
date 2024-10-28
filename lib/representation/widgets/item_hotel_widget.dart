import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:hotel_app/core/constants/color_constants.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/data/models/hotel_model.dart';
import 'package:hotel_appv1/representation/screen/hotel_detail_screen.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:hotel_appv1/representation/widgets/dashline_widget.dart';

class ItemHotelWidget extends StatelessWidget {
  const ItemHotelWidget({Key? key, required this.hotelModel}) : super(key: key);

  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding),
                bottomRight: Radius.circular(kDefaultPadding),
              ),
              child: CachedNetworkImage(
                // Sử dụng cached_network_image
                imageUrl: hotelModel.photos,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelModel.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    ImageHelper.loadFromAsset(AssetHelper.icoLocationHotel),
                    SizedBox(
                      width: kMinPadding,
                    ),
                    Expanded(
                      child: Text(hotelModel.address),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    ImageHelper.loadFromAsset(AssetHelper.icoStarHotel),
                    SizedBox(
                      width: kMinPadding,
                    ),
                    Text(hotelModel.star.toString()),
                  ],
                ),
                DashLineWidget(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${hotelModel.price}/đêm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: kMinPadding,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        title: 'Đặt phòng',
                        ontap: () {
                          Navigator.of(context).pushNamed(
                              HotelDetailScreen.routeName,
                              arguments: hotelModel);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
