import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class MessageDialog extends StatefulWidget {

  String title;
  String btnTxt;
  String icon;

   MessageDialog({Key? key, required this.title, required this.btnTxt, required this.icon}) : super(key: key);

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {

  final scrollController = ScrollController();
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,vertical: 1.7.h ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){
                                model.navigateBack();

                              },
                              // iconSize: 15.0,
                              //padding: EdgeInsets.all(20),
                              //constraints: BoxConstraints(),
                              icon: SvgPicture.asset(ImageUtils.cancelIcon),
                            ),
                          ],
                        ),
                        Container(
                          //padding: EdgeInsets.only(top: Dimensions.homeTopMargin),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(ImageUtils.johnImg,
                                width: 13.i,
                                height: 13.i,
                              ),
                              SizedBox(width: 2.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("John Milton",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 1.9.t,
                                      color: ColorUtils.text_dark,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h,),
                                  Container(
                                    height: 3.h,
                                    width: 25.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w),
                                    decoration: BoxDecoration(
                                        color: ColorUtils.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.roundCorner)),
                                        border: Border.all(color: ColorUtils.red_color)
                                    ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(ImageUtils.privateIcon, height: 1.6.h,),
                                        SizedBox(width: 1.5.w,),
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
                                                      fontSize: 1.6.t,
                                                      fontFamily: FontUtils
                                                          .modernistRegular,
                                                      color: ColorUtils.black,
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Sindh, Karachi",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                color: ColorUtils.text_dark,
                              ),
                            ),
                            SizedBox(width: 1.8.w),
                            SvgPicture.asset(ImageUtils.locationIcon, height: 8.i,),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        // Container(
                        //   //width: 50.w,
                        //   color: Colors.yellowAccent,
                        //
                        //   child: Row(
                        //     //mainAxisSize: MainAxisSize.min,
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     //crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //             margin: EdgeInsets.only(
                        //               //left: SizeConfig.widthMultiplier * 4.5,
                        //               //right: SizeConfig.widthMultiplier * 2,
                        //               //top: SizeConfig.heightMultiplier * 3,
                        //             ),
                        //             decoration: BoxDecoration(
                        //                 //color: Colors.blue,
                        //                 borderRadius: BorderRadius.all(
                        //                   Radius.circular(15.0),
                        //                 ),
                        //                 border: Border.all(color: ColorUtils.text_red)
                        //             ),
                        //             child: Container(
                        //               //color: Colors.amber,
                        //
                        //               child: Row(
                        //                 crossAxisAlignment: CrossAxisAlignment.end,
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   ExpandTapWidget(
                        //                     onTap: () {
                        //                       model.messageScreenEmojiShowing = !model.messageScreenEmojiShowing;
                        //                       model.messageScreenEmojiSelected = !model.messageScreenEmojiSelected;
                        //                       SchedulerBinding.instance!.addPostFrameCallback((_) {
                        //                         scrollController.jumpTo(scrollController.position.maxScrollExtent);
                        //                       });
                        //                       setState(() {
                        //                       });
                        //                     },
                        //                     tapPadding: EdgeInsets.all(25.0),
                        //                     child: SvgPicture.asset(ImageUtils.smileyIcon),
                        //                   ),
                        //                   // GestureDetector(
                        //                   //   onTap: (){
                        //                   //     emojiShowing = !emojiShowing;
                        //                   //     emojiSelected = !emojiSelected;
                        //                   //     SchedulerBinding.instance!.addPostFrameCallback((_) {
                        //                   //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
                        //                   //     });
                        //                   //     setState(() {
                        //                   //     });
                        //                   //   },
                        //                   //   child: Container(
                        //                   //     child: SvgPicture.asset(ImageUtils.smileyIcon),
                        //                   //   ),
                        //                   // ),
                        //                   SizedBox(width: 1.w,),
                        //                   Container(
                        //                     width: 50.w,
                        //
                        //                     child:
                        //                     TextField(
                        //                       onTap: () {},
                        //                       enabled: true,
                        //                       //readOnly: true,
                        //                       //focusNode: model.searchFocus,
                        //                       controller: model.messageScreenChatController,
                        //                       decoration: InputDecoration(
                        //                         hintText: "Type your message...",
                        //                         hintStyle: TextStyle(
                        //                           //fontFamily: FontUtils.proximaNovaRegular,
                        //                           //color: ColorUtils.silverColor,
                        //                           fontSize: SizeConfig.textMultiplier * 1.9,
                        //                         ),
                        //                         border: InputBorder.none,
                        //                         isDense: true,
                        //                         contentPadding: EdgeInsets.symmetric(
                        //                             vertical: SizeConfig.heightMultiplier * 2),
                        //                       ),
                        //                       keyboardType: TextInputType.multiline,
                        //                       maxLines: null,
                        //                     ),
                        //                   ),
                        //                   Container(
                        //                     decoration: BoxDecoration(
                        //                       //color: ColorUtils.text_red,
                        //                       borderRadius: BorderRadius.all(Radius.circular(15)),
                        //                     ),
                        //                     child: Row(
                        //                       children: [
                        //                         ExpandTapWidget(
                        //                           onTap: () {
                        //                             model.getImage();
                        //                             setState(() {
                        //                             });
                        //                           },
                        //                           tapPadding: EdgeInsets.all(50.0),
                        //                           child: SvgPicture.asset(ImageUtils.plusIcon),
                        //                         ),
                        //                         // GestureDetector(
                        //                         //   onTap: (){
                        //                         //     model.getImage();
                        //                         //   },
                        //                         //     child: SvgPicture.asset(ImageUtils.plusIcon),
                        //                         // ),
                        //                         SizedBox(width: 3.w,),
                        //                         ExpandTapWidget(
                        //                             onTap: () async{
                        //                               // final cameras = await availableCameras();
                        //                               // final firstCamera = cameras.first;
                        //                               //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                        //                               model.openCamera();
                        //                             },
                        //                             tapPadding: EdgeInsets.all(25.0),
                        //                             child: SvgPicture.asset(ImageUtils.photoCamera, color: ColorUtils.red_color,)
                        //                         ),
                        //                         // GestureDetector(
                        //                         //   onTap: (){
                        //                         //   },
                        //                         //   child: SvgPicture.asset(ImageUtils.photoCamera)
                        //                         // ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   // Text(searchHere,
                        //                   //   style: TextStyle(
                        //                   //     fontFamily: FontUtils.gibsonRegular,
                        //                   //     fontWeight: FontWeight.w400,
                        //                   //     fontSize: SizeConfig.textMultiplier * 1.8,
                        //                   //     color: ColorUtils.searchFieldText,
                        //                   //   ),
                        //                   // ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //           // Container(
                        //           //   decoration: BoxDecoration(
                        //           //     shape: BoxShape.circle,
                        //           //     color: ColorUtils.text_red,
                        //           //   ),
                        //           //   child: Padding(
                        //           //     padding: const EdgeInsets.all(15.0),
                        //           //     child: SvgPicture.asset(ImageUtils.voiceRecorder,
                        //           //       color: Colors.white,
                        //           //     ),
                        //           //   ),
                        //           // ),
                        //         ],
                        //       ),
                        //       SizedBox(height: 2.h,),
                        //       if(model.messageScreenEmojiSelected == true)
                        //         Container(
                        //           height: 30.h,
                        //           child: Offstage(
                        //             offstage: !model.messageScreenEmojiShowing,
                        //             child: EmojiPicker(
                        //                 onEmojiSelected: (Category category, Emoji emoji) {
                        //                   model.messageEmojiSelected(emoji);
                        //                 },
                        //                 onBackspacePressed: model.messageScreenBackspacePressed(),
                        //                 config: Config(
                        //                     columns: 7,
                        //                     // Issue: https://github.com/flutter/flutter/issues/28894
                        //                     emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        //                     verticalSpacing: 0,
                        //                     horizontalSpacing: 0,
                        //                     initCategory: Category.RECENT,
                        //                     bgColor: const Color(0xFFF2F2F2),
                        //                     indicatorColor: Colors.blue,
                        //                     iconColor: Colors.grey,
                        //                     iconColorSelected: Colors.blue,
                        //                     progressIndicatorColor: Colors.blue,
                        //                     backspaceColor: Colors.blue,
                        //                     showRecentsTab: true,
                        //                     recentsLimit: 28,
                        //                     noRecentsText: 'No Recents',
                        //                     noRecentsStyle: const TextStyle(
                        //                         fontSize: 20, color: Colors.black26),
                        //                     tabIndicatorAnimDuration: kTabScrollDuration,
                        //                     categoryIcons: const CategoryIcons(),
                        //                     buttonMode: ButtonMode.MATERIAL)),
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          // margin: EdgeInsets.only(bottom:2.h),
                          padding: EdgeInsets.symmetric(

                              vertical: Dimensions.verticalPadding),
                          child: Row(


                            children: [
                              Expanded(
                                child: Container(
                                  //width: 200.0,
                                  margin: EdgeInsets.only(
                                    //left: SizeConfig.widthMultiplier * 4.5,
                                    //right: SizeConfig.widthMultiplier * 2,
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
                                    // margin:
                                    // EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.w),
                                          child: ExpandTapWidget(
                                            onTap: () {
                                              model.groupScreenEmojiShowing = !model.groupScreenEmojiShowing;
                                              model.groupScreenEmojiSelected = !model.groupScreenEmojiSelected;
                                              model.notifyListeners();
                                            },
                                            tapPadding: EdgeInsets.all(25.0),
                                            child: SvgPicture.asset(ImageUtils.smileyIcon),
                                          ),
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
                                              controller: model.groupScreenChatController,
                                              decoration: InputDecoration(
                                                counterText: '',
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
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              maxLength: 200,


                                            ),
                                          ),
                                        ),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.w),
                                              decoration: BoxDecoration(
                                                //color: ColorUtils.text_red,
                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
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
                                                  SizedBox(width: 3.w,),
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
                                          ],
                                        )
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
                              // Container(
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     color: ColorUtils.text_red,
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(15.0),
                              //     child: SvgPicture.asset(ImageUtils.voiceRecorder,
                              //       //color: ColorUtils.blueColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        if(model.groupScreenEmojiSelected == true)
                          Container(
                            height: 30.h,
                            child: Offstage(
                              offstage: !model.groupScreenEmojiShowing,
                              child: EmojiPicker(onEmojiSelected: (Category category, Emoji emoji) {
                                // _onEmojiSelected(emoji);
                                model.groupScreenOnEmojiSelected(emoji);
                              },
                                  onBackspacePressed: model.groupScreenOnBackspacePressed(),
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

                        // Container(
                        //   //width: 200.0,
                        //   padding: EdgeInsets.symmetric(horizontal: 2.w),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(15.0),
                        //       ),
                        //       border: Border.all(color: ColorUtils.red_color)
                        //   ),
                        //   child: TextField(
                        //     onTap: () {},
                        //     enabled: true,
                        //     //readOnly: true,
                        //     //focusNode: model.searchFocus,
                        //     //controller: model.groupScreenChatController,
                        //     decoration: InputDecoration(
                        //       hintText: "Write your comment",
                        //       hintStyle: TextStyle(
                        //         //fontFamily: FontUtils.proximaNovaRegular,
                        //         color: ColorUtils.icon_color,
                        //         fontSize: SizeConfig.textMultiplier * 1.8,
                        //       ),
                        //       border: InputBorder.none,
                        //       isDense: true,
                        //       contentPadding: EdgeInsets.symmetric(
                        //           vertical: SizeConfig.heightMultiplier * 1.8),
                        //     ),
                        //     maxLines: 6,
                        //     maxLength: 150,
                        //
                        //   ),
                        //
                        // ),
                        SizedBox(height: 3.h,),
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.navigateBack();
                            },
                            child: const Text("Post"),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red,
                              onPrimary: ColorUtils.white,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  Dimensions.containerVerticalPadding),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.roundCorner)),
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
