import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/widgets/custom_date_picker.dart'
    as customDatePicker;
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class DrinkStatusDialogBox extends StatefulWidget {
  String title;
  String btnTxt;
  String icon;

  DrinkStatusDialogBox(
      {Key? key, required this.title, required this.btnTxt, required this.icon})
      : super(key: key);

  @override
  _DrinkStatusDialogBoxState createState() => _DrinkStatusDialogBoxState();
}

class _DrinkStatusDialogBoxState extends State<DrinkStatusDialogBox> {
  String? drinkingFrom;
  String? drinkingTo;

  @override
  void didChangeDependencies() {
    drinkingFrom =
        TimeOfDay(hour: TimeOfDay.now().hour, minute: 0).format(context);
    drinkingTo =
        TimeOfDay(hour: TimeOfDay.now().hour, minute: 0).format(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeShareDialog(),
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            backgroundColor: Colors.white,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        model.navigateBack();
                      },
                      //iconSize: 8.0,
                      //padding: EdgeInsets.all(20),
                      //constraints: BoxConstraints(),
                      icon: SvgPicture.asset(ImageUtils.cancelIcon),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding,
                      vertical: Dimensions.verticalPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 1.h),

                      //Set Your Status
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Set Your Status",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),

                      //How much you wanna drink today and from what time to what time.
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "How much you wanna drink today and from what time to what time.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),

                      //Motor anwärmen
                      if(model.drinkIndex == 1)
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Gemütlich einen trinken",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorUtils.text_red,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                      ),
                      if(model.drinkIndex == 2)
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Motor anwärmen",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorUtils.text_red,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                      if(model.drinkIndex == 3)
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Schön einen reinorgeln",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorUtils.text_red,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                      if(model.drinkIndex == 4)
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Die Rüstung demolieren ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorUtils.text_red,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                      if(model.drinkIndex == 5)
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Sauftrag komplett erfüllen",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorUtils.text_red,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                      SizedBox(height: 3.h),

                      //Drinks List
                      SizedBox(
                          height: 7.h,
                          //color: ColorUtils.black,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeBottom: true,
                            removeTop: true,
                            removeLeft: true,
                            removeRight: true,
                            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        /*if(model.drinkIndexList.contains(index)){
                                      model.drinkIndexList.remove(index);
                                    }
                                    else{
                                      model.drinkIndexList.add(index);
                                    }
                                    model.notifyListeners();*/

                                        model.addRemoveDrink(index);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: SvgPicture.asset(
                                              model.drinkIndex <= index
                                                  ? ImageUtils.bottleUnselected
                                                  : ImageUtils
                                                      .bottleSelected)));
                                }),
                          )),
                      SizedBox(height: 4.h),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
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
                                              initialEntryMode: customDatePicker
                                                  .TimePickerEntryMode.dial,
                                              confirmText: "CONFIRM",
                                              cancelText: "NOT NOW",
                                              helpText: "BOOKING TIME")
                                          .then((value) {
                                        model.drinkingFrom = drinkingFrom =
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
                                              drinkingFrom!,
                                              style: TextStyle(
                                                color: ColorUtils.text_dark,
                                                fontFamily:
                                                    FontUtils.modernistRegular,
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
                                              initialEntryMode: customDatePicker
                                                  .TimePickerEntryMode.dial,
                                              confirmText: "CONFIRM",
                                              cancelText: "NOT NOW",
                                              helpText: "BOOKING TIME")
                                          .then((value) {
                                        model.drinkingTo =
                                            drinkingTo = value!.format(context);

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
                                              drinkingTo!,
                                              style: TextStyle(
                                                color: ColorUtils.text_dark,
                                                fontFamily:
                                                    FontUtils.modernistRegular,
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
                      SizedBox(height: 5.h),

                      // //Drinking Motivation
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     "Drinking Motivation",
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       color: ColorUtils.black,
                      //       fontFamily: FontUtils.modernistBold,
                      //       fontSize: 2.5.t,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 3.h),
                      //
                      // //Drinking Motivation Selector
                      // Container(
                      //   height: 6.h,
                      //   padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: Dimensions.containerHorizontalPadding),
                      //   decoration: BoxDecoration(
                      //       color: ColorUtils.white,
                      //       borderRadius: BorderRadius.all(Radius.circular(15)),
                      //       border: Border.all(color: ColorUtils.divider)
                      //   ),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Expanded(
                      //           child: DropdownButton<String>(
                      //             value: model.drinkMotivationValueStr,
                      //             items: model.drinkMotivationList.asMap().values.map((String value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(
                      //                   value,
                      //                   style : TextStyle(
                      //                     fontSize: 1.8.t,
                      //                     fontFamily: FontUtils.modernistRegular,
                      //                     color: ColorUtils.black,
                      //                     //height: 1.8
                      //                   ),
                      //                 ),
                      //               );
                      //             }).toList(),
                      //             onChanged: (data) {
                      //               setState(() {
                      //                 model.drinkMotivationValueStr = data as String;
                      //                 model.drinkMotivationValue = model.drinkMotivationMap[model.drinkMotivationValueStr] as int;
                      //               });
                      //             },
                      //             hint: Text(
                      //               "Select an option",
                      //               style : TextStyle(
                      //                 fontSize: 1.8.t,
                      //                 fontFamily: FontUtils.modernistRegular,
                      //                 color: ColorUtils.text_grey,
                      //               ),
                      //             ),
                      //             isExpanded: true,
                      //             underline: Container(
                      //             ),
                      //             icon: Align(
                      //                 alignment: Alignment.centerRight,
                      //                 child: Icon(Icons.keyboard_arrow_down_rounded, color: ColorUtils.black,)
                      //             ),
                      //           )
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 5.h),

                      //Save Button
                      ElevatedButton(
                        onPressed: () {
                          model.drinkStatus();
                          model.getDrinkStatus();
                          model.navigateBack();
                          model.updateStatus = true;
                          model.notifyListeners();
                        },
                        child: const Text("Save"),
                        style: ElevatedButton.styleFrom(
                          primary: ColorUtils.text_red,
                          onPrimary: ColorUtils.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 15.w),
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
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ],
            ));
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
