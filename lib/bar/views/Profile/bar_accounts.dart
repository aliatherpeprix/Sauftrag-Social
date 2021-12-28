import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class BarAccount extends StatefulWidget {
  const BarAccount({Key? key}) : super(key: key);

  @override
  _BarAccountState createState() => _BarAccountState();
}

class _BarAccountState extends State<BarAccount> {
  DateTime _dateTime = DateTime.now();
  String? openingTimeFrom;
  String? openingTimeTo;
  String? breakTimeFrom;
  String? breakTimeTo;

  @override
  void didChangeDependencies() {
    openingTimeFrom = TimeOfDay.now().format(context);
    openingTimeTo = TimeOfDay.now().format(context);
    breakTimeFrom = TimeOfDay.now().format(context);
    breakTimeTo = TimeOfDay.now().format(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            bottom: false,
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                        vertical: Dimensions.verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.topMargin),

                        //Add Images
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
                                  size: 4.i,
                                )),
                            SizedBox(width: 2.w),
                            Text(
                              "Account",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.w),
                        Text(
                          "Bar Timing",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        Text(
                          "Please set your bar opening time",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        // Wrap(
                        //   spacing: 2.w,
                        //   //runSpacing: 1.5.h,
                        //   direction: Axis.horizontal,
                        //   children: model.weekDaysList
                        //       .map((element) =>
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           if (model.selectedWeekDays.contains(model
                        //               .weekDaysList
                        //               .indexOf(element))) {
                        //             model.selectedWeekDays.remove(model
                        //                 .weekDaysList
                        //                 .indexOf(element));
                        //           } else {
                        //             /* if (element == "Radler") {
                        //                   showDialog(
                        //                       context: context,
                        //                       builder: (BuildContext context) {
                        //                         return RadlerDialogBox(
                        //                             title: "Add New Location",
                        //                             btnTxt: "Add Location",
                        //                             icon: ImageUtils
                        //                                 .addLocationIcon);
                        //                       });
                        //                 } */
                        //             /*  else {
                        //
                        //                 }*/
                        //             model.selectedWeekDays.add(model
                        //                 .weekDaysList
                        //                 .indexOf(element));
                        //           }
                        //           model.notifyListeners();
                        //         },
                        //         child: Text(model.weekDaysList[
                        //         model.weekDaysList.indexOf(element)]),
                        //         style: ElevatedButton.styleFrom(
                        //           primary: model.selectedWeekDays.contains(
                        //               model.weekDaysList
                        //                   .indexOf(element))
                        //               ? ColorUtils.text_red
                        //               : ColorUtils.white,
                        //           onPrimary: model.selectedWeekDays
                        //               .contains(model.weekDaysList
                        //               .indexOf(element))
                        //               ? ColorUtils.white
                        //               : ColorUtils.text_dark,
                        //           /* padding: EdgeInsets.symmetric(
                        //                   vertical: 1.8.h, horizontal: 9.w),*/
                        //           elevation: model.selectedWeekDays
                        //               .contains(model.weekDaysList
                        //               .indexOf(element))
                        //               ? 5
                        //               : 0,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(
                        //                   Dimensions.roundCorner),
                        //               side: BorderSide(
                        //                   color: model.selectedWeekDays
                        //                       .contains(model
                        //                       .weekDaysList
                        //                       .indexOf(element))
                        //                       ? ColorUtils.text_red
                        //                       : ColorUtils.divider,
                        //                   width: 1)),
                        //           textStyle: TextStyle(
                        //             //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                        //             fontFamily: model.selectedWeekDays
                        //                 .contains(model.weekDaysList
                        //                 .indexOf(element))
                        //                 ? FontUtils.modernistBold
                        //                 : FontUtils.modernistRegular,
                        //             fontSize: 1.5.t,
                        //             //height: 0
                        //           ),
                        //         ),
                        //       ))
                        //       .toList(),
                        // ),
                        Wrap(
                          spacing: 3.w,
                          //runSpacing: 1.5.h,
                          direction: Axis.horizontal,
                          children: model.weekDaysList
                              .map((element) => GestureDetector(
                            onTap: () {
                              if (model.selectedWeekDays.contains(
                                  model.weekDaysList.indexOf(element))) {
                                model.selectedWeekDays.remove(
                                    model.weekDaysList.indexOf(element));
                              }
                              else  {
                                /* if (element == "Radler") {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return RadlerDialogBox(
                                                    title: "Add New Location",
                                                    btnTxt: "Add Location",
                                                    icon: ImageUtils
                                                        .addLocationIcon);
                                              });
                                        } */
                                /*  else {

                                        }*/
                                model.selectedWeekDays.add(
                                    model.weekDaysList.indexOf(element));
                              }
                              model.notifyListeners();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 5.w),
                              decoration: BoxDecoration(
                                // border: Border.all(color: model.selectedWeekDays
                                //     .contains(model.weekDaysList
                                //     .indexOf(element))
                                //     ? ColorUtils.text_red
                                //     : ColorUtils.icon_color,),
                                borderRadius: BorderRadius.circular(4),
                                color: model.selectedWeekDays
                                    .contains(model.weekDaysList
                                    .indexOf(element))
                                    ? ColorUtils.text_red
                                    : ColorUtils.divider,
                              ),
                              child: Text(model.weekDaysList[
                              model.weekDaysList.indexOf(element)], style: TextStyle(
                                color: model.selectedWeekDays
                                    .contains(model.weekDaysList
                                    .indexOf(element))
                                    ? ColorUtils.white
                                    : ColorUtils.icon_color,
                                fontFamily: model.selectedWeekDays
                                    .contains(model.weekDaysList
                                    .indexOf(element))
                                    ? FontUtils.modernistBold
                                    : FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                                //height: 0
                              ),),

                            ),
                          ))
                              .toList(),
                        ),

                        ///----Bar opening time-----///
                        SizedBox(height: 5.h),
                        Container(
                         // margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              //From
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode:
                                            TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME")
                                            .then((value) {
                                          openingTimeFrom =
                                              value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                openingTimeFrom!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils
                                                      .modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            SvgPicture.asset(
                                                ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "From",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),

                              //To
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode:
                                            TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME")
                                            .then((value) {
                                          openingTimeTo =
                                              value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                openingTimeTo!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils
                                                      .modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            SvgPicture.asset(
                                                ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "To",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   //padding: EdgeInsets.symmetric(horizontal: 1*SizeConfig.widthMultiplier),
                        //   child: Row(
                        //     children: [
                        //       Stack(
                        //         children: [
                        //           Container(
                        //               width: 45.w,
                        //               padding: EdgeInsets.symmetric(
                        //                   vertical:
                        //                   SizeConfig.heightMultiplier*2,
                        //                   horizontal: SizeConfig.widthMultiplier*1
                        //               ),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   borderRadius: BorderRadius.all(
                        //                       Radius.circular(
                        //                           Dimensions.roundCorner)),
                        //                   border:
                        //                   Border.all(color: ColorUtils.divider)),
                        //               child: TimePickerSpinner(
                        //                 is24HourMode: false,
                        //                 normalTextStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   //color: Colors.deepOrange
                        //                 ),
                        //                 highlightedTextStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   //color: Colors.yellow
                        //                 ),
                        //                 spacing: 1,
                        //                 itemHeight: 15,
                        //                 //isForce2Digits: false,
                        //                 minutesInterval: 5,
                        //                 onTimeChange: (time) {
                        //                   setState(() {
                        //                     _dateTime = time;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //           Container(
                        //             margin: EdgeInsets.only(left: 5.w),
                        //             //padding: EdgeInsets.symmetric(horizontal: 1.w),
                        //             color: ColorUtils.white,
                        //             child: Text(
                        //               "To",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: ColorUtils.text_grey,
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.5.t,
                        //                   height: .4),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       Stack(
                        //         children: [
                        //           Container(
                        //             width: 45.w,
                        //             padding: EdgeInsets.symmetric(
                        //                 vertical:
                        //                 SizeConfig.heightMultiplier*2,
                        //                 /*horizontal:
                        //                 SizeConfig.widthMultiplier*1*/),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(
                        //                         Dimensions.roundCorner)),
                        //                 border:
                        //                 Border.all(color: ColorUtils.divider)),
                        //             child: Row(
                        //               children: [
                        //                 TimePickerSpinner(
                        //                   is24HourMode: false,
                        //                   normalTextStyle: TextStyle(
                        //                     fontSize: 14,
                        //                     //color: Colors.deepOrange
                        //                   ),
                        //                   highlightedTextStyle: TextStyle(
                        //                     fontSize: 14,
                        //                     //color: Colors.yellow
                        //                   ),
                        //                   spacing: 1,
                        //                   itemHeight: 15,
                        //                   //isForce2Digits: false,
                        //                   minutesInterval: 5,
                        //                   onTimeChange: (time) {
                        //                     setState(() {
                        //                       _dateTime = time;
                        //                     });
                        //                   },
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Container(
                        //             margin: EdgeInsets.only(left: 5.w),
                        //             padding: EdgeInsets.symmetric(horizontal: 1.w),
                        //             color: ColorUtils.white,
                        //             child: Text(
                        //               "To",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: ColorUtils.text_grey,
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.5.t,
                        //                   height: .4),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        ///---Bar Break Time----///
                        SizedBox(height: 3.h),
                        Text(
                          "Please set your bar break time",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                          ),
                        ),

                        SizedBox(height: 3.h),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              //From
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode:
                                            TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME")
                                            .then((value) {
                                          breakTimeFrom =
                                              value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                breakTimeFrom!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils
                                                      .modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            SvgPicture.asset(
                                                ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "From",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),

                              //To
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode:
                                            TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME")
                                            .then((value) {
                                          breakTimeTo = value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                breakTimeTo!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils
                                                      .modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            SvgPicture.asset(
                                                ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "To",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily:
                                            FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   //padding: EdgeInsets.symmetric(horizontal: 1*SizeConfig.widthMultiplier),
                        //   child: Row(
                        //     children: [
                        //       Stack(
                        //         children: [
                        //           Container(
                        //               width: 45.w,
                        //               padding: EdgeInsets.symmetric(
                        //                   vertical:
                        //                   SizeConfig.heightMultiplier*2,
                        //                   horizontal: SizeConfig.widthMultiplier*1
                        //               ),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   borderRadius: BorderRadius.all(
                        //                       Radius.circular(
                        //                           Dimensions.roundCorner)),
                        //                   border:
                        //                   Border.all(color: ColorUtils.divider)),
                        //               child: TimePickerSpinner(
                        //                 is24HourMode: false,
                        //                 normalTextStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   //color: Colors.deepOrange
                        //                 ),
                        //                 highlightedTextStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   //color: Colors.yellow
                        //                 ),
                        //                 spacing: 1,
                        //                 itemHeight: 15,
                        //                 //isForce2Digits: false,
                        //                 minutesInterval: 5,
                        //                 onTimeChange: (time) {
                        //                   setState(() {
                        //                     _dateTime = time;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //           Container(
                        //             margin: EdgeInsets.only(left: 5.w),
                        //             //padding: EdgeInsets.symmetric(horizontal: 1.w),
                        //             color: ColorUtils.white,
                        //             child: Text(
                        //               "To",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: ColorUtils.text_grey,
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.5.t,
                        //                   height: .4),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       Stack(
                        //         children: [
                        //           Container(
                        //             width: 45.w,
                        //             padding: EdgeInsets.symmetric(
                        //               vertical:
                        //               SizeConfig.heightMultiplier*2,
                        //               /*horizontal:
                        //                 SizeConfig.widthMultiplier*1*/),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(
                        //                         Dimensions.roundCorner)),
                        //                 border:
                        //                 Border.all(color: ColorUtils.divider)),
                        //             child: Row(
                        //               children: [
                        //                 TimePickerSpinner(
                        //                   is24HourMode: false,
                        //                   normalTextStyle: TextStyle(
                        //                     fontSize: 14,
                        //                     //color: Colors.deepOrange
                        //                   ),
                        //                   highlightedTextStyle: TextStyle(
                        //                     fontSize: 14,
                        //                     //color: Colors.yellow
                        //                   ),
                        //                   spacing: 1,
                        //                   itemHeight: 15,
                        //                   //isForce2Digits: false,
                        //                   minutesInterval: 5,
                        //                   onTimeChange: (time) {
                        //                     setState(() {
                        //                       _dateTime = time;
                        //                     });
                        //                   },
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Container(
                        //             margin: EdgeInsets.only(left: 5.w),
                        //             padding: EdgeInsets.symmetric(horizontal: 1.w),
                        //             color: ColorUtils.white,
                        //             child: Text(
                        //               "To",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: ColorUtils.text_grey,
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.5.t,
                        //                   height: .4),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(height: 4.h),
                        Text(
                          "Weekend Timings",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Wrap(
                          spacing: 3.w,
                          //runSpacing: 1.5.h,
                          direction: Axis.horizontal,
                          children: model.weekendDaysList
                              .map((element) => GestureDetector(
                            onTap: () {
                              if (model.selectedWeekendDays.contains(
                                  model.weekendDaysList.indexOf(element))) {
                                model.selectedWeekendDays.remove(
                                    model.weekendDaysList.indexOf(element));
                              }
                              else  {
                                /* if (element == "Radler") {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return RadlerDialogBox(
                                                    title: "Add New Location",
                                                    btnTxt: "Add Location",
                                                    icon: ImageUtils
                                                        .addLocationIcon);
                                              });
                                        } */
                                /*  else {

                                        }*/
                                model.selectedWeekendDays.add(
                                    model.weekendDaysList.indexOf(element));
                              }
                              model.notifyListeners();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 5.w),
                              decoration: BoxDecoration(
                                // border: Border.all(color: model.selectedWeekendDays
                                //     .contains(model.weekendDaysList
                                //     .indexOf(element))
                                //     ? ColorUtils.text_red
                                //     : ColorUtils.icon_color,),
                                borderRadius: BorderRadius.circular(4),
                                color: model.selectedWeekendDays
                                    .contains(model.weekendDaysList
                                    .indexOf(element))
                                    ? ColorUtils.text_red
                                    : ColorUtils.divider,
                              ),
                              child: Text(model.weekendDaysList[
                              model.weekendDaysList.indexOf(element)], style: TextStyle(
                                color: model.selectedWeekendDays
                                    .contains(model.weekendDaysList
                                    .indexOf(element))
                                    ? ColorUtils.white
                                    : ColorUtils.icon_color,
                                fontFamily: model.selectedWeekendDays
                                    .contains(model.weekendDaysList
                                    .indexOf(element))
                                    ? FontUtils.modernistBold
                                    : FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                                //height: 0
                              ),),

                            ),
                          ))
                              .toList(),
                        ),

                        ///----Bar opening time-----///
                        SizedBox(height: 5.h),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [

                              //From
                              Expanded(
                                child: Stack(
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode: TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME"
                                        ).then((value){
                                          openingTimeFrom = value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child:  Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(color: ColorUtils.divider)
                                        ),
                                        child: Row(
                                          children: [

                                            Expanded(
                                              child: Text(
                                                openingTimeFrom!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 4.w),

                                            SvgPicture.asset(ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "From",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),

                              //To
                              Expanded(
                                child: Stack(
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode: TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME"
                                        ).then((value){
                                          openingTimeTo = value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(color: ColorUtils.divider)
                                        ),
                                        child: Row(
                                          children: [

                                            Expanded(
                                              child: Text(
                                                openingTimeTo!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 4.w),

                                            SvgPicture.asset(ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "To",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   //padding: EdgeInsets.symmetric(horizontal: 1*SizeConfig.widthMultiplier),
                        //   child: Row(
                        //     children: [
                        //       Stack(
                        //         children: [
                        //           Container(
                        //               width: 45.w,
                        //               padding: EdgeInsets.symmetric(
                        //                   vertical:
                        //                   SizeConfig.heightMultiplier*2,
                        //                   horizontal: SizeConfig.widthMultiplier*1
                        //               ),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   borderRadius: BorderRadius.all(
                        //                       Radius.circular(
                        //                           Dimensions.roundCorner)),
                        //                   border:
                        //                   Border.all(color: ColorUtils.divider)),
                        //               child: TimePickerSpinner(
                        //                 is24HourMode: false,
                        //                 normalTextStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   //color: Colors.deepOrange
                        //                 ),
                        //                 highlightedTextStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   //color: Colors.yellow
                        //                 ),
                        //                 spacing: 1,
                        //                 itemHeight: 15,
                        //                 //isForce2Digits: false,
                        //                 minutesInterval: 5,
                        //                 onTimeChange: (time) {
                        //                   setState(() {
                        //                     _dateTime = time;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //           Container(
                        //             margin: EdgeInsets.only(left: 5.w),
                        //             //padding: EdgeInsets.symmetric(horizontal: 1.w),
                        //             color: ColorUtils.white,
                        //             child: Text(
                        //               "To",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: ColorUtils.text_grey,
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.5.t,
                        //                   height: .4),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       Stack(
                        //         children: [
                        //           Container(
                        //             width: 45.w,
                        //             padding: EdgeInsets.symmetric(
                        //                 vertical:
                        //                 SizeConfig.heightMultiplier*2,
                        //                 /*horizontal:
                        //                 SizeConfig.widthMultiplier*1*/),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(
                        //                         Dimensions.roundCorner)),
                        //                 border:
                        //                 Border.all(color: ColorUtils.divider)),
                        //             child: Row(
                        //               children: [
                        //                 TimePickerSpinner(
                        //                   is24HourMode: false,
                        //                   normalTextStyle: TextStyle(
                        //                     fontSize: 14,
                        //                     //color: Colors.deepOrange
                        //                   ),
                        //                   highlightedTextStyle: TextStyle(
                        //                     fontSize: 14,
                        //                     //color: Colors.yellow
                        //                   ),
                        //                   spacing: 1,
                        //                   itemHeight: 15,
                        //                   //isForce2Digits: false,
                        //                   minutesInterval: 5,
                        //                   onTimeChange: (time) {
                        //                     setState(() {
                        //                       _dateTime = time;
                        //                     });
                        //                   },
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Container(
                        //             margin: EdgeInsets.only(left: 5.w),
                        //             padding: EdgeInsets.symmetric(horizontal: 1.w),
                        //             color: ColorUtils.white,
                        //             child: Text(
                        //               "To",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: ColorUtils.text_grey,
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.5.t,
                        //                   height: .4),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        ///---Bar Break Time----///
                        SizedBox(height: 3.h),
                        Text(
                          "Please set your bar break time",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                          ),
                        ),

                        SizedBox(height: 3.h),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [

                              //From
                              Expanded(
                                child: Stack(
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode: TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME"
                                        ).then((value){
                                          breakTimeFrom = value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(color: ColorUtils.divider)
                                        ),
                                        child: Row(
                                          children: [

                                            Expanded(
                                              child: Text(
                                                breakTimeFrom!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 4.w),

                                            SvgPicture.asset(ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "From",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),

                              //To
                              Expanded(
                                child: Stack(
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode: TimePickerEntryMode.dial,
                                            confirmText: "CONFIRM",
                                            cancelText: "NOT NOW",
                                            helpText: "BOOKING TIME"
                                        ).then((value){
                                          breakTimeTo = value!.format(context);
                                          model.notifyListeners();
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(color: ColorUtils.divider)
                                        ),
                                        child: Row(
                                          children: [

                                            Expanded(
                                              child: Text(
                                                breakTimeTo!,
                                                style: TextStyle(
                                                  color: ColorUtils.text_dark,
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.6.t,
                                                  //height: .4
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 4.w),

                                            SvgPicture.asset(ImageUtils.upDownArrow),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 3.w),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                                      color: ColorUtils.white,
                                      child: Text(
                                        "To",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.5.t,
                                            height: .4
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///----Location----///
                        SizedBox(height: 3.h),
                        Text(
                          "Location",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.2.h, horizontal: 4.w),
                            // margin: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.roundCorner),
                                border: Border.all(
                                    color: model.LocationFocus.hasFocus ||
                                        model.LocationController.text
                                            .length !=
                                            0
                                        ? ColorUtils.red_color
                                        : ColorUtils.lightTextColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: model.LocationFocus,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 2.2.t,
                                        color: ColorUtils.red_color),
                                    controller: model.LocationController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "Enter Location",
                                      hintStyle: TextStyle(
                                          fontFamily:
                                          FontUtils.modernistRegular,
                                          color: ColorUtils.lightTextColor),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(ImageUtils.locationIcon,
                                    color: model.LocationFocus.hasFocus ||
                                        model.LocationController.text
                                            .length !=
                                            0
                                        ? ColorUtils.red_color
                                        : ColorUtils.lightTextColor)
                              ],
                            )),
                        SizedBox(height: 3.h),

                        ///------------Kind Of Bar ---------------///
                        Text(
                          "Kind of Bar",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 7.h,
                          padding: EdgeInsets.symmetric(vertical: .8.h,
                              horizontal: Dimensions
                                  .containerHorizontalPadding),
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.roundCorner)),
                              border: Border.all(color: ColorUtils.red_color)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: DropdownButton<String>(
                                    value: model.kindOfBarValueStr,
                                    items: model.kindOfBarList
                                        .asMap()
                                        .values
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 1.8.t,
                                            fontFamily: FontUtils
                                                .modernistRegular,
                                            color: ColorUtils.red_color,
                                            //height: 1.8
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (data) {
                                      setState(() {
                                        model.kindOfBarValueStr =
                                        data as String;
                                        model.kindOfBarValue =
                                        model.kindOfBarMap[model
                                            .kindOfBarValueStr] as int;
                                      });
                                    },
                                    hint: Text(
                                      "Select an option",
                                      style: TextStyle(
                                        fontSize: 1.8.t,
                                        fontFamily: FontUtils.modernistRegular,
                                        color: ColorUtils.red_color,
                                      ),
                                    ),
                                    isExpanded: true,
                                    underline: Container(
                                    ),
                                    icon: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: ColorUtils.red_color,)
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),

                        ///------------Block Contacts ---------------///
                        Text(
                          "Block Contacts",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        MaterialButton(

                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    Dimensions.roundCorner),
                                side: BorderSide(
                                    color: ColorUtils.lightTextColor
                                )
                            ),
                            onPressed: () {},

                            padding: EdgeInsets.symmetric(
                                vertical: 2.2.h, horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Block Contact", style: TextStyle(
                                  color: ColorUtils.lightTextColor,

                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 2.t,
                                ),),
                                Icon(Icons.arrow_forward_ios_rounded, size: 4.i,color: Colors.black)
                              ],
                            )),

                        SizedBox(height: 3.h),

                        MaterialButton(

                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    Dimensions.roundCorner),
                                side: BorderSide(
                                    color: ColorUtils.lightTextColor
                                )
                            ),
                            onPressed: () {
                              model.navigateToBarAccountOwnerShip();
                            },

                            padding: EdgeInsets.symmetric(
                                vertical: 2.2.h, horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Account Ownership & Control", style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 2.t,
                                ),),
                                Icon(Icons.arrow_forward_ios_rounded, size: 4.i, color: Colors.black,)
                              ],
                            )),
                        SizedBox(height: 6.h),


                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.navigateToHomeBarScreen();
                            },
                            child: const Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red,
                              onPrimary: ColorUtils.white,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  Dimensions.containerVerticalPadding),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.roundCorner)),
                              textStyle: TextStyle(
                                color: ColorUtils.white,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                //height: 0
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),


                      ],
                    ),
                  ),
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
