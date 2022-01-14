
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class SignUpBar extends StatefulWidget {

  const SignUpBar({Key? key}) : super(key: key);

  @override
  _SignUpBarState createState() => _SignUpBarState();
}

class _SignUpBarState extends State<SignUpBar> {

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
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        SizedBox(height: Dimensions.topMargin),

                        //Logo
                        SvgPicture.asset(ImageUtils.logo),
                        SizedBox(height: 5.h),

                        //Create your account
                        Text(
                          "Create your account",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 3.t,
                          ),
                        ),
                        SizedBox(height: 5.h),

                        //Account Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            //User
                            ElevatedButton(
                              onPressed: () {
                                model.selectRole(Constants.user);
                                model.navigateToSignUpScreen();
                              },
                              child: const Text("User"),
                              style: ElevatedButton.styleFrom(
                                primary: model.role == Constants.user ? ColorUtils.text_red : ColorUtils.white,
                                onPrimary: model.role == Constants.user ? ColorUtils.white : ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                  fontFamily: model.role == Constants.user ? FontUtils.modernistBold : FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),

                            SizedBox(width: 5.w,),

                            //Bar
                            ElevatedButton(
                              onPressed: () {
                                model.selectRole(Constants.bar);
                                model.navigateToSignUpBar();
                              },
                              child: const Text("Bar"),
                              style: ElevatedButton.styleFrom(
                                primary: model.role == Constants.bar ? ColorUtils.text_red : ColorUtils.white,
                                onPrimary: model.role == Constants.bar ? ColorUtils.white : ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  //color: model.role == Constants.bar ? ColorUtils.white : ColorUtils.text_red,
                                  fontFamily: model.role == Constants.bar ? FontUtils.modernistBold : FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 5.h),

                        //Username
                        Stack(
                          children: [

                            Container(
                              height: 7.h,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.divider)
                              ),
                              child: Row(
                                children: [

                                  SvgPicture.asset(ImageUtils.userIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      focusNode: model.signUpBarUserFocus,
                                      controller: model.signUpBarUserController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.red_color,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.9.t,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense:true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              color: ColorUtils.white,
                              child: Text(
                                "Bar Name",
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
                        SizedBox(height: 3.h),

                        //Enter your address
                        Stack(
                          children: [

                            Container(
                              height: 7.h,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.divider)
                              ),
                              child: Row(
                                children: [

                                  SvgPicture.asset(ImageUtils.locationIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      focusNode: model.signUpBarAddressFocus,
                                      controller: model.signUpBarAddressController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.red_color,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.9.t,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense:true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              color: ColorUtils.white,
                              child: Text(
                                "Address",
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
                        SizedBox(height: 3.h),

                        //Email
                        Stack(
                          children: [

                            Container(
                              height: 7.h,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.divider)
                              ),
                              child: Row(
                                children: [

                                  SvgPicture.asset(ImageUtils.emailIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      focusNode: model.signUpBarEmailFocus,
                                      controller: model.signUpBarEmailController,
                                      //obscureText: !model.signupEmailVisible,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.red_color,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.9.t,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense:true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              color: ColorUtils.white,
                              child: Text(
                                "Email",
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
                        SizedBox(height: 3.h),

                        //Password
                        Stack(
                          children: [

                            Container(
                              height: 7.h,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.divider)
                              ),
                              child: Row(
                                children: [

                                  SvgPicture.asset(ImageUtils.passwordIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      focusNode: model.signUpBarPasswordFocus,
                                      controller: model.signUpBarPasswordController,
                                      obscureText: !model.signupPasswordVisible,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.red_color,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.9.t,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense:true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        model.signupPasswordVisible = !model.signupPasswordVisible;
                                      });
                                    },
                                    icon: Icon(model.signupPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                      color: ColorUtils.red_color,
                                      //size: 6 * SizeConfig.imageSizeMultiplier,
                                      //color: ColorUtils.textFormColor,),
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              color: ColorUtils.white,
                              child: Text(
                                "Password",
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
                        SizedBox(height: 3.h),


                        //Verify Password
                        Stack(
                          children: [

                            Container(
                              height: 7.h,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.divider)
                              ),
                              child: Row(
                                children: [

                                  SvgPicture.asset(ImageUtils.passwordIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      focusNode: model.signUpBarVerifyPasswordFocus,
                                      controller: model.signUpBarVerifyPasswordController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      obscureText: !model.signupVerifyPasswordVisible,
                                      style: TextStyle(
                                        color: ColorUtils.red_color,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.9.t,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense:true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        model.signupVerifyPasswordVisible = !model.signupVerifyPasswordVisible;
                                      });
                                    },
                                    icon: Icon(model.signupVerifyPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                      color: ColorUtils.red_color,
                                      //size: 6 * SizeConfig.imageSizeMultiplier,
                                      //color: ColorUtils.textFormColor,),
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              color: ColorUtils.white,
                              child: Text(
                                "Verify Password",
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
                        SizedBox(height: 5.h),

                        //Sign up Button
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.createBarAccount();
                            },
                            child: model.signInBar == false ? Text("Sign Up") : Loader(),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red,
                              onPrimary: ColorUtils.white,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.roundCorner)
                              ),
                              textStyle: TextStyle(
                                color: ColorUtils.white,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                //height: 0
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                // if(model.logInUserSelected == true){
                                //   model.navigateToSignUpScreen();
                                // }
                                // else if(model.logInBarSelected == true){
                                //   model.navigateToSignUpBar();
                                // }
                                model.navigateToLoginScreen();
                              },
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),

                      ],
                    ),
                  ),
                )
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      onModelReady: (model) =>
      {
        model.signUpBarUserController.clear(),
        model.signUpBarAddressController.clear(),
        model.signUpBarEmailController.clear(),
        model.signUpBarPasswordController.clear(),
        model.signUpBarVerifyPasswordController.clear(),
        model.LocationController.clear(),

      },
      disposeViewModel: false,
    );
  }
}
