// ignore_for_file: file_names

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sauftrag/bar/widgets/custom_date_picker.dart'
    as customDatePicker;
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/add_custom_bar.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/favorite_club.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:sauftrag/widgets/radler_dialog_box.dart';
import 'package:stacked/stacked.dart';

class BarTimingAndType extends StatefulWidget {
  const BarTimingAndType({Key? key}) : super(key: key);

  @override
  _BarTimingAndTypeState createState() => _BarTimingAndTypeState();
}

class _BarTimingAndTypeState extends State<BarTimingAndType> {
  DateTime _dateTime = DateTime.now();

  // @override
  // void didChangeDependencies() {
  //   openingTimeFrom = TimeOfDay.now().format(context);
  //   openingTimeTo = TimeOfDay.now().format(context);
  //   breakTimeFrom = TimeOfDay.now().format(context);
  //   breakTimeTo = TimeOfDay.now().format(context);
  //   weekEndOpeningTimeFrom = TimeOfDay.now().format(context);
  //   weekEndOpeningTimeTo = TimeOfDay.now().format(context);
  //   weekEndBreakTimeFrom = TimeOfDay.now().format(context);
  //   weekEndBreakTimeTo = TimeOfDay.now().format(context);
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.topMargin),

                        //Add Images
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       model.navigateBack();
                            //     },
                            //     iconSize: 18.0,
                            //     padding: EdgeInsets.zero,
                            //     constraints: BoxConstraints(),
                            //     icon: Icon(
                            //       Icons.arrow_back_ios,
                            //       color: ColorUtils.black,
                            //     )),
                            BackArrowContainer(),
                            SizedBox(width: 4.w),
                            Text(
                              "Bar Timing",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
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
                          spacing: 1.8.w,
                          runSpacing: 1.5.h,
                          direction: Axis.horizontal,
                          children: model.weekDaysList
                              .map((element) => GestureDetector(
                                    onTap: () {
                                      if (model.selectedWeekDays
                                          .contains(element.day__id!)) {
                                        model.selectedWeekDays
                                            .remove(element.day__id!);
                                      } else {
                                        model.selectedWeekDays
                                            .add(element.day__id!);
                                      }
                                      model.notifyListeners();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.2.h, horizontal: 5.w),
                                      decoration: BoxDecoration(
                                        // border: Border.all(color: model.selectedWeekDays
                                        //     .contains(model.weekDaysList
                                        //     .indexOf(element))
                                        //     ? ColorUtils.text_red
                                        //     : ColorUtils.icon_color,),
                                        borderRadius: BorderRadius.circular(4),
                                        color: model.selectedWeekDays
                                                .contains(element.day__id!)
                                            ? ColorUtils.text_red
                                            : ColorUtils.divider,
                                      ),
                                      child: Text(
                                        model
                                            .weekDaysList[model.weekDaysList
                                                .indexOf(element)]
                                            .day__name!,
                                        style: TextStyle(
                                          color: model.selectedWeekDays
                                                  .contains(element.day__id!)
                                              ? ColorUtils.white
                                              : ColorUtils.icon_color,
                                          fontFamily: model.selectedWeekDays
                                                  .contains(element.day__id!)
                                              ? FontUtils.modernistBold
                                              : FontUtils.modernistRegular,
                                          fontSize: 1.8.t,
                                          //height: 0
                                        ),
                                      ),
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
                                      onTap: () {
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.openingTimeFrom =
                                              value!.format(context);
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                        height: 6.h,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.h, horizontal: 3.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.openingTimeFrom!,
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
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.openingTimeTo =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.openingTimeTo!,
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
                          // margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              //From
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.breakTimeFrom =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.breakTimeFrom!,
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
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.breakTimeTo =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.breakTimeTo!,
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
                                      if (model.selectedWeekendDays
                                          .contains(element.day__id!)) {
                                        model.selectedWeekendDays
                                            .remove(element.day__id!);
                                      } else {
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
                                        model.selectedWeekendDays
                                            .add(element.day__id!);
                                      }
                                      model.notifyListeners();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.2.h, horizontal: 5.w),
                                      decoration: BoxDecoration(
                                        // border: Border.all(color: model.selectedWeekendDays
                                        //     .contains(model.weekendDaysList
                                        //     .indexOf(element))
                                        //     ? ColorUtils.text_red
                                        //     : ColorUtils.icon_color,),
                                        borderRadius: BorderRadius.circular(4),
                                        color: model.selectedWeekendDays
                                                .contains(element.day__id!)
                                            ? ColorUtils.text_red
                                            : ColorUtils.divider,
                                      ),
                                      child: Text(
                                        model
                                            .weekendDaysList[model
                                                .weekendDaysList
                                                .indexOf(element)]
                                            .day__name!,
                                        style: TextStyle(
                                          color: model.selectedWeekendDays
                                                  .contains(element.day__id!)
                                              ? ColorUtils.white
                                              : ColorUtils.icon_color,
                                          fontFamily: model.selectedWeekendDays
                                                  .contains(element.day__id!)
                                              ? FontUtils.modernistBold
                                              : FontUtils.modernistRegular,
                                          fontSize: 1.8.t,
                                          //height: 0
                                        ),
                                      ),
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
                                      onTap: () {
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.weekEndOpeningTimeFrom =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.weekEndOpeningTimeFrom!,
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
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.weekEndOpeningTimeTo =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.weekEndOpeningTimeTo!,
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
                          // margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              //From
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.weekEndBreakTimeFrom =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.weekEndBreakTimeFrom!,
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
                                        customDatePicker
                                            .showCustomTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: TimeOfDay.now().hour,
                                                    minute: 0),
                                                initialEntryMode:
                                                    customDatePicker
                                                        .TimePickerEntryMode
                                                        .dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME")
                                            .then((value) {
                                          model.weekEndBreakTimeTo =
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
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: ColorUtils.divider)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.weekEndBreakTimeTo!,
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

                        ///----Kind of Bar----///
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kind of Bar",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.5.t,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context){
                                      return AddCustomBar();
                                    }
                                );
                              },
                              child: Text(
                                "+ ""Add Bar",
                                style: TextStyle(
                                  color: ColorUtils.red_color,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                ),
                              ),
                            ),
                          ],
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
                                      } else {
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
                                              model.barKindList
                                                  .indexOf(element))
                                          ? ColorUtils.text_red
                                          : ColorUtils.white,
                                      onPrimary: model.selectedBarKind.contains(
                                              model.barKindList
                                                  .indexOf(element))
                                          ? ColorUtils.white
                                          : ColorUtils.text_dark,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.8.h, horizontal: 9.w),
                                      elevation: model.selectedBarKind.contains(
                                              model.barKindList
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
                              // model.signUpBarUserController.clear();
                              // model.signUpBarAddressController.clear();
                              // model.signUpEmailController.clear();
                              // model.signUpBarPasswordController.clear();
                              // model.signUpBarVerifyPasswordController.clear();
                              // model.LocationController.clear();
                              // model.selectedWeekDays.clear();
                              // model.selectedWeekendDays.clear();
                              // model.selectedBarKind.clear();
                              // //model.imageFiles = [];
                              // model.imageFiles = [
                              //   File(""),
                              //   File(""),
                              //   File(""),
                              //   File(""),
                              //   File(""),
                              //   File("")
                              // ];
                              model.dataCheck = false;
                              model.notifyListeners();
                              model.createAccount();
                              // model.barTiming(
                              //     openingTimeFrom,
                              //     openingTimeTo,
                              //     breakTimeFrom,
                              //     breakTimeTo,
                              //     weekEndOpeningTimeFrom,
                              //     weekEndOpeningTimeTo,
                              //     weekEndBreakTimeFrom,
                              //     weekEndBreakTimeTo
                              // );

                              //model.navigateToHomeBarScreen();
                            },
                            child: model.signInBar == false ? Text("Let's Get Started") : Loader(),
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
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
    );
  }
}
