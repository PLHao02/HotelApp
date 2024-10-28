import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/data/models/hotel_model.dart';
import 'package:hotel_appv1/representation/screen/select_room_screen.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({Key? key, required this.hotelModel})
      : super(key: key);

  static const String routeName = 'hotel_detail_screen';

  final HotelModel hotelModel;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  int numberOflike = 99;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final query = FirebaseFirestore.instance
          .collection('favorites')
          .where('id', isEqualTo: widget.hotelModel.id)
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email);

      final snapshot = await query.get();
      setState(() {
        _isFavorite = snapshot.docs.isNotEmpty;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (_isFavorite) {
        _removeFromFavorites(user.email!);
      } else {
        _addToFavorites(user.email!);
      }
      setState(() => _isFavorite = !_isFavorite);
    } else {
      print('User not logged in');
    }
  }

  Future<void> _addToFavorites(String email) async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .add({'id': widget.hotelModel.id, 'email': email});
  }

  Future<void> _removeFromFavorites(String email) async {
    final query = FirebaseFirestore.instance
        .collection('favorites')
        .where('id', isEqualTo: widget.hotelModel.id)
        .where('email', isEqualTo: email);

    final snapshot = await query.get();
    snapshot.docs.first.reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: ImageHelper.loadFromAsset(
            AssetHelper.hotelDetail,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: kMediumPadding * 3,
          left: kMediumPadding,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(kItemPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(kDefaultPadding),
                ),
              ),
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                size: 18,
              ),
            ),
          ),
        ),
        Positioned(
          top: kMediumPadding * 3,
          right: kMediumPadding,
          child: GestureDetector(
            onTap: _toggleFavorite,
            child: Container(
              padding: EdgeInsets.all(kItemPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(kDefaultPadding),
                ),
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 25,
              ),
            ),
          ),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.3,
            maxChildSize: 0.8,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultPadding * 2),
                      topRight: Radius.circular(kDefaultPadding * 2),
                    )),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: kDefaultPadding),
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                kItemPadding,
                              ),
                            ),
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.hotelModel.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${widget.hotelModel.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(' /đêm'),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoLocationHotel,
                              ),
                              SizedBox(
                                width: kMinPadding,
                              ),
                              Text(
                                widget.hotelModel.address,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoStarHotel,
                              ),
                              SizedBox(
                                width: kMinPadding,
                              ),
                              Text(
                                '${widget.hotelModel.star}/5',
                              ),
                            ],
                          ),
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Text(
                            'Mô tả phòng',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Text(
                            'Phòng hiện đại, sạch sẽ',
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            'Vị trí',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          // Text(
                          //   'Hồ Chí Minh',
                          // ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          ImageHelper.loadFromAsset(
                            AssetHelper.mapHotel,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          ButtonWidget(
                            title: 'Chọn phòng',
                            ontap: () {
                              // Navigator.of(context)
                              //     .pushNamed(SelectRoomScreen.routeName, arguments: widget.hotelModel.);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectRoomScreen(
                                          hotelID: widget.hotelModel.id)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    ));
  }
}
