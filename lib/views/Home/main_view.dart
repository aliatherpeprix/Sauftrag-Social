import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/Home/swipe.dart';
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

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: true,
          child: SideMenu(
            key: model.sideMenuKey,
            menu: MySideMenu(),
            type: SideMenuType.shrinkNSlide,
            background: ColorUtils.text_red,
            closeIcon: null,
            maxMenuWidth: MediaQuery.of(context).size.width * 0.78,
            radius: BorderRadius.circular(25),
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
                    animationCurve: Curves.fastLinearToSlowEaseIn,
                    animationDuration: Duration(milliseconds: 1500),
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
                      setState(() {});
                    },
                  ),
                  /*CurvedNavigationBar(
              backgroundColor: ColorUtils.transparent,
              buttonBackgroundColor: ColorUtils.text_red,

              items: <Widget>[
                Icon(Icons.add, size: 30),
                Icon(Icons.list, size: 30),
                Icon(Icons.compare_arrows, size: 30),
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
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }

  onClick(int selectedIndex){
    setState(() {
      currentIndex = selectedIndex;
      switch(currentIndex){
        case 0:
          body = Swipe();
          break;
        case 1:
          body = Swipe();
          break;
        case 2:
          body = Swipe();
          break;
        case 3:
          body = Swipe();
          break;
        case 4:
          body = Swipe();
          break;
      }
    });
  }
}
