import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class VerificationCode extends StatelessWidget {
  const VerificationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<RegistrationViewModel>.reactive(
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return /*model.otpLoading == true ? Center(child: Loader()) :*/
        SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BackArrowContainer(),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      // Center(
                      //   child: Image.asset(ImageUtils.otpLock,
                      //     width: 28.i,
                      //     height: 28.i,
                      //   ),
                      // ),
                      // SizedBox(height: 2.3.h,),
                      Text("We've send you a code",
                        style: TextStyle(
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 3.t,
                            color: ColorUtils.black
                        ),
                      ),
                      SizedBox(height: 1.5.h,),
                      Text("Please enter the code that you have received on your email.",

                        style: TextStyle(
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 1.8.t,
                            color: ColorUtils.text_grey
                        ),
                      ),
                      SizedBox(
                        height: 7.5.h,
                      ),
                      PinCodeTextField(
                        onDone: (value){
                          Future.delayed(Duration(seconds: 1)).then((data) {
                            model.verifyResetPasswordCode(context, value);
                          });
                          //model.navigateToResentPasswordScreen();
                        },
                        pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 4.5.w),
                        controller: model.codeController,
                        pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                        Duration(milliseconds: 300),
                        maxLength: 4,
                        pinBoxWidth: 16.w,
                        pinBoxRadius: 6,
                        pinBoxHeight: 16.w,
                        pinBoxColor: Colors.transparent,
                        defaultBorderColor: ColorUtils.text_grey,
                        hasTextBorderColor: ColorUtils.red_color,
                        pinBoxBorderWidth: 1.5,
                        keyboardType: TextInputType.number,
                        pinTextStyle: TextStyle(
                          fontFamily: FontUtils.modernistBold,
                          //fontWeight: FontWeight.w400,
                          fontSize: 3.t,
                        ),
                      ),
                      SizedBox(
                        height: 3.8.h,
                      ),
                      Center(
                        child: Text("Didn't receive OTP code?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                            color: ColorUtils.shadowColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.8.h,
                      ),
                      Center(
                        child: Text("Resend Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: ColorUtils.red_color,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 2.t,
                            color: ColorUtils.red_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
