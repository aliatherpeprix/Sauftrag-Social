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
import 'package:stacked/stacked.dart';

class SignUp extends StatefulWidget {

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpUserController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
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
                                "Username",
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
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
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

                        //Phone No.
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

                                  SvgPicture.asset(ImageUtils.phoneIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpPhoneController,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
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
                                "Phone No.",
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

                        //Gender
                        Stack(
                          children: [

                            Container(
                              height: 7.h,
                              padding: EdgeInsets.symmetric(vertical: .8.h, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.divider)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: DropdownButton<String>(
                                        value: model.genderValueStr,
                                        items: model.genderList.asMap().values.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style : TextStyle(
                                                  fontSize: 1.8.t,
                                                  fontFamily: FontUtils.modernistRegular,
                                                  color: ColorUtils.black,
                                                  //height: 1.8
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (data) {
                                          setState(() {
                                            model.genderValueStr = data as String;
                                            model.genderValue = model.genderMap[model.genderValueStr] as int;
                                          });
                                        },
                                        hint: Text(
                                          "Select an option",
                                          style : TextStyle(
                                            fontSize: 1.8.t,
                                            fontFamily: FontUtils.modernistRegular,
                                            color: ColorUtils.text_grey,
                                          ),
                                        ),
                                        isExpanded: true,
                                        underline: Container(
                                        ),
                                        icon: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(Icons.keyboard_arrow_down_rounded, color: ColorUtils.black,)
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              color: ColorUtils.white,
                              child: Text(
                                "Gender",
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
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpPasswordController,
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
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
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpVerifyPasswordController,
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
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
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpAddressController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
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
                                "Enter your address",
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

                        //Date of Birth
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

                                  SvgPicture.asset(ImageUtils.calendarIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpDOBController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 2.t,
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
                                "Date of Birth",
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

                        //Relationship
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

                                  SvgPicture.asset(ImageUtils.relationIcon),

                                  SizedBox(width: 4.w),

                                  Expanded(
                                    child: TextField(
                                      //focusNode: model.logInEmailFocus,
                                      controller: model.signUpRelationshipController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 2.t,
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
                                "Relationship",
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

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              model.signupCheck = !model.signupCheck;
                            });
                          },
                            child: Row(
                              children: <Widget>[
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: ColorUtils.text_grey,
                                  ),
                                  child: Checkbox(
                                    checkColor: ColorUtils.white,
                                    activeColor: ColorUtils.text_red,
                                    value: model.isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        model.isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                    style: TextStyle(
                                        color: ColorUtils.text_grey,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.5.t,

                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 3.h),

                        //Sign up Button
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              //model.navigateToFavoriteScreen();
                              model.createUserAccount();
                            },
                            child: const Text("Sign Up"),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red  ,
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
                        SizedBox(height: 2.h),

                      ],
                    ),
                  ),
                )
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
