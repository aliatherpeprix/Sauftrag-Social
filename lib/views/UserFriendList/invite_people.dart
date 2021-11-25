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
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.horizontalPadding,
                          vertical: Dimensions.verticalPadding),
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
                                  )),
                              SizedBox(width: 2.w),
                              Text(
                                "My Contacts",
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 2.5.t,
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
                    Column(
                      children: [
                        SvgPicture.asset(ImageUtils.contact),
                        SizedBox(height: 4.h,),
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
                    Container(
                      margin: EdgeInsets.only(bottom:2.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.horizontalPadding,
                          vertical: Dimensions.verticalPadding),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              //width: 200.0,
                              margin: EdgeInsets.only(
                                //left: SizeConfig.widthMultiplier * 4.5,
                                right: SizeConfig.widthMultiplier * 2,
                                //top: SizeConfig.heightMultiplier * 3,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  border: Border.all(color: ColorUtils.text_red)
                              ),
                              child: Container(
                                //color: Colors.amber,
                                margin:
                                EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                                child: Row(
                                  children: [
                                    ExpandTapWidget(
                                      onTap: () {
                                        model.myContactEmojiShowing = !model.myContactEmojiShowing;
                                        model.myContactEmojiSelected = !model.myContactEmojiSelected;
                                        model.notifyListeners();
                                      },
                                      tapPadding: EdgeInsets.all(25.0),
                                      child: SvgPicture.asset(ImageUtils.smileyIcon),
                                    ),
                                    // GestureDetector(
                                    //   onTap: (){
                                    //     emojiShowing = !emojiShowing;
                                    //     emojiSelected = !emojiSelected;
                                    //     SchedulerBinding.instance!.addPostFrameCallback((_) {
                                    //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
                                    //     });
                                    //     setState(() {
                                    //     });
                                    //   },
                                    //   child: Container(
                                    //     child: SvgPicture.asset(ImageUtils.smileyIcon),
                                    //   ),
                                    // ),
                                    SizedBox(width: 1.w,),
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
                                          controller: model.myContactsChatController,
                                          decoration: InputDecoration(
                                            hintText: "Type your message...",
                                            hintStyle: TextStyle(
                                              //fontFamily: FontUtils.proximaNovaRegular,
                                              //color: ColorUtils.silverColor,
                                              fontSize: SizeConfig.textMultiplier * 1.9,
                                            ),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: SizeConfig.heightMultiplier * 2),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        //color: ColorUtils.text_red,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: Row(
                                        children: [
                                          ExpandTapWidget(
                                            onTap: () {
                                              model.getImage();
                                              setState(() {
                                              });
                                            },
                                            tapPadding: EdgeInsets.all(4.i),
                                            child: SvgPicture.asset(ImageUtils.plusIcon),
                                          ),
                                          // GestureDetector(
                                          //   onTap: (){
                                          //     model.getImage();
                                          //   },
                                          //     child: SvgPicture.asset(ImageUtils.plusIcon),
                                          // ),
                                          SizedBox(width: 4.w,),
                                          ExpandTapWidget(
                                            onTap: () async{
                                              // final cameras = await availableCameras();
                                              // final firstCamera = cameras.first;
                                              //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                                              model.openCamera();
                                            },
                                            tapPadding: EdgeInsets.all(25.0),
                                            child: SvgPicture.asset(ImageUtils.photoCamera,
                                              color: ColorUtils.text_red,
                                            ),
                                          ),
                                          // GestureDetector(
                                          //   onTap: (){
                                          //   },
                                          //   child: SvgPicture.asset(ImageUtils.photoCamera)
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // Text(searchHere,
                                    //   style: TextStyle(
                                    //     fontFamily: FontUtils.gibsonRegular,
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: SizeConfig.textMultiplier * 1.8,
                                    //     color: ColorUtils.searchFieldText,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.text_red,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(ImageUtils.voiceRecorder,
                                //color: ColorUtils.blueColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if(model.myContactEmojiSelected == true)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.horizontalPadding,
                            vertical: Dimensions.verticalPadding),
                        height: 30.h,
                        child: Offstage(
                          offstage: !model.myContactEmojiShowing,
                          child: EmojiPicker(onEmojiSelected: (Category category, Emoji emoji) {
                            // _onEmojiSelected(emoji);
                            model.myContactOnEmojiSelected(emoji);
                          },
                              onBackspacePressed: model.myContactOnBackspacePressed(),
                              config: Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  progressIndicatorColor: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  noRecentsText: 'No Recents',
                                  noRecentsStyle: const TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL)),
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6.h, left: 4.w, right: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageUtils.mobileIcon),
                          SizedBox(width: 2.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Find Contacts Easily"),
                              Text("Add contacts from your device"),
                            ],
                          ),
                        ],
                      ),
                      SvgPicture.asset(ImageUtils.forwardIcon)
                    ],
                  ),
                ),
                SizedBox(height: 3.h,),
                Container(
                  margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w, bottom: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageUtils.mobileIcon),
                          SizedBox(width: 2.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Find Contacts Easily"),
                              Text("Add contacts from your device"),
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
