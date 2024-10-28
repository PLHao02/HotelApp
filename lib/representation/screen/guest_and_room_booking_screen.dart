import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import '../widgets/button_widget.dart';
import '../widgets/item_add_guest_and_room.dart';

class GuestAndRoomBookingScreen extends StatefulWidget {
  const GuestAndRoomBookingScreen({Key? key}) : super(key: key);

  static const String routeName = '/guest_and_room_screen';

  @override
  State<GuestAndRoomBookingScreen> createState() =>
      _GuestAndRoomBookingScreenState();
}

class _GuestAndRoomBookingScreenState extends State<GuestAndRoomBookingScreen> {
  String? selectedGuestAndRoom;
  int selectedGuests = 2; // Default from initial data
  int selectedRooms = 1; // Default from initial data

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Khách và Số Phòng',
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding * 1.5,
          ),
          ItemAddGuestAndRoom(
            icon: AssetHelper.icoGuest,
            innitData: selectedGuests,
            title: 'Số khách',
            onGuestChange: (newGuestCount) => setState(() {
              selectedGuests = newGuestCount;
            }),
          ),
          ItemAddGuestAndRoom(
            icon: AssetHelper.icoRoom,
            innitData: selectedRooms,
            title: 'Số phòng',
            onGuestChange: (newRoomCount) => setState(() {
              selectedRooms = newRoomCount;
            }),
          ),
          ButtonWidget(
            title: 'Chọn',
            ontap: () {
              setState(() {
                selectedGuestAndRoom =
                    '${selectedGuests} khách, ${selectedRooms} phòng';
              });
              Navigator.pop(context, selectedGuestAndRoom);
            },
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          ButtonWidget(
            title: 'Trở lại',
            ontap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
