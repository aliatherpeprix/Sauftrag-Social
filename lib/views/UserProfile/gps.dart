import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:location/location.dart';

class GPS extends StatefulWidget {
  @override
  _GPSState createState() => _GPSState();
}

class _GPSState extends State<GPS> {
  bool serviceEnabled =false;
  PermissionStatus ?permissionGranted;
  LocationData ?locationData;
  Location location = new Location();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          // appBar: AppBar(
          //   elevation: ,
          //   leading:  IconButton(
          //       onPressed: () {
          //         model.navigateBack();
          //       },
          //       iconSize: 18.0,
          //       padding: EdgeInsets.zero,
          //       constraints: BoxConstraints(),
          //       icon: Icon(
          //         Icons.arrow_back_ios,
          //         color: ColorUtils.black,
          //         size: 4.5.i,
          //       )),
          //   title: Text(
          //     "GPS",
          //     style: TextStyle(
          //         fontSize: 3.t,
          //         fontFamily: FontUtils.modernistBold,
          //         color: Colors.black),
          //   ),
          //   backgroundColor: Colors.white,
          // ),
          backgroundColor: Colors.white,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalPadding,
              ),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.topMargin),

                  //Terms of Services
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            model.navigateBack();
                          },
                          iconSize: 18.0,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: ColorUtils.black,
                            size: 4.5.i,
                          )),
                      SizedBox(width: 2.w),
                      Text(
                        "GPS",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 3.t,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "GPS Service",
                        style: TextStyle(
                            fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding),
                    width: 350.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "On",
                          style: TextStyle(
                              color: ColorUtils.red_color,
                              fontFamily: FontUtils.modernistBold),
                        ),
                        Switch(
                          value: model.isSwitched,
                          onChanged: (value) async{
                            model.determinePosition();
                          },
                          activeTrackColor: ColorUtils.red_color,
                          activeColor: ColorUtils.red_color,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
