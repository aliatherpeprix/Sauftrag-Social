import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  double _value = 40.0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SafeArea(
                top: false,
                bottom: false,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalPadding,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                  size: 4.5.i,
                                )),
                            SizedBox(width: 2.w),
                            Text(
                              "John Wick",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          height: 7.h,
                          child: TextFormField(
                            style: TextStyle(
                                color: ColorUtils.red_color,
                                fontFamily: FontUtils.modernistBold),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: ColorUtils.red_color)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(color: ColorUtils.red_color),
                                ),
                                focusColor: ColorUtils.red_color,
                                prefixIcon: CountryCodePicker(
                                  initialSelection: 'US',
                                  showCountryOnly: false,
                                ),
                                hintText: 'Enter Your Phone number',
                                hintStyle:
                                    TextStyle(color: ColorUtils.red_color)),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          height: 7.h,
                          child: TextFormField(
                            style: TextStyle(
                                color: Color(0xFFE20000),
                                fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: ColorUtils.red_color)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(color: ColorUtils.red_color),
                                ),
                                focusColor: ColorUtils.red_color,
                                hintText: 'anywhere in the world',
                                hintStyle:
                                    TextStyle(color: ColorUtils.red_color),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.my_location_sharp,
                                      color: ColorUtils.red_color,
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Maximum Distance",
                              style: TextStyle(
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            width: 370.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorUtils.red_color),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: SfSlider(
                                    thumbShape: SfThumbShape(),
                                    thumbIcon: Center(
                                        child: Text(
                                      _value.toStringAsFixed(0),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 1.3.t),
                                    )),
                                    showLabels: false,
                                    enableTooltip: true,
                                    activeColor: ColorUtils.red_color,
                                    inactiveColor: Color(0xFFFFE4E8),
                                    min: 0.0,
                                    max: 100,
                                    value: _value,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    }))),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        InkWell(
                          onTap: () {
                            model.navigateToChangePassword();
                          },
                          child: Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.horizontalPadding),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: ColorUtils.black,
                                      fontFamily: FontUtils.modernistBold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 4.5.i,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                        Text(
                          "Account Ownership",
                          style: TextStyle(
                              fontSize: 2.t,
                              fontFamily: FontUtils.modernistBold),
                        ),

                        SizedBox(
                          height: 2.h,
                        ),

                        InkWell(
                          onTap: () {
                            model.navigateToUserProfileAccountOwnershipScreen();
                          },
                          child: Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.horizontalPadding),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Account Ownership & Control",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontUtils.modernistBold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 4.5.i,
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 6.h),

                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.navigateBack();
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
                      ]),
                ),
              )),
        );
      },
    );
  }
}
