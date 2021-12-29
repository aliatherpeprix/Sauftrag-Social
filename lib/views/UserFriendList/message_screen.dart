import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/UserFriendList/chat_input.dart';
import 'package:sauftrag/views/UserFriendList/chat_list_widget.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:stacked/stacked.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
            model.messageScreenEmojiSelected = false;
            model.messageScreenEmojiSelected = false;
            setState(() {

            });
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child:  Container(
                        margin: EdgeInsets.only(left:5.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.3.w,
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
                                        padding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 1.7.w),
                                        child:  ExpandTapWidget(
                                          onTap: () {
                                            model.getImage();
                                            setState(() {
                                            });
                                          },
                                          tapPadding: EdgeInsets.all(4.i),
                                          child: SvgPicture.asset(ImageUtils.plusIcon),
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: SizeConfig.widthMultiplier * 3,
                                              right: SizeConfig.widthMultiplier * 3),
                                          child: SingleChildScrollView(
                                            child: Container(
                                              constraints: BoxConstraints(maxHeight: 100),
                                              child: TextField(
                                                onTap: () {},
                                               // enabled: true,
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
                                                 // isDense: true,
                                                  contentPadding: EdgeInsets.symmetric(
                                                      vertical: SizeConfig.heightMultiplier * 2),
                                                ),
                                                keyboardType: TextInputType.multiline,
                                                maxLines: null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.w),
                                        decoration: BoxDecoration(
                                          //color: ColorUtils.text_red,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // ExpandTapWidget(
                                            //   onTap: () {
                                            //     model.getImage();
                                            //     setState(() {
                                            //     });
                                            //   },
                                            //   tapPadding: EdgeInsets.all(4.i),
                                            //   child: SvgPicture.asset(ImageUtils.plusIcon),
                                            // ),
                                            // GestureDetector(
                                            //   onTap: (){
                                            //     model.getImage();
                                            //   },
                                            //     child: SvgPicture.asset(ImageUtils.plusIcon),
                                            // ),
                                            // SizedBox(width: 3.w,),
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
                                            SizedBox(width: 3.w,),
                                            ExpandTapWidget(
                                              onTap: () {
                                                model.getImage();
                                                setState(() {
                                                });
                                              },
                                              tapPadding: EdgeInsets.all(0.i),
                                              child: SvgPicture.asset(ImageUtils.voiceRecorder,color: ColorUtils.red_color,height: 5.5.i,),
                                            ),

                                            SizedBox(width: 1.5.w,),
                                            // GestureDetector(
                                            //   onTap: (){
                                            //   },
                                            //   child: SvgPicture.asset(ImageUtils.photoCamera)
                                            // ),
                                          ],
                                        ),
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
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.2.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorUtils.text_red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(ImageUtils.sendIcon1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              body: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalPadding,
                   ),
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.topMargin),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            SizedBox(width: 2.5.w,),
                            GestureDetector(
                              onTap: (){
                                model.navigateToFollowerList();
                              },
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      CircleAvatar(
                                        radius: 26.0,
                                        backgroundImage:
                                        AssetImage(ImageUtils.messagePerson1),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 3.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Athalia Putri",
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 1.9.t,
                                            color: ColorUtils.text_dark
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h,),
                                      Text("Active",
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 1.5.t,
                                            color: ColorUtils.activeColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(ImageUtils.chatMenuIcon),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 2.h, bottom: 11.h
                          ),
                          child: Column(
                            children: [
                              //SizedBox(height: 5.h,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width/1.7,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.messageChat,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
                                        child: Image.asset(ImageUtils.drinkImage,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w,top: 1.5.h),
                                        child: Text("Lorem ipsum dolor sit amet, consec tetur adipiscing elit.",
                                          style: TextStyle(
                                              //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: ColorUtils.text_dark
                                          ),
                                        ),
                                      ),
                                      //SizedBox(height: 1.h,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("02:45 pm",
                                            style: TextStyle(
                                                //fontFamily: FontUtils.avertaDemoRegular,
                                                fontSize: 1.5.t,
                                                color: ColorUtils.icon_color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              //SizedBox(height: 5.h,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.text_red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      //bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w,top: 2.h),
                                        child: Text("Ok, I’m on my way",
                                          style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                      //SizedBox(height: 1.h,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("02:45 pm•Read",
                                            style: TextStyle(
                                              //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.5.t,
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 2.h,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.messageChat,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      //bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w,top: 2.h),
                                        child: Text("Ok, I’m on my way",
                                          style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: ColorUtils.text_dark
                                          ),
                                        ),
                                      ),
                                      //SizedBox(height: 1.h,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("02:45 pm•Read",
                                            style: TextStyle(
                                              //fontFamily: FontUtils.avertaDemoRegular,
                                                fontSize: 1.5.t,
                                                color: ColorUtils.icon_color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 2.h,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.text_red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      //bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w,top: 2.h),
                                        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
                                          style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("02:45 pm•Read",
                                          style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.5.t,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.text_red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      //bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w,top: 2.h),
                                        child: Text("Hii....",
                                          style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("03:00 pm•Read",
                                          style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.5.t,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   //crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     Expanded(
                              //       child: Container(
                              //         //width: 200.0,
                              //         margin: EdgeInsets.only(
                              //           //left: SizeConfig.widthMultiplier * 4.5,
                              //           right: SizeConfig.widthMultiplier * 2,
                              //           //top: SizeConfig.heightMultiplier * 3,
                              //         ),
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.all(
                              //               Radius.circular(15.0),
                              //             ),
                              //             border: Border.all(color: ColorUtils.text_red)
                              //         ),
                              //         child: Container(
                              //           //color: Colors.amber,
                              //           margin:
                              //           EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                              //           child: Row(
                              //             children: [
                              //               ExpandTapWidget(
                              //                 onTap: () {
                              //                   model.messageScreenEmojiShowing = !model.messageScreenEmojiShowing;
                              //                   model.messageScreenEmojiSelected = !model.messageScreenEmojiSelected;
                              //                   SchedulerBinding.instance!.addPostFrameCallback((_) {
                              //                     scrollController.jumpTo(scrollController.position.maxScrollExtent);
                              //                   });
                              //                   setState(() {
                              //                   });
                              //                 },
                              //                 tapPadding: EdgeInsets.all(25.0),
                              //                 child: SvgPicture.asset(ImageUtils.smileyIcon),
                              //               ),
                              //               // GestureDetector(
                              //               //   onTap: (){
                              //               //     emojiShowing = !emojiShowing;
                              //               //     emojiSelected = !emojiSelected;
                              //               //     SchedulerBinding.instance!.addPostFrameCallback((_) {
                              //               //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
                              //               //     });
                              //               //     setState(() {
                              //               //     });
                              //               //   },
                              //               //   child: Container(
                              //               //     child: SvgPicture.asset(ImageUtils.smileyIcon),
                              //               //   ),
                              //               // ),
                              //               SizedBox(width: 1.w,),
                              //               Expanded(
                              //                 child: Container(
                              //                   margin: EdgeInsets.only(
                              //                       left: SizeConfig.widthMultiplier * 3,
                              //                       right: SizeConfig.widthMultiplier * 3),
                              //                   child: TextField(
                              //                     onTap: () {},
                              //                     enabled: true,
                              //                     //readOnly: true,
                              //                     //focusNode: model.searchFocus,
                              //                     controller: model.messageScreenChatController,
                              //                     decoration: InputDecoration(
                              //                       hintText: "Type your message...",
                              //                       hintStyle: TextStyle(
                              //                         //fontFamily: FontUtils.proximaNovaRegular,
                              //                         //color: ColorUtils.silverColor,
                              //                         fontSize: SizeConfig.textMultiplier * 1.9,
                              //                       ),
                              //                       border: InputBorder.none,
                              //                       isDense: true,
                              //                       contentPadding: EdgeInsets.symmetric(
                              //                           vertical: SizeConfig.heightMultiplier * 2),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Container(
                              //                 decoration: BoxDecoration(
                              //                   //color: ColorUtils.text_red,
                              //                   borderRadius: BorderRadius.all(Radius.circular(15)),
                              //                 ),
                              //                 child: Row(
                              //                   children: [
                              //                     ExpandTapWidget(
                              //                       onTap: () {
                              //                         model.getImage();
                              //                         setState(() {
                              //                         });
                              //                       },
                              //                       tapPadding: EdgeInsets.all(50.0),
                              //                       child: SvgPicture.asset(ImageUtils.plusIcon),
                              //                     ),
                              //                     // GestureDetector(
                              //                     //   onTap: (){
                              //                     //     model.getImage();
                              //                     //   },
                              //                     //     child: SvgPicture.asset(ImageUtils.plusIcon),
                              //                     // ),
                              //                     SizedBox(width: 4.w,),
                              //                     ExpandTapWidget(
                              //                         onTap: () async{
                              //                           // final cameras = await availableCameras();
                              //                           // final firstCamera = cameras.first;
                              //                           //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                              //                           model.openCamera();
                              //                         },
                              //                         tapPadding: EdgeInsets.all(25.0),
                              //                         child: SvgPicture.asset(ImageUtils.photoCamera)
                              //                     ),
                              //                     // GestureDetector(
                              //                     //   onTap: (){
                              //                     //   },
                              //                     //   child: SvgPicture.asset(ImageUtils.photoCamera)
                              //                     // ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               // Text(searchHere,
                              //               //   style: TextStyle(
                              //               //     fontFamily: FontUtils.gibsonRegular,
                              //               //     fontWeight: FontWeight.w400,
                              //               //     fontSize: SizeConfig.textMultiplier * 1.8,
                              //               //     color: ColorUtils.searchFieldText,
                              //               //   ),
                              //               // ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         color: ColorUtils.text_red,
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(15.0),
                              //         child: SvgPicture.asset(ImageUtils.voiceRecorder,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 2.h,),
                              // if(model.messageScreenEmojiSelected == true)
                              //   Container(
                              //     height: 30.h,
                              //     child: Offstage(
                              //       offstage: !model.messageScreenEmojiShowing,
                              //       child: EmojiPicker(
                              //           onEmojiSelected: (Category category, Emoji emoji) {
                              //             model.messageEmojiSelected(emoji);
                              //           },
                              //           onBackspacePressed: model.messageScreenBackspacePressed(),
                              //           config: Config(
                              //               columns: 7,
                              //               // Issue: https://github.com/flutter/flutter/issues/28894
                              //               emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                              //               verticalSpacing: 0,
                              //               horizontalSpacing: 0,
                              //               initCategory: Category.RECENT,
                              //               bgColor: const Color(0xFFF2F2F2),
                              //               indicatorColor: Colors.blue,
                              //               iconColor: Colors.grey,
                              //               iconColorSelected: Colors.blue,
                              //               progressIndicatorColor: Colors.blue,
                              //               backspaceColor: Colors.blue,
                              //               showRecentsTab: true,
                              //               recentsLimit: 28,
                              //               noRecentsText: 'No Recents',
                              //               noRecentsStyle: const TextStyle(
                              //                   fontSize: 20, color: Colors.black26),
                              //               tabIndicatorAnimDuration: kTabScrollDuration,
                              //               categoryIcons: const CategoryIcons(),
                              //               buttonMode: ButtonMode.MATERIAL)),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
