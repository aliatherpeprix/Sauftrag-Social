import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class DeleteAcountDialogbox extends StatefulWidget {

  String title;
  String btnTxt;
  String icon;

   DeleteAcountDialogbox({Key? key, required this.title, required this.btnTxt, required this.icon}) : super(key: key);

  @override
  _DeleteAcountDialogboxState createState() => _DeleteAcountDialogboxState();
}

class _DeleteAcountDialogboxState extends State<DeleteAcountDialogbox> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeShareDialog(),
      builder: (context, model, child){
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            backgroundColor: Colors.white,
            child: Stack(
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    IconButton(
                      onPressed: (){
                        model.navigateBack();
                      },
                      iconSize: 15.0,
                      //padding: EdgeInsets.all(20),
                      //constraints: BoxConstraints(),
                      icon: SvgPicture.asset(ImageUtils.cancelIcon),
                    ),

                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 1.h),


                      SvgPicture.asset(ImageUtils.binIcon),
                      SizedBox(height: 3.h),


                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Do you really want to delete your account and make the radler lobby win???",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.7.t,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: (){
                                model.deleteSelected = true;
                                model.deleteUnselected = false;
                                model.notifyListeners();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 12.w),

                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: ColorUtils.text_red),
                                  color: model.deleteSelected == true ? ColorUtils.text_red
                                      : Colors.white,
                                ),
                                child: Text("Yes",
                                  style: TextStyle(
                                    color: model.deleteSelected == true ? Colors.white
                                        : ColorUtils.text_red,
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w,),
                            GestureDetector(
                              onTap: (){
                                model.deleteUnselected = true;
                                model.deleteSelected = false;
                                model.notifyListeners();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 12.w),

                                decoration: BoxDecoration(
                                  color: model.deleteUnselected == true ? ColorUtils.text_red
                                      : Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: ColorUtils.text_red),
                                ),
                                child: Text("No",
                                  style: TextStyle(
                                    color: model.deleteUnselected == true ? Colors.white
                                        : ColorUtils.text_red,
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
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
              ],
            )
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
