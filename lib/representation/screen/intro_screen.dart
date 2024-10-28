import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/constants/textstyle_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/representation/screen/login_page.dart';
import 'package:hotel_appv1/representation/widgets/button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget{
  const IntroScreen({Key? key}) : super(key: key);

  static const routeName = 'intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>{
  final PageController _pageController = PageController();

  final StreamController<int> _pageStreamController = StreamController<int>.broadcast();

  @override
  void initState(){
    super.initState();
    _pageController.addListener(() { 
    _pageStreamController.add(_pageController.page!.toInt());
    });
  }

  Widget _buildItenIntroScreen(String image, String title, String description, Alignment alignment){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: alignment,
          child: ImageHelper.loadFromAsset(
          image,
          height: 375,
          fit: BoxFit.fitHeight,
          ),
        ),
        
        const SizedBox(
          height: kMediumPadding * 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyles.defaultStyle.bold,
              ),
              const SizedBox(
                height: kMediumPadding,
              ),
              Text(
                description,
                style: TextStyles.defaultStyle,
              ),
            ],
          ),
          )
      ],
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildItenIntroScreen(AssetHelper.intro1, 'Đặt phòng', 'Đặt những căn phòng thật là đẹp với những cái giá cực kì là rẻ.',Alignment.center),
              _buildItenIntroScreen(AssetHelper.intro2, 'Đặt chuyến bay', 'Đáp ứng mọi chuyến bay, mọi nhu cầu của bạn.',Alignment.center),
              _buildItenIntroScreen(AssetHelper.intro3, 'Du lịch', 'Du lịch thỏa thích, chỉ cần bạn muốn đi đâu, tôi và bạn cùng đi.',Alignment.center),
            ],
          ),
          Positioned(
            left: kMediumPadding,
            right: kMediumPadding,
            bottom: kMediumPadding * 3,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotWidth: kMinPadding,
                    dotHeight: kMinPadding,
                    activeDotColor: Color(0xFF737373),
                  ),
                ),
                ), 
                StreamBuilder<int>(
                  initialData: 0,
                  stream: _pageStreamController.stream,
                  builder: (context,snapshot) {
                    return Expanded(
                      flex: 4,
                      child: ButtonWidget(
                        title: snapshot.data != 2 ? 'Tiếp theo' : 'Bắt đầu',
                        ontap: (){
                          if(_pageController.page != 2){
                            _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                          } else {
                            Navigator.pushNamed(context, "/home");
                          }
                        },
                      ),
                    );
                  }
                ),  
              ],
            ),
          ),
        ],
      ), 
    );
  }
}