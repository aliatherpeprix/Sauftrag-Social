
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class AddDialogPlusAttachment extends StatefulWidget {


  AddDialogPlusAttachment({Key? key,}) : super(key: key);

  @override
  _AddDialogPlusAttachmentState createState() => _AddDialogPlusAttachmentState();
}

class _AddDialogPlusAttachmentState extends State<AddDialogPlusAttachment> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: 4.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //Select From
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Select From',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: FontUtils.modernistBold,
                        fontSize: 2.3.t,
                        color: ColorUtils.red_color
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                //Camera Button
                Container(
                  width: 45.w,
                  child: ElevatedButton(
                    onPressed: () {
                      //model.sendImageMessage(widget.id)
                      // model.navigateBack();
                      // model.getImage1(context, Constants.camera);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SvgPicture.asset(ImageUtils.galleryIcon),
                        SizedBox(width: 3.w),
                        Text('Gallery')

                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorUtils.white,
                      onPrimary: ColorUtils.red_color,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: ColorUtils.red_color
                          )
                      ),
                      textStyle: TextStyle(
                        color: ColorUtils.white,
                        fontFamily: FontUtils.modernistRegular,
                        fontSize: 1.8.t,
                        //height: 0
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                //Gallery Button
                Container(
                  width: 45.w,
                  child: ElevatedButton(
                    onPressed: () {
                      model.navigateBack();
                      model.getImage1(context, Constants.gallery);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SvgPicture.asset(ImageUtils.document, height: 3.5.h,),
                        SizedBox(width: 3.w),
                        Text('Document')

                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorUtils.white,
                      onPrimary: ColorUtils.red_color,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: ColorUtils.red_color
                          )
                      ),
                      textStyle: TextStyle(
                        color: ColorUtils.white,
                        fontFamily: FontUtils.modernistRegular,
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
      },
    );
  }
}
