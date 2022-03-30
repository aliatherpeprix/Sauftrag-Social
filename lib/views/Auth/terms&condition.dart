import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      builder: (context, model, child) {
        //model.getStarted = false;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
              top: false,
              bottom: false,
              child: AbsorbPointer(
                absorbing: model.getStarted,
                child: Scaffold(
                    backgroundColor: ColorUtils.white,
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.horizontalPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.topMargin),

                            //Terms of Services
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
                                  "Terms of Services",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 3.t,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),

                            //1- Terms & Conditions
                            Text(
                              "1- Terms & Conditions",
                              style: TextStyle(
                                color: ColorUtils.text_red,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.3.t,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt tempor erat, ut varius nunc. Etiam viverra nibh justo, vel molestie lectus ullamcorper nec. Praesent ullamcorper neque ut magna bibendum, in suscipit quam condimentum. In nisi velit, fermentum ut sem ornare, volutpat auctor odio. Pellentesque luctus eros ut ornare suscipit.",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.9.t,
                              ),
                            ),
                            SizedBox(height: 3.h),

                            //2- Privacy Policy
                            Text(
                              "2- Privacy Policy",
                              style: TextStyle(
                                color: ColorUtils.text_red,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.3.t,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt tempor erat, ut varius nunc. Etiam viverra nibh justo, vel molestie lectus ullamcorper nec. Praesent ullamcorper neque ut magna bibendum, in suscipit quam condimentum. In nisi velit, fermentum ut sem ornare, volutpat auctor odio. Pellentesque luctus eros ut ornare suscipit.",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.9.t,
                              ),
                            ),
                            SizedBox(height: 3.h),

                            //3- Data Protection
                            Text(
                              "3- Data Protection",
                              style: TextStyle(
                                color: ColorUtils.text_red,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.3.t,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt tempor erat, ut varius nunc. Etiam viverra nibh justo, vel molestie lectus ullamcorper nec. Praesent ullamcorper neque ut magna bibendum, in suscipit quam condimentum. In nisi velit, fermentum ut sem ornare, volutpat auctor odio. Pellentesque luctus eros ut ornare suscipit.",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.9.t,
                              ),
                            ),
                            SizedBox(height: 3.h),

                          ],
                        ),
                      ),
                    )),
              )
          ),
        );
      },
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      onModelReady: (model) =>
      {
        //model.imageFiles.clear()
      },
      disposeViewModel: false,
    );
  }
}
