import 'package:flutter/material.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';


class MyErrorWidget extends StatelessWidget {

  final String error;
  const MyErrorWidget({Key? key,required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: 3.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Image.asset(ImageUtils.errorIcon, height: 20.i,),
            SizedBox(height: 3.h,),

            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: FontUtils.modernistBold,
                  fontSize: 2.t,
                  color: ColorUtils.black
              ),
            ),
            SizedBox(height: 3.h,),

            //Continue Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: ElevatedButton(
                onPressed: () {
                  //NavigationService().back();
                },
                child: Text('OK'),
                style: ElevatedButton.styleFrom(
                  primary: ColorUtils.text_red  ,
                  onPrimary: ColorUtils.white,
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
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
    );
  }
}
