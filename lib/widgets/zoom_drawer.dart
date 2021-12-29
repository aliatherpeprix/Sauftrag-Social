import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sauftrag/bar/views/Home/bar_news_feed.dart';
import 'package:sauftrag/bar/widgets/my_side_menu.dart';
import 'package:sauftrag/utils/color_utils.dart';

class ZoomDrawerHome extends StatefulWidget {
  const ZoomDrawerHome({Key? key}) : super(key: key);

  @override
  _ZoomDrawerHomeState createState() => _ZoomDrawerHomeState();
}

class _ZoomDrawerHomeState extends State<ZoomDrawerHome> {
  final zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: zoomDrawerController,
        style:DrawerStyle.Style1,
          angle: 12.0,
          showShadow: true,
          borderRadius: 24,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
          backgroundColor: ColorUtils.red_color,
          slideWidth: MediaQuery.of(context).size.width * 65,
          menuScreen: MySideMenu(),
          mainScreen: BarNewsFeed()),
    );
  }
}

