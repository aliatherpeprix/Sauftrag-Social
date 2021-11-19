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
                  physics: const NeverScrollableScrollPhysics(),
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
                              "Bar Images",
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
                          "Add up to 5 images to your profile for better match.",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        Wrap(
                          spacing: 2.w,
                          runSpacing: 1.5.h,
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

                        SizedBox(height: 3.h),
                        Stack(
                          children: [
                            Container(
                              width: 60.w,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  SizeConfig.heightMultiplier*2,
                                  horizontal:
                                  SizeConfig.widthMultiplier*2),
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
                                        fontSize: 24,
                                        color: Colors.deepOrange
                                    ),
                                    highlightedTextStyle: TextStyle(
                                        fontSize: 24,
                                        color: Colors.yellow
                                    ),
                                    //spacing: 20,
                                    itemHeight: 30,
                                    isForce2Digits: false,
                                    minutesInterval: 10,
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
                                "From",
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

                        SizedBox(height: 6.h),

                        //Images
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Image 1
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[0].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[0]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[0].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(0);
                                                model.notifyListeners();
                                              },
                                              child: DottedBorder(
                                                  color: ColorUtils.text_red,
                                                  strokeWidth: 1.5,
                                                  borderType: BorderType.RRect,
                                                  radius:
                                                      const Radius.circular(15),
                                                  dashPattern: [8],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          ColorUtils.text_red,
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[0].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(0);
                                                  model.notifyListeners();
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageUtils.cancelIcon),
                                                //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: ColorUtils.white,
                                                highlightColor:
                                                    ColorUtils.white,
                                              ),
                                            ),
                                    ],
                                  )),

                              //Image 2
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[1].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[1]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[1].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(1);
                                                model.notifyListeners();
                                              },
                                              child: DottedBorder(
                                                  color: ColorUtils.text_red,
                                                  strokeWidth: 1.5,
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(15),
                                                  dashPattern: [8],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          ColorUtils.text_red,
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[1].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(1);
                                                  model.notifyListeners();
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageUtils.cancelIcon),
                                                //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: ColorUtils.white,
                                                highlightColor:
                                                    ColorUtils.white,
                                              ),
                                            ),
                                    ],
                                  )),

                              //Image 3
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[2].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[2]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[2].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(2);
                                                model.notifyListeners();
                                              },
                                              child: DottedBorder(
                                                  color: ColorUtils.text_red,
                                                  strokeWidth: 1.5,
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(15),
                                                  dashPattern: [8],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          ColorUtils.text_red,
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[2].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(0);
                                                  model.notifyListeners();
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageUtils.cancelIcon),
                                                //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: ColorUtils.white,
                                                highlightColor:
                                                    ColorUtils.white,
                                              ),
                                            ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),

                        //Images
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Image 4
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[3].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[3]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[3].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(3);
                                                model.notifyListeners();
                                              },
                                              child: DottedBorder(
                                                  color: ColorUtils.text_red,
                                                  strokeWidth: 1.5,
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(15),
                                                  dashPattern: [8],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          ColorUtils.text_red,
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[3].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(3);
                                                  model.notifyListeners();
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageUtils.cancelIcon),
                                                //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: ColorUtils.white,
                                                highlightColor:
                                                    ColorUtils.white,
                                              ),
                                            ),
                                    ],
                                  )),
                              SizedBox(width: 2.5.w),
                              //Image 5
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[4].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[4]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[4].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(4);
                                                model.notifyListeners();
                                              },
                                              child: DottedBorder(
                                                  color: ColorUtils.text_red,
                                                  strokeWidth: 1.5,
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(15),
                                                  dashPattern: [8],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          ColorUtils.text_red,
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[4].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(4);
                                                  model.notifyListeners();
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageUtils.cancelIcon),
                                                //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: ColorUtils.white,
                                                highlightColor:
                                                    ColorUtils.white,
                                              ),
                                            ),
                                    ],
                                  )),
                            ],
                          ),
                        ),

                        SizedBox(height: 5.h),
                        Text(
                          "Bar Logo",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Image 1
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[0].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[0]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[0].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(0);
                                                model.notifyListeners();
                                              },
                                              child: DottedBorder(
                                                  color: ColorUtils.text_red,
                                                  strokeWidth: 1.5,
                                                  borderType: BorderType.RRect,
                                                  radius:
                                                      const Radius.circular(15),
                                                  dashPattern: [8],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          ColorUtils.text_red,
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[0].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(0);
                                                  model.notifyListeners();
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageUtils.cancelIcon),
                                                //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: ColorUtils.white,
                                                highlightColor:
                                                    ColorUtils.white,
                                              ),
                                            ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        //Next Button
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.navigateToTermsScreen();
                            },
                            child: const Text("Next"),
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
