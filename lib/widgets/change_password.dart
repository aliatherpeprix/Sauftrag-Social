import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:stacked/stacked.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        //model.initialize();
      },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: (){
              context.unFocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.topMargin),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                      child: Row(
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
                            "Change Password",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.0.h,
                          ),

                          SizedBox(height: 1.5.h,),

                          ///Current Password
                          Text(
                            "Current Password",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                            ),
                          ),

                          SizedBox(height: 3.h),

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
                                        obscureText: !model.changeCurrentPasswordUserVisible,
                                        focusNode: model.changeCurrentPasswordUserFocus,
                                        controller: model.changeCurrentPasswordUserController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: ColorUtils.red_color,
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
                                    SizedBox(width: 3.w),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          model.changeCurrentPasswordUserVisible = !model.changeCurrentPasswordUserVisible;
                                        });
                                      },
                                      icon: Icon(model.changeCurrentPasswordUserVisible
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
                                  "Current Password",
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

                          SizedBox(height: 4.h),

                          ///New Password
                          Text(
                            "New Password",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                            ),
                          ),

                          SizedBox(height: 3.h),

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
                                        obscureText: !model.changeNewPasswordUserVisible,
                                        focusNode: model.changeNewPasswordUserFocus,
                                        controller: model.changeNewPasswordUserController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: ColorUtils.red_color,
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
                                    SizedBox(width: 3.w),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          model.changeNewPasswordUserVisible = !model.changeNewPasswordUserVisible;
                                        });
                                      },
                                      icon: Icon(model.changeNewPasswordUserVisible
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
                                  "New Password",
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
                          SizedBox(height: 4.h,),
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
                                        obscureText: !model.changeNewCurrentPasswordUserVisible,
                                        focusNode: model.changeNewCurrentPasswordUserFocus,
                                        controller: model.changeNewCurrentPasswordUserController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: ColorUtils.red_color,
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
                                    SizedBox(width: 3.w),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          model.changeNewCurrentPasswordUserVisible = !model.changeNewCurrentPasswordUserVisible;
                                        });
                                      },
                                      icon: Icon(model.changeNewCurrentPasswordUserVisible
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
                                  "Confirm New Password",
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
                          SizedBox(height: 6.h,),
                          SizedBox(
                            width: double.infinity,
                            //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                            child: ElevatedButton(
                              onPressed: () {
                                model.changePassword();
                              },
                              child: const Text("Change Password"),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
