// ignore_for_file: file_names

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/widgets/radler_dialog_box.dart';
import 'package:stacked/stacked.dart';

class BarTimingAndType extends StatefulWidget {
  const BarTimingAndType({Key? key}) : super(key: key);

  @override
  _BarTimingAndTypeState createState() => _BarTimingAndTypeState();
}

class _BarTimingAndTypeState extends State<BarTimingAndType> {

  DateTime _dateTime = DateTime.now();

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
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics:  BouncingScrollPhysics(),
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
                                )),
                            SizedBox(width: 2.w),
                            Text(
                              "Bar Timing",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.5.t,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),

                        Text(
                          "Please set your bar opening time",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        Wrap(
                          spacing: 2.w,
                          //runSpacing: 1.5.h,
                          direction: Axis.horizontal,
                          children: model.weekDaysList
                              .map((element) => ElevatedButton(
                                    onPressed: () {
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
                                    child: Text(model.weekDaysList[
                                        model.weekDaysList.indexOf(element)]),
                                    style: ElevatedButton.styleFrom(
                                      primary: model.selectedWeekDays.contains(
                                              model.weekDaysList.indexOf(element))
                                          ? ColorUtils.text_red
                                          : ColorUtils.white,
                                      onPrimary: model.selectedWeekDays
                                              .contains(model.weekDaysList
                                                  .indexOf(element))
                                          ? ColorUtils.white
                                          : ColorUtils.text_dark,
                                     /* padding: EdgeInsets.symmetric(
                                          vertical: 1.8.h, horizontal: 9.w),*/
                                      elevation: model.selectedWeekDays
                                              .contains(model.weekDaysList
                                                  .indexOf(element))
                                          ? 5
                                          : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.roundCorner),
                                          side: BorderSide(
                                              color: model.selectedWeekDays
                                                      .contains(model.weekDaysList
                                                          .indexOf(element))
                                                  ? ColorUtils.text_red
                                                  : ColorUtils.divider,
                                              width: 1)),
                                      textStyle: TextStyle(
                                        //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                        fontFamily: model.selectedWeekDays
                                                .contains(model.weekDaysList
                                                    .indexOf(element))
                                            ? FontUtils.modernistBold
                                            : FontUtils.modernistRegular,
                                        fontSize: 1.5.t,
                                        //height: 0
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),

                        ///----Bar opening time-----///
                        SizedBox(height: 3.h),
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 1*SizeConfig.widthMultiplier),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      width: 45.w,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                          SizeConfig.heightMultiplier*2,
                                          horizontal: SizeConfig.widthMultiplier*1
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.roundCorner)),
                                          border:
                                          Border.all(color: ColorUtils.divider)),
                                      child: TimePickerSpinner(
                                        is24HourMode: false,
                                        normalTextStyle: TextStyle(
                                          fontSize: 14,
                                          //color: Colors.deepOrange
                                        ),
                                        highlightedTextStyle: TextStyle(
                                          fontSize: 14,
                                          //color: Colors.yellow
                                        ),
                                        spacing: 1,
                                        itemHeight: 15,
                                        //isForce2Digits: false,
                                        minutesInterval: 5,
                                        onTimeChange: (time) {
                                          setState(() {
                                            _dateTime = time;
                                          });
                                        },
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.w),
                                    //padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    color: ColorUtils.white,
                                    child: Text(
                                      "To",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.5.t,
                                          height: .4),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 45.w,
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                        SizeConfig.heightMultiplier*2,
                                        /*horizontal:
                                        SizeConfig.widthMultiplier*1*/),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.roundCorner)),
                                        border:
                                        Border.all(color: ColorUtils.divider)),
                                    child: Row(
                                      children: [
                                        TimePickerSpinner(
                                          is24HourMode: false,
                                          normalTextStyle: TextStyle(
                                            fontSize: 14,
                                            //color: Colors.deepOrange
                                          ),
                                          highlightedTextStyle: TextStyle(
                                            fontSize: 14,
                                            //color: Colors.yellow
                                          ),
                                          spacing: 1,
                                          itemHeight: 15,
                                          //isForce2Digits: false,
                                          minutesInterval: 5,
                                          onTimeChange: (time) {
                                            setState(() {
                                              _dateTime = time;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.w),
                                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    color: ColorUtils.white,
                                    child: Text(
                                      "To",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.5.t,
                                          height: .4),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

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
                          //padding: EdgeInsets.symmetric(horizontal: 1*SizeConfig.widthMultiplier),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      width: 45.w,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                          SizeConfig.heightMultiplier*2,
                                          horizontal: SizeConfig.widthMultiplier*1
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.roundCorner)),
                                          border:
                                          Border.all(color: ColorUtils.divider)),
                                      child: TimePickerSpinner(
                                        is24HourMode: false,
                                        normalTextStyle: TextStyle(
                                          fontSize: 14,
                                          //color: Colors.deepOrange
                                        ),
                                        highlightedTextStyle: TextStyle(
                                          fontSize: 14,
                                          //color: Colors.yellow
                                        ),
                                        spacing: 1,
                                        itemHeight: 15,
                                        //isForce2Digits: false,
                                        minutesInterval: 5,
                                        onTimeChange: (time) {
                                          setState(() {
                                            _dateTime = time;
                                          });
                                        },
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.w),
                                    //padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    color: ColorUtils.white,
                                    child: Text(
                                      "To",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.5.t,
                                          height: .4),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 45.w,
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                      SizeConfig.heightMultiplier*2,
                                      /*horizontal:
                                        SizeConfig.widthMultiplier*1*/),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.roundCorner)),
                                        border:
                                        Border.all(color: ColorUtils.divider)),
                                    child: Row(
                                      children: [
                                        TimePickerSpinner(
                                          is24HourMode: false,
                                          normalTextStyle: TextStyle(
                                            fontSize: 14,
                                            //color: Colors.deepOrange
                                          ),
                                          highlightedTextStyle: TextStyle(
                                            fontSize: 14,
                                            //color: Colors.yellow
                                          ),
                                          spacing: 1,
                                          itemHeight: 15,
                                          //isForce2Digits: false,
                                          minutesInterval: 5,
                                          onTimeChange: (time) {
                                            setState(() {
                                              _dateTime = time;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.w),
                                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    color: ColorUtils.white,
                                    child: Text(
                                      "To",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.5.t,
                                          height: .4),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///----Kind of Bar----///
                        SizedBox(height: 3.h),
                        Text(
                          "Bar Timing",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Wrap(
                          spacing: 2.5.w,
                          runSpacing: 1.5.h,
                          direction: Axis.horizontal,
                          children: model.barKindList
                              .map((element) => ElevatedButton(
                            onPressed: () {
                              if (model.selectedBarKind.contains(
                                  model.barKindList.indexOf(element))) {
                                model.selectedBarKind.remove(
                                    model.barKindList.indexOf(element));
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
                                model.selectedBarKind.add(
                                    model.barKindList.indexOf(element));
                              }
                              model.notifyListeners();
                            },
                            child: Text(model.barKindList[
                            model.barKindList.indexOf(element)]),
                            style: ElevatedButton.styleFrom(
                              primary: model.selectedBarKind.contains(
                                  model.barKindList.indexOf(element))
                                  ? ColorUtils.text_red
                                  : ColorUtils.white,
                              onPrimary: model.selectedBarKind
                                  .contains(model.barKindList
                                  .indexOf(element))
                                  ? ColorUtils.white
                                  : ColorUtils.text_dark,
                               padding: EdgeInsets.symmetric(
                                          vertical: 1.8.h, horizontal: 9.w),
                              elevation: model.selectedBarKind
                                  .contains(model.barKindList
                                  .indexOf(element))
                                  ? 5
                                  : 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.roundCorner),

                                  side: BorderSide(
                                      color: model.selectedBarKind
                                          .contains(model.barKindList
                                          .indexOf(element))
                                          ? ColorUtils.text_red
                                          : ColorUtils.divider,
                                      width: 1),

                              ),
                              textStyle: TextStyle(
                                //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                fontFamily: model.selectedBarKind
                                    .contains(model.barKindList
                                    .indexOf(element))
                                    ? FontUtils.modernistBold
                                    : FontUtils.modernistRegular,
                                fontSize: 1.5.t,
                                //height: 0
                              ),
                            ),
                          ))
                              .toList(),
                        ),


                        SizedBox(height: 6.h),


                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.navigateToHomeBarScreen();
                            },
                            child: const Text("Let's Get Started"),
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
