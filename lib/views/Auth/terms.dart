import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class TermsOfService extends StatefulWidget {

  const TermsOfService({Key? key}) : super(key: key);

  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: Dimensions.topMargin),

                        //Terms of Services
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            IconButton(
                                onPressed: (){
                                  model.navigateBack();
                                },
                                iconSize: 18.0,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.arrow_back_ios, color: ColorUtils.black,)
                            ),
                            SizedBox(width: 2.w),

                            Text(
                              "Terms of Services",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.5.t,
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
                            fontSize: 2.t,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt tempor erat, ut varius nunc. Etiam viverra nibh justo, vel molestie lectus ullamcorper nec. Praesent ullamcorper neque ut magna bibendum, in suscipit quam condimentum. In nisi velit, fermentum ut sem ornare, volutpat auctor odio. Pellentesque luctus eros ut ornare suscipit.",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        //2- Privacy Policy
                        Text(
                          "2- Privacy Policy",
                          style: TextStyle(
                            color: ColorUtils.text_red,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.t,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt tempor erat, ut varius nunc. Etiam viverra nibh justo, vel molestie lectus ullamcorper nec. Praesent ullamcorper neque ut magna bibendum, in suscipit quam condimentum. In nisi velit, fermentum ut sem ornare, volutpat auctor odio. Pellentesque luctus eros ut ornare suscipit.",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        //3- Data Protection
                        Text(
                          "3- Data Protection",
                          style: TextStyle(
                            color: ColorUtils.text_red,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.t,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt tempor erat, ut varius nunc. Etiam viverra nibh justo, vel molestie lectus ullamcorper nec. Praesent ullamcorper neque ut magna bibendum, in suscipit quam condimentum. In nisi velit, fermentum ut sem ornare, volutpat auctor odio. Pellentesque luctus eros ut ornare suscipit.",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                          ),
                        ),
                        SizedBox(height: 3.h),

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
                                  child: SizedBox(
                                    height: 5.i,
                                    width: 5.i,
                                    child: Checkbox(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      checkColor: ColorUtils.white,
                                      activeColor: ColorUtils.text_red,
                                      value: model.signupCheck,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          model.signupCheck = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Flexible(
                                  child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                            text:  "I agree with the ",
                                            style: TextStyle(
                                                color: ColorUtils.text_dark,
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.8.t,
                                            ),
                                          ),
                                          TextSpan(
                                            text:  "Terms & Conditions",
                                            style: TextStyle(
                                                color: ColorUtils.text_red,
                                                fontFamily: FontUtils.modernistBold,
                                                fontSize: 1.8.t,

                                            ),
                                          ),
                                        ]
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 3.h),

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
                                  child: SizedBox(
                                    height: 5.i,
                                    width: 5.i,
                                    child: Checkbox(
                                      checkColor: ColorUtils.white,
                                      activeColor: ColorUtils.text_red,
                                      value: model.signupCheck,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          model.signupCheck = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Flexible(
                                  child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                            text:  "I agree with the ",
                                            style: TextStyle(
                                              color: ColorUtils.text_dark,
                                              fontFamily: FontUtils.modernistRegular,
                                              fontSize: 1.8.t,
                                            ),
                                          ),
                                          TextSpan(
                                            text:  "Data Protection",
                                            style: TextStyle(
                                              color: ColorUtils.text_red,
                                              fontFamily: FontUtils.modernistBold,
                                              fontSize: 1.8.t,

                                            ),
                                          ),
                                        ]
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 5.h),


                        //Next Button
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            child: const Text("Let’s Get Started"),
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
