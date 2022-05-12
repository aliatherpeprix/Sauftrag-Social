import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:stacked/stacked.dart';

class BarCreatePost extends StatefulWidget {
  const BarCreatePost({Key? key}) : super(key: key);

  @override
  _BarCreatePostState createState() => _BarCreatePostState();
}

class _BarCreatePostState extends State<BarCreatePost> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                                size: 4.5.i,
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "Create Post",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      ///--------------Event Name--------------------///
                      Stack(
                        children: [

                          Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.text_red)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: DropdownButton<String>(
                                      value: model.msgTypeValueStr,
                                      items: model.msgTypeList
                                          .asMap()
                                          .values
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 1.8.t,
                                              fontFamily: FontUtils
                                                  .modernistBold,
                                              color: ColorUtils.red_color,
                                              //height: 1.8
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (data) {
                                        setState(() {
                                          model.msgTypeValueStr =
                                          data as String;
                                          model.msgTypeValue =
                                          model.msgTypeMap[model
                                              .msgTypeValueStr] as int;
                                        });
                                      },
                                      hint: Text(
                                        "Select an option",
                                        style: TextStyle(
                                          fontSize: 1.8.t,
                                          fontFamily: FontUtils.modernistRegular,
                                          color: ColorUtils.red_color,
                                        ),
                                      ),
                                      isExpanded: true,
                                      underline: Container(
                                      ),
                                      icon: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: ColorUtils.black,
                                            size: 4.2.i,
                                          )
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),



                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Event Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),

                        ],
                      ),

                     SizedBox(height: 3.h),

                      ///------------------Event Location ------------------///
                      Stack(
                        children: [

                          Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.divider)
                            ),
                            child: TextField(
                              focusNode: model.barPostLocationFocus,
                              controller: model.barPostLocationController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                color: ColorUtils.text_red,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense:true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Location",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_grey,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      ///--------------Event Post--------------------///
                      Stack(
                        children: [

                          Container(
                            height: 16.h,
                              //padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.text_red)
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.widthMultiplier * 3,
                                    right: SizeConfig.widthMultiplier * 3),
                                child: TextField(
                                  onTap: () {},
                                  enabled: true,
                                  //readOnly: true,
                                  focusNode: model.barPostFocus,
                                  controller: model.barPostController,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: "Type your comment...",
                                    hintStyle: TextStyle(
                                      //fontFamily: FontUtils.proximaNovaRegular,

                                      //color: ColorUtils.silverColor,
                                      fontSize: SizeConfig.textMultiplier * 2,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: SizeConfig.heightMultiplier * 2),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  maxLength: 350,


                                ),
                              ),
                          ),


                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Write Post",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 3.h),

                      SizedBox(
                        height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Image 1
                            Container(
                                width:
                                MediaQuery.of(context).size.width / 3.4,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  image: model.imageFilesPost[0].path.isEmpty
                                      ? null
                                      : DecorationImage(
                                      image:
                                      FileImage(model.imageFilesPost[0]),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [
                                    model.imageFilesPost[0].path.isEmpty
                                        ? InkWell(
                                        onTap: () {
                                          model.getPostImage(0);
                                          model.notifyListeners();
                                        },
                                        child: DottedBorder(
                                            color: ColorUtils.text_red,
                                            strokeWidth: 1.5,
                                            borderType: BorderType.RRect,
                                            radius:
                                            const Radius.circular(15),
                                            dashPattern: [8],
                                            child: Center(
                                              child: Icon(
                                                Icons.add_rounded,
                                                color:
                                                ColorUtils.text_red,
                                                size: 6.i,
                                              ),
                                            )))
                                        : Container(),
                                    model.imageFilesPost[0].path.isEmpty
                                        ? Container()
                                        : Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          model.imageFilesPost.removeAt(0);
                                          model.imageFilesPost.insert(0, File(""));
                                          model.notifyListeners();
                                        },
                                        icon: SvgPicture.asset(
                                            ImageUtils.cancelIcon),
                                        //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: ColorUtils.white,
                                        highlightColor:
                                        ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),

                      ///-------------Create Event Button-------------------////
                      SizedBox(height: 9.h),

                      //Next Button
                      SizedBox(
                        width: double.infinity,
                        //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                        child: ElevatedButton(
                          onPressed: () async {

                            model.createBarPostScreen();
                            // NewBarModel barUser =
                            // (await locator<PrefrencesViewModel>().getBarUser())!;
                            //navigateToMediaScreen();
                          },
                          child: const Text("Post"),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
