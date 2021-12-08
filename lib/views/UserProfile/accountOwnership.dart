import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
class OwnerShip extends StatefulWidget {
  const OwnerShip({Key? key}) : super(key: key);

  @override
  _OwnerShipState createState() => _OwnerShipState();
}

class _OwnerShipState extends State<OwnerShip> {
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              top: false,
              bottom: false,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.topMargin),
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
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "Account Ownership",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 3.h,),
                      Text("If you want to take a break from sauftrag, you can deactivate or you can delete your account,.",style: TextStyle(fontFamily: FontUtils.modernistRegular),),

                      SizedBox(
                        height: 4.h,
                      ),
                      Container(


                        decoration: BoxDecoration(
                            border: Border.all(color:ColorUtils.red_color),
                            borderRadius: BorderRadius.circular(15)),
                        child: RadioListTile(
                          activeColor: ColorUtils.red_color,
                          value: 1,
                          groupValue: val,
                          onChanged: (_value) {
                            setState(() => val = 1);
                          },
                          title: Text(
                            "Deactivate Account",
                            style: TextStyle(
                                color: ColorUtils.red_color,
                                fontSize: 2.t,
                                fontFamily: FontUtils.modernistBold),
                          ),
                          subtitle: Text(
                            "Deactivating your account is temporary. Your account will be disabled and your photos will be removed from most of the things.",
                            style: TextStyle(
                                fontSize: 1.7.t,
                                fontFamily: FontUtils.modernistRegular
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(

                        decoration: BoxDecoration(
                            border: Border.all(color: ColorUtils.red_color),
                            borderRadius: BorderRadius.circular(15)),
                        child: RadioListTile(
                          activeColor: ColorUtils.red_color,
                          value: 2,
                          groupValue: val,
                          onChanged: (_value) => setState(() => val = 2),
                          title: Text(
                            "Delete Account",
                            style: TextStyle(
                                color: ColorUtils.red_color,
                                fontSize: 2.t,
                                fontWeight: FontWeight.w700,fontFamily: FontUtils.modernistBold),
                          ),
                          subtitle: Text(
                            "Deleting your account is permament. When you delete your account, you won’t be able to retrieve the content or the information that you have shared.",
                            style: TextStyle(
                                fontSize: 1.7.t,
                                fontFamily: FontUtils.modernistRegular
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                titlePadding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                title: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
//color: Color(kColor)
                                              border: Border.all(color: ColorUtils.red_color,width: 0.5.w)
                                          ),
                                          child: InkWell(onTap: (){Navigator.pop(context);} ,child: Icon(Icons.close,color: ColorUtils.red_color,size: 15,))
                                      ),
                                    ),
                                    SvgPicture.asset(ImageUtils.binIcon),
                                    SizedBox(height: 1.5.h,),
                                    Text(
                                      "Do you really want to delete your account and make the radler lobby win???",
                                      style: TextStyle(fontSize: 1.8.t,fontFamily: FontUtils.modernistRegular),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
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
                                              model.deleteSelected = true;
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
                              ));
                        },
                        child: Container(
                          width: 370.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorUtils.red_color),
                          child: Center(
                            child: Text(
                              "Delete Account",
                              style: TextStyle(color: Colors.white,fontFamily: FontUtils.modernistBold),
                            ),
                          ),
                        ),
                      )
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
