import 'dart:async';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/constants/textstyle_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/representation/screen/PhoneNumberInputScreen.dart';
import 'package:hotel_appv1/representation/screen/login_page.dart';
import 'package:hotel_appv1/representation/screen/main_app.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_booking_widget.dart';
import 'package:hotel_appv1/representation/widgets/item_room_booking_widget.dart';
import 'package:hotel_appv1/representation/widgets/itemnumber_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/data/models/room_model.dart';

class DoneScreen extends StatefulWidget {
  final int paymentMethod;

  const DoneScreen(
      {Key? key, required this.paymentMethod, required this.roomModel})
      : super(key: key);

  static const routeName = 'done_screen';

  final RoomModel roomModel;

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final PageController _pageController = PageController();

  String? selectednumber;
  final StreamController<int> _pageStreamController =
      StreamController<int>.broadcast();

  // List các phương thức thanh toán
  final List<String> paymentMethods = [
    'Thanh toán tại khách sạn',
    'Thanh toán online',
  ];
  // Biến để lưu trạng thái phương thức thanh toán được chọn
  late String selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị phương thức thanh toán ban đầu
    selectedPaymentMethod = paymentMethods[widget.paymentMethod];
  }

  Widget _buildItemsOptionCheckOut(
    String icon,
    String title,
    String value,
    String value2,
  ) {
    return SingleChildScrollView(
      child: Container(
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
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primaryColor,
                  ),
                ),
                SizedBox(
                  height: 5, // Khoảng cách giữa hai đoạn văn bản
                ),
                Text(
                  value2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: true,
      titleString: 'Xác nhận',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemRoomBookingWidget(
                roomImage: widget.roomModel.photos.first,
                roomname: widget.roomModel.description,
                roomPrice: widget.roomModel.price.toInt(),
                roomType: widget.roomModel.roomType,
                roomUtility: '',
                onTap: () {},
                numberOfRoom: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _buildItemsOptionCheckOut(
                AssetHelper.icoContact,
                'Chi tiết liên hệ:',
                user?.displayName ?? 'N/A',
                user?.email ?? 'N/A',
              ),
              SizedBox(
                height: 10,
              ),
              ItemNumberWidget(
                  icon: AssetHelper.icong,
                  title: 'Số điện thoại: ',
                  destination: selectednumber ?? ' ',
                  onTap: () async {
                    final newSelectedCity = await Navigator.of(context).pushNamed(
                      PhoneNumberInputScreen.routeName,
                      arguments: selectednumber ?? '',
                    );
                    if (newSelectedCity != null) {
                      setState(() {
                        selectednumber = newSelectedCity as String;
                      });
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kItemPadding),
                ),
                child: Text(
                  'Phương thức thanh toán đã chọn: $selectedPaymentMethod',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20), // Khoảng cách giữa radio button và nút
              ButtonWidget(
                title: 'Hoàn thành',
                ontap: () {
                  // Hiển thị hộp thoại thông báo
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Xác nhận thanh toán'),
                        content: Text(
                            'Thanh toán của bạn đã được xác nhận thành công.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng hộp thoại
                              Navigator.of(context).pushNamed(MainApp
                                  .routeName); // Điều hướng đến màn hình MainApp
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
