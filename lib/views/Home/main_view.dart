import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/Home/swipe.dart';
import 'package:sauftrag/views/MapSearch/map_screen.dart';
import 'package:sauftrag/views/MapSearch/search.dart';
import 'package:sauftrag/widgets/my_curved_nav_bar.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/widgets/my_side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatefulWidget {

  int index;
  MainView({Key? key, required this.index}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int currentIndex = 0;
  Widget body = Swipe();

  @override
  void initState() {
    currentIndex = widget.index;
    onClick(currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  child: body
              ),
            ),
            MyCurvedNavBar(
              barIconColor: ColorUtils.icon_color,
              selectedIconColor: ColorUtils.white,
              color: ColorUtils.white,
              buttonBackgroundColor: ColorUtils.text_red,
              index: currentIndex,
              animationCurve: Curves.ease,
              animationDuration: Duration(milliseconds: 300),
              height: SizeConfig.heightMultiplier * 8,
              backgroundColor: Color(0xFFefefef),
              parentDecoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                      color: Color(0xFFefefef),
                      blurRadius: 3*SizeConfig.imageSizeMultiplier,
                      offset: Offset(0,-10)
                  )]
              ),
              items: <String>[
                ImageUtils.homeIcon,
                ImageUtils.chatIcon,
                ImageUtils.swipeIcon,
                ImageUtils.mapIcon,
                ImageUtils.profileIcon
              ],
              onTap: (index) {
                currentIndex = index;
                //MainView(index: 3,);
                onClick(currentIndex);
                setState(() {});
              },
            ),
            /*CurvedNavigationBar(
            backgroundColor: ColorUtils.transparent,
            buttonBackgroundColor: ColorUtils.text_red,
            items: <Widget>[
              SvgPicture.asset(ImageUtils.homeIcon),
              SvgPicture.asset(ImageUtils.chatIcon),
              SvgPicture.asset(ImageUtils.swipeIcon, color: ColorUtils.black),
              SvgPicture.asset(ImageUtils.mapIcon),
              SvgPicture.asset(ImageUtils.profileIcon),
            ],
            onTap: (index) {
              //Handle button tap
              onClick(index);
            },
          ),*/
            //BottomBar(index: currentIndex, onClick: onClick)
          ],
        ),
      ),
    );
  }

  onClick(int selectedIndex){
    setState(() {
      currentIndex = selectedIndex;
      switch(currentIndex){
        case 0:
          body = MapScreen();
          break;
        case 1:
          body = MapScreen();
          break;
        case 2:
          body = MapScreen();
          break;
        case 3:
          body = MapScreen();
          break;
        case 4:
          body = MapScreen();
          break;
      }
    });
  }
}
