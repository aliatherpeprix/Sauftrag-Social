import 'package:flutter/material.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/Auth/splash.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../utils/color_utils.dart';
import '../utils/image_utils.dart';


class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: (){model.navigateToSplashScreen();},
        //       icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   // title: Container(
        //   //   child: Text(
        //   //     "Notifications",
        //   //     style: TextStyle(
        //   //         color: Colors.black, fontSize: 2.5.t, fontFamily: FontUtils.modernistBold),
        //   //   ),
        //   // ),
        // ),
        backgroundColor: ColorUtils.white,
        body:Center(
          child:
          Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Image.asset(ImageUtils.internetError)),
        ),
      ),
    );
  }
}