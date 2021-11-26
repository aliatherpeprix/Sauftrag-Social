import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class ResentPassword extends StatefulWidget {
  const ResentPassword({Key? key}) : super(key: key);

  @override
  _ResentPasswordState createState() => _ResentPasswordState();
}

class _ResentPasswordState extends State<ResentPassword> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
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
              body: Column(
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
                            )),
                        SizedBox(width: 2.w),
                        Text(
                          "Create New Password",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
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
                        Text("Your new password must be different with your previous used passwords.",
                          style: TextStyle(
                            height: 1.2,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.9.t,
                            color: ColorUtils.black,
                          ),
                        ),
                        SizedBox(height: 6.h,),
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
                                      //controller: model.logInEmailController,
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
                                "Confirm NewPassword",
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
                               model.navigateToBarHomeScreen();
                            },
                            child: const Text("Reset Password"),
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
        );
      },
    );
  }
}
