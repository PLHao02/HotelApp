import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/data/models/hotel_model.dart';
import 'package:hotel_appv1/representation/admin/Hotel.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/representation/widgets/item_hotel_widget.dart';

class HotelsScreen extends StatefulWidget {
  String selectedCity;
  HotelsScreen({Key? key, required this.selectedCity}) : super(key: key);

  static const String routeName = '/hotels_screen';

  @override
  State<HotelsScreen> createState() => _HotelsSceenState();
}

class _HotelsSceenState extends State<HotelsScreen> {
  List<HotelModel> hotels = [];

  @override
  void initState() {
    super.initState();

    getHotels();
  }

  Future<void> getHotels() async {
    List<HotelModel> filteredHotels = [];

    if (widget.selectedCity == '') {
      final hotelsSnapshot =
          await FirebaseFirestore.instance.collection('Hotels').get();
      filteredHotels = hotelsSnapshot.docs
          .map((doc) => HotelModel.fromDocumentSnapshot(doc))
          .toList();
    } else {
      final hotelsSnapshot = await FirebaseFirestore.instance
          .collection('Hotels')
          .where('city', isEqualTo: widget.selectedCity)
          .get();
      filteredHotels = hotelsSnapshot.docs
          .map((doc) => HotelModel.fromDocumentSnapshot(doc))
          .toList();
    }

    setState(() {
      hotels = filteredHotels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách khách sạn')),
      body: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: kTopPadding),
                child: ItemHotelWidget(hotelModel: hotels[index]));
          }),
    );
  }
}
