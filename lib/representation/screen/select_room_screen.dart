import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/data/models/room_model.dart';
import 'package:hotel_appv1/representation/screen/checkout_screen.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/representation/widgets/item_booking_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_room_booking_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_utility_hotel_widget.dart';

class SelectRoomScreen extends StatefulWidget {
  final String hotelID;
  static const String routeName = '/select_room_screen';
  const SelectRoomScreen({super.key, required this.hotelID});

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  List<RoomModel> listRoom = [
    // RoomModel(
    //   roomImage: AssetHelper.room1,
    //   roomName: 'Phòng Sang Trọng',
    //   utility: 'Phí huỷ : Miễn phí',
    //   size: 27,
    //   price: 120,
    // ),
    // RoomModel(
    //   roomImage: AssetHelper.room2,
    //   roomName: 'Phòng Thượng Hạng',
    //   utility: 'Phí huỷ : Miễn phí',
    //   size: 22,
    //   price: 100,
    // ),
    // RoomModel(
    //   roomImage: AssetHelper.room3,
    //   roomName: 'Phòng Sang Trọng',
    //   utility: 'Phí huỷ : Miễn phí',
    //   size: 20,
    //   price: 800,
    // ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailRoom();
  }

  Future<void> getDetailRoom() async {
    final RoomQuerySnapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .where('hotelId', isEqualTo: widget.hotelID)
        .get();

    print(widget.hotelID);

    setState(() {
      listRoom = RoomQuerySnapshot.docs
          .map((e) => RoomModel.fromFirestore(e))
          .toList();
    });

    print(listRoom.length);
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: true,
      titleString: 'Chọn Phòng',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kMediumPadding * 2,
            ),
            ...listRoom
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: kMediumPadding),
                    child: ItemRoomBookingWidget(
                      roomImage: e.photos.first,
                      roomname: e.description,
                      roomPrice: e.price.toInt(),
                      roomType: e.roomType,
                      roomUtility: '',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CheckoutScreen.routeName, arguments: e);
                      },
                    ),
                  ),
                )
                .toList(),
            SizedBox(
              height: kMediumPadding * 2,
            ),
          ],
        ),
      ),
    );
  }
}
