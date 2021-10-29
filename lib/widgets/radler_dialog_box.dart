
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class RadlerDialogBox extends StatefulWidget {

  String title;
  String btnTxt;
  String icon;

  RadlerDialogBox({Key? key, required this.title, required this.btnTxt, required this.icon}) : super(key: key);

  @override
  _RadlerDialogBoxState createState() => _RadlerDialogBoxState();
}

class _RadlerDialogBoxState extends State<RadlerDialogBox> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      //onModelReady: (data) => data.initializeShareDialog(),
      builder: (context, model, child){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 1.h),

                SvgPicture.asset(ImageUtils.errorIcon),
                SizedBox(height: 3.h),

                //Not Possible To Choose
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Not Possible To Choose",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorUtils.black,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 2.2.t,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                //Not Possible To Choose
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "You cannot select radler because it’s a drink for loser 👎 and radler is not an alcohol.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorUtils.black,
                      fontFamily: FontUtils.modernistRegular,
                      fontSize: 1.8.t,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                //Radler = Beer x Lemonade =
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                              text:  "Radler = ",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                              ),
                            ),
                            TextSpan(
                              text:  "Beer x Lemonade =",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,

                              ),
                            ),
                          ]
                      ),
                      maxLines: 2,
                    ),

                    SizedBox(width: 2.w),

                    SvgPicture.asset(ImageUtils.lemonadeIcon),

                  ],
                ),
                SizedBox(height: 1.h),

              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
