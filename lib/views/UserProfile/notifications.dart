import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class UserNotifications extends StatefulWidget {
  @override
  _UserNotificationsState createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {

  bool _isSwitch =false;
  bool _isSwitch1 =false;
  bool _isSwitch2 =false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   title: Container(
          //     child: Text(
          //       "Notifications",
          //       style: TextStyle(
          //           color: Colors.black, fontSize: 2.5.t, fontFamily: FontUtils.modernistBold),
          //     ),
          //   ),
          // ),
          backgroundColor: Colors.white,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.topMargin),
                  Container(
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: Dimensions.horizontalPadding,
                    // ),
                    child:  Row(
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
                          "Notifications",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 3.t,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [

                      Text(
                        "Push Notifications",
                        style:
                        TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                    width: 350.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("On",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                        Switch(
                          value: _isSwitch,
                          onChanged: (value) {
                            setState(() {
                              _isSwitch = value;
                              print(_isSwitch);
                            });
                          },
                          activeTrackColor:ColorUtils.red_color,
                          activeColor: ColorUtils.red_color,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),

                    height: 15.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Receiving Messages",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                            Switch(
                              value: _isSwitch1,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitch1 = value;
                                  print(_isSwitch1);
                                });
                              },
                              activeTrackColor:ColorUtils.red_color,
                              activeColor: ColorUtils.red_color,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("New Friend Requests",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                            Switch(
                              value: _isSwitch2,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitch2 = value;
                                  print(_isSwitch2);
                                });
                              },
                              activeTrackColor:ColorUtils.red_color,
                              activeColor: ColorUtils.red_color,
                            ),
                          ],
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
