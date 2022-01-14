import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:stacked/stacked.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.forgetPasswordController.clear();
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
                children: [
                  SizedBox(height: Dimensions.topMargin),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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

                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 7.w),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                color: ColorUtils.emailBoxColor
                            ),
                            child: Image.asset(ImageUtils.emailImg, width: 15.i,),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        Text("Check Your Email",
                          style: TextStyle(
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 3.t,
                            color: ColorUtils.black,
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Text("We have sent a password recover instruction to your email.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                            color: ColorUtils.text_grey,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        // SizedBox(height: 6.h,),
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                               model.navigateToVerificationCodeScreen();
                            },
                            child: const Text("Open Email"),
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
