import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:stacked/stacked.dart';

class InvitePeople extends StatefulWidget {
  const InvitePeople({Key? key}) : super(key: key);

  @override
  _InvitePeopleState createState() => _InvitePeopleState();
}

class _InvitePeopleState extends State<InvitePeople> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model){
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            model.myContactEmojiSelected = false;
            model.myContactEmojiShowing = false;
            model.notifyListeners();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                "My Contacts",
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 3.t,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            //width: 200.0,
                            // margin: EdgeInsets.only(
                            //     left: SizeConfig.widthMultiplier * 4.5,
                            //     right: SizeConfig.widthMultiplier * 5,
                            //     top: SizeConfig.heightMultiplier * 3),
                            decoration: BoxDecoration(
                              color: ColorUtils.textFieldBg,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 3,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                      ImageUtils.searchIcon,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.widthMultiplier * 3,
                                          right: SizeConfig.widthMultiplier * 3),
                                      child: TextField(
                                        onTap: () {},
                                        enabled: true,
                                        //readOnly: true,
                                        //focusNode: model.searchFocus,
                                        controller: model.myContactsSearchController,
                                        decoration: InputDecoration(
                                          hintText: "People, groups & messages",
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
                                              SizeConfig.heightMultiplier *
                                                  2),
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
                    Center(
                      heightFactor: 2.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageUtils.contact),
                          SizedBox(height: 3.h,),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Text("Find your friends by syncing your address book",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.85.t,
                              color: ColorUtils.text_dark,
                            ),
                            ),
                          ),
                          SizedBox(height: 4.h,),
                          GestureDetector(
                            onTap: (){
                              add(context);
                            },
                            child: Container(
                              width: 25.w,
                              height: 5.5.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                border: Border.all(color: ColorUtils.text_red),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(ImageUtils.addIcon,
                                  ),
                                  SizedBox(width: 2.w,),
                                  Text("Add",
                                    style: TextStyle(
                                      color: ColorUtils.text_red,
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.8.t,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
  void add(context){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SvgPicture.asset(ImageUtils.mobileIcon,

                          ),
                          SizedBox(width: 4.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Find Contacts Easily",
                                style: TextStyle(
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 2.2.t,
                                  color: ColorUtils.text_dark,
                                ),
                              ),
                              SizedBox(height: 0.5.h,),
                              Text("Add contacts from your device",
                                style: TextStyle(
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.9.t,
                                  color: ColorUtils.text_dark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SvgPicture.asset(ImageUtils.forwardIcon)
                    ],
                  ),
                ),
                SizedBox(height: 4.h,),
                Container(

                  child: Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(ImageUtils.peopleIcon,

                          ),
                          SizedBox(width: 4.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Invite to Souftrag",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.2.t,
                                color: ColorUtils.text_dark,
                              ),
                              ),
                              SizedBox(height: 0.5.h,),
                              Text("Connect with friends and family",
                                style: TextStyle(
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.9.t,
                                  color: ColorUtils.text_dark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SvgPicture.asset(ImageUtils.forwardIcon)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
