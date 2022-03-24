import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:stacked/stacked.dart';

class UpcomingEventDetails extends StatefulWidget {
  const UpcomingEventDetails({Key? key}) : super(key: key);

  @override
  _UpcomingEventDetailsState createState() => _UpcomingEventDetailsState();
}

class _UpcomingEventDetailsState extends State<UpcomingEventDetails> {

  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.25; // from 0-1.0


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        //model.getUpcmoingUserDetails;
        model.getListOfUpcomingEvents();
        //print('barName:${widget.barName}');
      },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            floatingActionButton: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: MediaQuery.of(context).size.width / 1,
                  height: 6.5.h,
                  //margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: ColorUtils.text_red,
                    boxShadow: [
                      BoxShadow(
                        color: ColorUtils.text_red.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                     if(model.selectedUpcomingEvents!.is_attend!) {
                       model.removeAttendedEvent();
                       // DialogUtils().showDialog(MyErrorWidget(
                       //   error: "Yoo.. Sabar Rakh Kam chal rha hay",
                       // ));
                     }
                     else {
                       model.attendedEvent();
                     }
                    },
                    child:  Container(
                      height: 4.5.h,
                      decoration: BoxDecoration(
                          color: ColorUtils.red_color,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                            child: model.selectedUpcomingEvents!.is_attend!
                                ? Text(
                              "Attending Event",
                              style: TextStyle(
                                  color: ColorUtils.white,
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            )

                                : Text(
                              "Attend Event",
                              style: TextStyle(
                                  color: ColorUtils.white,
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            )
                        ),
                      ),
                    ),

                  ),
                ),

                // MaterialButton(
                //     onPressed: onButtonPressed,
                //   color: ColorUtils.greenColor,
                //   minWidth: MediaQuery.of(context).size.width /1,
                //   height: 7.h,
                //   textColor: Colors.white,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(6.0),
                //   ),
                //   // style: ElevatedButton.styleFrom(
                //   //     primary: ColorUtils.greenColor,
                //   //     shadowColor: ColorUtils.greenColor.withOpacity(0.25),
                //   //     shape: RoundedRectangleBorder(
                //   //         borderRadius: BorderRadius.circular(10.0)),
                //   //     minimumSize: Size(MediaQuery.of(context).size.width /1, 7.h),
                //   //   ),
                //     child: Text(
                //       textValue!,
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         fontFamily: FontUtils.avertaSemiBold,
                //         fontSize: 2.2.t,
                //         color: Colors.white,
                //       ),
                //     ),
                // ),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.getPadding().top,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.7,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 3.5.h),
                        decoration: BoxDecoration(
                            color: ColorUtils.white,
                            image: DecorationImage(image: NetworkImage(model.selectedUpcomingEvents!.media![0].media),
                                fit: BoxFit.cover)
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            color: Colors.black.withOpacity(_opacity),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                        child: Row(
                          children: [
                            Container(
                                width: 10.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: BackArrowContainer()),
                            SizedBox(
                              width: 3.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                //color: Colors.grey.withOpacity(0.1)
                              ),
                              child: Text(
                                "Event Details",
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.7.t,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          margin: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.6.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.navigateToOngoingUsersScreen();
                                    //model.selectedUpcomingEvents = (model.listOfUpcomingEvents[index]);
                                    //model.getUpcmoingUserDetails = (model.listOfUpcomingEvents[index]);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImageUtils.groupGoing,
                                        width: 18.i,
                                        height: 8.i,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                       model.selectedUpcomingEvents!.going_users!.length.toString(),
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.text_red),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtils.text_red,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 1.0.h),
                                      child: Text(
                                        "Invite",
                                        style: TextStyle(
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.6.t,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      //color: Colors.amber,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                        vertical: 3.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.selectedUpcomingEvents!.name!,
                            style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                                color: ColorUtils.blackText),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        color: ColorUtils.messageChat,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        ImageUtils.calendarIcon,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.selectedUpcomingEvents!.event_date!,
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 2.t,
                                            color: ColorUtils.text_dark),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        model.selectedUpcomingEvents!.start_time!,
                                        style: TextStyle(
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.text_dark),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SvgPicture.asset(ImageUtils.forwardIcon),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        color: ColorUtils.messageChat,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            ImageUtils.locationPin)),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Container(
                                    width: 65.w,
                                    child: Text(
                                      model.selectedUpcomingEvents!.location! ,
                                      style: TextStyle(
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 2.t,
                                          color: ColorUtils.text_dark),
                                    ),
                                  ),
                                ],
                              ),
                              // SvgPicture.asset(ImageUtils.forwardIcon),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtils.messageChat,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        model.selectedUpcomingEvents!.user_id!.profile_picture!,
                                        width: 12.i,
                                        height: 12.i,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.selectedUpcomingEvents!.user_id!.bar_name!,
                                        //'${widget.barName}',
                                        // widget.barName,
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 2.t,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "Organizer",
                                        style: TextStyle(
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.text_dark),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: (){
                              //     if(!model.isLoading) {
                              //       model.postBarFollow();
                              //     }
                              //   },
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: ColorUtils.red_color,
                              //       shape: BoxShape.rectangle,
                              //       borderRadius:
                              //       BorderRadius.all(Radius.circular(6)),
                              //     ),
                              //     child: Padding(
                              //       padding: EdgeInsets.symmetric(
                              //           horizontal: 3.5.w, vertical: 1.h),
                              //       child: Center(
                              //           child: model.selectedUpcomingEvents!.user_id!.is_follow!? Text(
                              //             "UnFollow",
                              //             style: TextStyle(
                              //                 color: ColorUtils.white,
                              //                 fontSize: 2.t,
                              //                 fontFamily: FontUtils.modernistBold),
                              //           ) : Text(
                              //             "Follow",
                              //             style: TextStyle(
                              //                 color: ColorUtils.white,
                              //                 fontSize: 2.t,
                              //                 fontFamily: FontUtils.modernistBold),
                              //           )
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "About Event",
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.2.t,
                                    color: ColorUtils.blackText),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                model.selectedUpcomingEvents!.about!,
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.9.t,
                                    color: ColorUtils.text_dark),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
