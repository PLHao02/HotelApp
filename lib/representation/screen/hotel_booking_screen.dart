import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/extensions/date_ext.dart';
import 'package:hotel_appv1/representation/screen/select_city_screen.dart';
import 'package:hotel_appv1/representation/screen/guest_and_room_booking_screen.dart';
import 'package:hotel_appv1/representation/screen/hotels_screen.dart';
import 'package:hotel_appv1/representation/screen/select_date_screen.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_booking_widget.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({Key? key}) : super(key: key);

  static final String routeName = '/hotel_booking_screen';

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? dateSelect;
  String? selectedCity;
  String? selectedGuestandRoom;

  @override
  void didChangeDependencies() {
    // didChangeDependencies sẽ được gọi sau initState()
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      selectedCity = arguments as String?;
      setState(() {}); // Cập nhật trạng thái nếu cần
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: true,
      titleString: 'Tìm Phòng',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kMediumPadding * 2,
            ),
            ItemBookingWidget(
                icon: AssetHelper.noichon,
                title: 'Thành phố',
                destination: selectedCity ?? ' ',
                onTap: () async {
                  final newSelectedCity = await Navigator.of(context).pushNamed(
                    select_city_screen.routeName,
                    arguments: selectedCity ?? '',
                  );
                  if (newSelectedCity != null) {
                    setState(() {
                      selectedCity = newSelectedCity as String;
                    });
                  }
                }),
            SizedBox(
              height: kMediumPadding,
            ),
            ItemBookingWidget(
              icon: AssetHelper.lich,
              title: 'Lịch trình',
              destination: dateSelect ?? '',
              onTap: () async {
                final result = await Navigator.of(context)
                    .pushNamed(SelectDateScreen.routeName);
                if (!(result as List<DateTime?>)
                    .any((element) => element == null)) {
                  dateSelect =
                      '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                  setState(() {});
                }
              },
            ),
            SizedBox(
              height: kMediumPadding,
            ),
            ItemBookingWidget(
              icon: AssetHelper.giuong,
              title: 'Số khách và Phòng',
              destination: selectedGuestandRoom ?? '',
              onTap: () async {
                final newSelectedGuestandRoom =
                    await Navigator.of(context).pushNamed(
                  GuestAndRoomBookingScreen.routeName,
                  arguments: selectedGuestandRoom ?? '2 khách, 1 phòng',
                );
                if (newSelectedGuestandRoom != null) {
                  setState(() {
                    selectedGuestandRoom = newSelectedGuestandRoom as String;
                  });
                }
              },
            ),
            SizedBox(
              height: kMediumPadding,
            ),
            ButtonWidget(
              title: 'Tìm kiếm',
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HotelsScreen(selectedCity: selectedCity ?? "")));
              },
            ),
          ],
        ),
      ),
    );
  }
}
