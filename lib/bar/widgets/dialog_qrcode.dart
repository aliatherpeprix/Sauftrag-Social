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
import 'package:stacked/stacked.dart';

class DialogQrCode extends StatefulWidget {

  String title;
  String btnTxt;
  String icon;

  DialogQrCode({Key? key, required this.title, required this.btnTxt, required this.icon}) : super(key: key);

  @override
  _DialogQrCodeState createState() => _DialogQrCodeState();
}

class _DialogQrCodeState extends State<DialogQrCode> {
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

                SvgPicture.asset(ImageUtils.barLock),
                SizedBox(height: 3.h),

                //Not Possible To Choose
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Sorry :(",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorUtils.red_color,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 2.4.t,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                //Not Possible To Choose
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Currently we are working on this amazing feature.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorUtils.black,
                      fontFamily: FontUtils.modernistRegular,
                      fontSize: 1.8.t,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
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
