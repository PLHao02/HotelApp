import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';

class ItemUtilityHotelWidget extends StatelessWidget {
  ItemUtilityHotelWidget({Key? key}) : super(key: key);

  final List<Map<String, String>> listUnity = [
    {
      'icon': AssetHelper.icoWifi,
      
    },
    {
      'icon': AssetHelper.icoRefund,
      
    },
    {
      'icon': AssetHelper.icoBreakFast,
      
    },
    {
      'icon': AssetHelper.icoNonSmoke,
      
    },
  ];

  Widget _buildItemUtilityHotel(String icon) {
    return Column(
      children: [
        ImageHelper.loadFromAsset(
          icon,
        ),
        SizedBox(
          height: kTopPadding,
        ),
        // Text(
        //   title,
        //   textAlign: TextAlign.center,
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listUnity
            // .map((e) => _buildItemUtilityHotel(e['icon']!, e['name']!))
            .map((e) => _buildItemUtilityHotel(e['icon']!))
            .toList(),
      ),
    );
  }
}
