import 'package:flutter/material.dart';
import 'package:hotel_appv1/data/models/room_model.dart';
import 'package:hotel_appv1/representation/screen/donescreen.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const routeName = 'payment_screen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _paymentMethod = 0; // Biến để lưu trạng thái radiobutton

  late RoomModel roomModel;

  // void _navigateToOtherPage() {
  //   // Hàm xử lý khi nút được nhấn để điều hướng đến trang khác
  //   Navigator.pushNamed(context, '/other_page'); // Thay '/other_page' bằng route name của trang muốn điều hướng đến
  // }

  @override
  Widget build(BuildContext context) {
    // Nhận dữ liệu từ arguments khi màn hình được khởi tạo
    final RoomModel receivedRoomModel =
        ModalRoute.of(context)!.settings.arguments as RoomModel;
    roomModel = receivedRoomModel;
    return AppBarContainerWidget(
      implementLeading: true,
      titleString: 'Thanh toán',
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Vui lòng chọn thanh toán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                height:
                    110, // Đã thay đổi chiều cao để chứa cả hai radio button
                margin: EdgeInsets.only(right: 20),
                child: Column(
                  // Sử dụng Column để xếp chồng các radio button dọc
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<int>(
                            value: 0,
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                          ),
                          Text(
                            'Thanh toán tại khách sạn',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<int>(
                            value: 1, // Giá trị của radio button thứ hai
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                          ),
                          Text(
                            'Thanh toán online',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Khoảng cách giữa radio button và nút
              ButtonWidget(
                title: 'Tiếp tục',
                ontap: () {
                  Navigator.of(context).pushNamed(
                    DoneScreen.routeName,
                    arguments: {
                      'paymentMethod':
                          _paymentMethod, // Giả sử _paymentMethod là biến chứa phương thức thanh toán
                      'roomModel': roomModel,
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
