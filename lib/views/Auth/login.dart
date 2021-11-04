import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SizedBox(height: 2.h),

                          //Logo
                          SvgPicture.asset(ImageUtils.logo),

                          //Welcome back!
                          Text(
                            "Welcome back!",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),

                          //Choose account type
                          Text(
                            "Choose account type",
                            style: TextStyle(
                              color: ColorUtils.text_grey,
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.8.t,
                            ),
                          ),

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

                          //Username
                          Stack(
                            children: [

                              Container(
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
                                        //controller: model.logInEmailController,
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

                          //Password
                          Stack(
                            children: [

                              Container(
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
                                        //controller: model.logInEmailController,
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

                          //Sign in Button
                          SizedBox(
                            width: double.infinity,
                            //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                            child: ElevatedButton(
                              onPressed: () {
                                model.navigateToHomeScreen(2);
                              },
                              child: const Text("Sign In"),
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

                          //or sign in with
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(
                                child: Divider(
                                  color: ColorUtils.divider,
                                  thickness: 1,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Text("or sign in with",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.8.t,

                                  ),
                                ),
                              ),

                              Expanded(
                                child: Divider(
                                  color: ColorUtils.divider,
                                  thickness: 1,
                                ),
                              ),

                            ],
                          ),

                          //Social login Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              //Google
                              SizedBox(
                                height: 16.i,
                                width: 16.i,
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  child: SvgPicture.asset(ImageUtils.googleIcon),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorUtils.white  ,
                                    onPrimary: ColorUtils.white,
                                    //padding: EdgeInsets.symmetric(vertical: 5.i, horizontal: 5.i),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                      side: BorderSide(
                                        color: ColorUtils.divider,
                                        width: 1
                                      )
                                    ),
                                  ),
                                ),
                              ),

                              //Facebook
                              SizedBox(
                                height: 16.i,
                                width: 16.i,
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  child: SvgPicture.asset(ImageUtils.facebookIcon),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorUtils.white  ,
                                    onPrimary: ColorUtils.white,
                                    //padding: EdgeInsets.symmetric(vertical: 5.i, horizontal: 5.i),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                        side: BorderSide(
                                            color: ColorUtils.divider,
                                            width: 1
                                        )
                                    ),
                                  ),
                                ),
                              ),

                              //Twitter
                              SizedBox(
                                height: 16.i,
                                width: 16.i,
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  child: SvgPicture.asset(ImageUtils.twitterIcon),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorUtils.white  ,
                                    onPrimary: ColorUtils.white,
                                    //padding: EdgeInsets.symmetric(vertical: 5.i, horizontal: 5.i),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                        side: BorderSide(
                                            color: ColorUtils.divider,
                                            width: 1
                                        )
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                          //Don't have an account? Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,

                                ),
                              ),
                              InkWell(
                                onTap: () => model.navigateToSignUpScreen(),
                                child: Text("Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorUtils.text_red,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 1.8.t,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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