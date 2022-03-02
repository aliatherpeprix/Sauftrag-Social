import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

import 'loader.dart';

class AddDialogBoxDrink1 extends StatefulWidget {

  String title;
  String btnTxt;
  String icon;

  AddDialogBoxDrink1({Key? key, required this.title, required this.btnTxt, required this.icon}) : super(key: key);


  @override
  _AddDialogBoxDrink1State createState() => _AddDialogBoxDrink1State();
}

class _AddDialogBoxDrink1State extends State<AddDialogBoxDrink1> {
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Add New Drink
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorUtils.text_red,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 2.5.t,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                Container(
                  height: 6.h,
                  padding: EdgeInsets.symmetric( horizontal: Dimensions.containerHorizontalPadding),
                  decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                      border: Border.all(color: ColorUtils.text_red)
                  ),
                  child: Row(
                    children: [

                      SvgPicture.asset(widget.icon),

                      SizedBox(width: 4.w),

                      Expanded(
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(18),
                          ],
                          focusNode: model.addNewDrinkFocus,
                          controller: model.addNewDrinkController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                          ),
                          decoration: InputDecoration(
                            hintText: "Anything you like",
                            hintStyle: TextStyle(
                                fontFamily: FontUtils.modernistRegular,
                                color: ColorUtils.text_grey,
                                fontSize: 1.8.t
                            ),
                            border: InputBorder.none,
                            isDense:true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 5.h),

                //Button
                SizedBox(
                  width: double.infinity,
                  //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                  child: ElevatedButton(
                    onPressed: () async {

                      model.addFavoritedrink1();

                      //model.navigateToTermsScreen();
                    },
                    child: model.addDrink == false ? Text(widget.btnTxt) : Loader(),
                    style: ElevatedButton.styleFrom(
                      primary: ColorUtils.text_red ,
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
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
