import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/data/models/room_model.dart';
import 'package:hotel_appv1/representation/screen/hotels_screen.dart';
import 'package:hotel_appv1/representation/screen/main_app.dart';
import 'package:hotel_appv1/representation/screen/payment.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_booking_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_room_booking_widget.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key, required this.roomModel}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;

  static const String routeName = '/check_out_screen';

  final RoomModel roomModel;

  Widget _buildItemsOptionCheckOut(
    String icon,
    String title,
    String value,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageHelper.loadFromAsset(
                AssetHelper.icoContact,
              ),
              SizedBox(
                width: kItemPadding,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: ColorPalette.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.all(kMinPadding),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: true,
      titleString: 'Checkout',
      child: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            SizedBox(
              height: kDefaultPadding,
            ),
            ItemRoomBookingWidget(
              roomImage: roomModel.photos.first,
              roomname: roomModel.description,
              roomPrice: roomModel.price.toInt(),
              roomType: roomModel.roomType,
              roomUtility: '',
              onTap: () {},
              numberOfRoom: 1,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            _buildItemsOptionCheckOut(
              AssetHelper.icoContact,
              'chi tiết liên hệ',
              user?.displayName ?? 'N/A',
              context,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            _buildItemsOptionCheckOut(
              AssetHelper.icoPromo,
              'mã khuyến mãi',
              ' mã khuyến mãi',
              context,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            ButtonWidget(
              title: 'Thanh Toán',
              ontap: () {
                Navigator.of(context).pushNamed(
                  PaymentScreen.routeName,
                  arguments: roomModel,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
