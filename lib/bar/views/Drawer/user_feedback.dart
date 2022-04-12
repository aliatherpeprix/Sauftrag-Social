import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({Key? key}) : super(key: key);

  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(height: Dimensions.topMargin),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),

                  child:  Row(
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
                        "Feedback",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 3.t,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 5,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  //width: 200.0,
                  // margin: EdgeInsets.only(
                  //     left: SizeConfig.widthMultiplier * 4.5,
                  //     right: SizeConfig.widthMultiplier * 5,
                  //     top: SizeConfig.heightMultiplier * 3),

                  child: Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: ColorUtils.textFieldBg,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            //horizontal: SizeConfig.widthMultiplier * 3,
                            //vertical: SizeConfig.heightMultiplier * 2
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
                                child: SvgPicture.asset(
                                  ImageUtils.messageIcon,
                                  color: ColorUtils.icon_color,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 3,
                                      right: SizeConfig.widthMultiplier * 3),
                                  child: TextField(
                                    onTap: () {},
                                    //readOnly: true,
                                    //focusNode: model.searchFocus,
                                    controller:
                                    model.feedbackController,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      hintText: "Type your feedback here",
                                      hintStyle: TextStyle(
                                        //fontFamily: FontUtils.proximaNovaRegular,
                                        color: ColorUtils.icon_color,
                                        fontSize:
                                        SizeConfig.textMultiplier * 1.9,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                          SizeConfig.heightMultiplier * 2),
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.feedbackController.clear();
                              //model.favorites();
                              //model.navigateToMediaScreen();
                            },
                            child: const Text("Send"),
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

                      ],
                    ),
                  ),
                ),



              ],
            ),
          ),
        );
      },
    );
  }
}
