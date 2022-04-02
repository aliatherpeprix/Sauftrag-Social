import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../bar/views/Profile/bar_account_ownership.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  double _value = 40.0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) async {
        PrefrencesViewModel prefs = locator<PrefrencesViewModel>();
        //UserModel? userModel;
        model.updateSignUpPhoneController.text = model.userModel!.phone_no!;
        model.updateLocations.text = model.userModel!.address!;
        model.userModel = (await prefs.getUser())!;
      },
      viewModelBuilder: () => locator<MainViewModel>(),
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
                              model.userModel!.username!,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontSize: 2.t,
                                  fontFamily: FontUtils.modernistBold),
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //     model.editBool = false;
                            //     model.updateSignUpPhoneController.clear();
                            //     model.notifyListeners();
                            //   },
                            //   child: Text(
                            //     "Edit",
                            //     style: TextStyle(
                            //         color: ColorUtils.red_color,
                            //         fontFamily: FontUtils.modernistRegular,
                            //         fontSize: 1.8.t,
                            //         decoration: TextDecoration.underline
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),

                        Container(
                          height: 7.h,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.containerVerticalPadding,
                              horizontal:
                                  Dimensions.containerHorizontalPadding),
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.roundCorner)),
                              border: Border.all(color: ColorUtils.divider)),
                          child: TextField(
                            //focusNode: model.signUpAddressFocus,
                            controller: model.updateSignUpPhoneController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              color: ColorUtils.red_color,
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.9.t,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                            ),
                          ),
                          // child: IntlPhoneField(
                          //   textAlignVertical: TextAlignVertical.center,
                          //   // countryCodeTextColor: ColorUtils.red_color,
                          //   // focusNode: model.signUpPhoneFocus,
                          //   controller: model.updateSignUpPhoneController,
                          //   autovalidateMode: AutovalidateMode.disabled,
                          //   dropdownIconPosition: IconPosition.trailing,
                          //   //dropDownIcon: Icon(Icons.),
                          //   //showDropdownIcon: false,
                          //   style: TextStyle(
                          //       fontFamily: FontUtils.modernistRegular,
                          //       fontSize: 1.9.t,
                          //       color: ColorUtils.red_color
                          //   ),
                          //   // autoValidate: false,
                          //   autofocus: false,
                          //   decoration: InputDecoration(
                          //     hintText: 'Enter Your Phone number',
                          //     hintStyle:
                          //     TextStyle(
                          //         color: ColorUtils.text_grey,
                          //         fontSize: 1.9.t,
                          //         fontFamily: FontUtils.modernistRegular
                          //     ),
                          //     suffixText: "",
                          //     isDense: true,
                          //     alignLabelWithHint: true,
                          //     counterText: "",
                          //     contentPadding: EdgeInsets.only(top: 0.h,left: 0.w,right: 0.w,bottom: 0.2.h),
                          //     focusedBorder: InputBorder.none,
                          //     labelStyle: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 0.0.t,
                          //     ),
                          //     //alignLabelWithHint: true,
                          //     //contentPadding: EdgeInsets.zero,
                          //     //labelText: 'Phone Number',
                          //     border: OutlineInputBorder(
                          //       borderSide: BorderSide.none,
                          //     ),
                          //   ),
                          //   onTap: (){},
                          //   initialCountryCode: 'DE',
                          //   onChanged: (phone) {
                          //     //model.loginCountryCode = phone.countryCode ;
                          //     // model.loginPhoneController.text = phone.number!;
                          //     //model.updateSignUpPhoneController.text = phone.completeNumber;
                          //     model.notifyListeners();
                          //   },
                          // ),
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
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.containerVerticalPadding,
                              horizontal:
                                  Dimensions.containerHorizontalPadding),
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.roundCorner)),
                              border: Border.all(color: ColorUtils.divider)),
                          child: GestureDetector(
                            onTap: () async {
                              model.navigateToAddAddressScreen();
                              var position = await model.determinePosition();
                              model.latitude = position.latitude;
                              model.latitude = position.longitude;
                            },
                            child: Row(
                              children: [
                                Container(
                                    child: SvgPicture.asset(
                                        ImageUtils.locationIcon)),
                                //SizedBox(width: 4.w),
                                Expanded(
                                  child: TextField(
                                    //focusNode: model.signUpAddressFocus,
                                    controller: model.updateLocations,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      color: ColorUtils.red_color,
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.9.t,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Maximum Distance",
                        //       style: TextStyle(
                        //           fontSize: 2.t,
                        //           fontFamily: FontUtils.modernistBold),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // Container(
                        //     width: 370.w,
                        //     height: 8.h,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: ColorUtils.red_color),
                        //         borderRadius: BorderRadius.circular(15)),
                        //     child: Center(
                        //         child: SfSlider(
                        //             thumbShape: SfThumbShape(),
                        //             thumbIcon: Center(
                        //                 child: Text(
                        //               _value.toStringAsFixed(0),
                        //               style: TextStyle(
                        //                   color: Colors.white, fontSize: 1.3.t),
                        //             )),
                        //             showLabels: false,
                        //             enableTooltip: true,
                        //             activeColor: ColorUtils.red_color,
                        //             inactiveColor: Color(0xFFFFE4E8),
                        //             min: 0.0,
                        //             max: 100,
                        //             value: _value,
                        //             onChanged: (dynamic value) {
                        //               setState(() {
                        //                 _value = value;
                        //               });
                        //             }))),
                        // SizedBox(
                        //   height: 3.h,
                        // ),
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
                            radioSelected = 1;
                            model.navigateToUserProfileAccountOwnershipScreen();
                            model.notifyListeners();
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
                              model.updateAccountDetials();
                              //model.navigateBack();
                            },
                            child: model.editProfile == false
                                ? Text("Save")
                                : Loader(),
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
