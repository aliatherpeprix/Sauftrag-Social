import 'dart:async';
import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:stacked/stacked.dart';
import 'package:audioplayers/audioplayers.dart'as ap;

import '../../../widgets/loader.dart';

class BarGroupScreen extends StatefulWidget {

  int? id;
  String? username;
  int? userLength;
  String? groupImg;
  List<UserModel>? groupUser;

  BarGroupScreen({Key? key, this.id, this.username,  this.userLength, this.groupUser, this.groupImg}) : super(key: key);

  @override
  _BarGroupScreenState createState() => _BarGroupScreenState();
}

class _BarGroupScreenState extends State<BarGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) async {
        model.initUserGrpPubNub();
        // Subscribe to a channel
        model.subscription = model.pubnub!.subscribe(channels: {widget.username!});

        model.channel = model.pubnub!.channel(widget.username!);
        var chat = await model.channel!.messages();
        var data = await chat.count();
        await chat.fetch().whenComplete(() {
          model.chats.clear();
          print(chat.messages.length);
          for (var data in chat.messages) {
            model.chats.add(data.content);
          }
          model.notifyListeners();
        });

        model.subscription!.messages.listen((message) async {
          model.chats.add(message.content);
          model.notifyListeners();
        });

        //print("Testing");
        // Print every message
        // model.subscription!.messages.listen((message) async {
        //   //print(message.content);
        //   //model.message = message.content;
        //   model.chats.add(message.content);
        //   // message.uuid;
        //   // print(message.flags);
        //   model.notifyListeners();
        //   // model.chats = (message.content['content'] as List)
        //   //     .map((e) => Envelope.fromJson(e))
        //   //     .toList();
        //   // model.pubnub
        //   //     .publish(model.channel, model.groupScreenChatController.text);
        //   //   for (var i in model.chats) {
        //   //     await model.pubnub.publish(model.channel, i[Envelope]);
        //   //   }
        // });
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            model.groupScreenEmojiSelected = false;
            model.groupScreenEmojiShowing = false;
            model.notifyListeners();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton:
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.3.w,
                            vertical: Dimensions.verticalPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                //width: 200.0,
                                margin: EdgeInsets.only(

                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    border:
                                    Border.all(color: ColorUtils.text_red)),
                                child: Container(
                                  //color: Colors.amber,
                                  // margin:
                                  // EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.2.h, horizontal: 1.7.w),
                                        child: ExpandTapWidget(
                                            onTap: () {
                                              model.sendImageMessageGrpBar(widget.id!, widget.username!);
                                              // model.getImagE();
                                              // setState(() {});
                                            },
                                            tapPadding: EdgeInsets.all(4.i),
                                            child: model.recordPressed == false ?
                                            SvgPicture.asset(
                                                ImageUtils
                                                    .plusIcon)
                                                : Text("")
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: SizeConfig.widthMultiplier *
                                                  3,
                                              right:
                                              SizeConfig.widthMultiplier *
                                                  3),
                                          child: SingleChildScrollView(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxHeight: 100),
                                              child: model.recordPressed == true ?
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 15.0),
                                                child: Text("Recording....." ,
                                                  style: TextStyle(
                                                      fontSize: 2.2.t,
                                                      fontWeight: FontWeight.bold ,
                                                      color: ColorUtils.red_color),),
                                              ) :
                                              TextField(
                                                onTap: () {},
                                                onChanged: (value){
                                                  model.notifyListeners();
                                                },
                                                // enabled: true,
                                                //readOnly: true,
                                                //focusNode: model.searchFocus,
                                                controller: model
                                                    .groupScreenChatController,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  hintText:
                                                  "Type your message...",
                                                  hintStyle: TextStyle(
                                                    //fontFamily: FontUtils.proximaNovaRegular,
                                                    //color: ColorUtils.silverColor,
                                                    fontSize: SizeConfig
                                                        .textMultiplier *
                                                        1.9,
                                                  ),
                                                  border: InputBorder.none,
                                                  // isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .heightMultiplier *
                                                          2),
                                                ),
                                                keyboardType:
                                                TextInputType.multiline,
                                                maxLines: null,
                                              ) ,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.5.h, horizontal: 1.5.w),
                                        decoration: BoxDecoration(
                                          //color: ColorUtils.text_red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
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
                                              onTap: () async {
                                                // final cameras = await availableCameras();
                                                // final firstCamera = cameras.first;
                                                //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                                                model.openCameraGrpBar(widget.id!, widget.username!);
                                              },
                                              tapPadding: EdgeInsets.all(25.0),
                                              child: model.recordPressed == false ? SvgPicture.asset(
                                                ImageUtils.photoCamera,
                                                color: ColorUtils.text_red,
                                              ) : Text(""),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            ExpandTapWidget(
                                              onTap: () {
                                                if(model.recordPressed == false){
                                                  model.recordPressed = true;
                                                  model.notifyListeners();
                                                  print("record started");
                                                  model.startGroupVoiceBar();
                                                }
                                                else if(model.recordPressed == true){
                                                  model.recordPressed = false;
                                                  model.notifyListeners();
                                                  print("recording stopped");
                                                  model.stopGroupVoiceBar(widget.id!, widget.username!);
                                                }
                                                //model.isRecording ? model.stop() : model.start();
                                                //model.getImage();
                                                setState(() {});
                                              },
                                              tapPadding:
                                              EdgeInsets.all(
                                                  0.i),
                                              child:
                                              model.recordPressed == false ?
                                              SvgPicture.asset(
                                                ImageUtils
                                                    .voiceRecorder,
                                                color: ColorUtils
                                                    .red_color,
                                                height: 5.5.i,
                                              ) :
                                              Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 8.w),
                                                // height: 2.h,
                                                // width: 5.w,
                                                //color: ColorUtils.transparent,
                                                child: SvgPicture.asset(
                                                  ImageUtils
                                                      .voiceRecord,
                                                  //color: ColorUtils.white,
                                                  height: 7.5.i,
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 1.5.w,
                                            ),
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
                    model.groupScreenChatController.text.isEmpty  && model.recordPressed == false ?

                    Container(
                      margin: EdgeInsets.only(bottom: 2.2.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorUtils.icon_color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          ImageUtils.sendIcon1,
                          color: Colors.white,
                        ),
                      ),
                    ):
                    InkWell(
                      onTap: () async {
                        NewBarModel barUser =
                        (await locator<PrefrencesViewModel>()
                            .getBarUser())!;
                        UserModel user =
                        (await locator<PrefrencesViewModel>().getUser())!;
                        // model.chat();

                        model.pubnub!.publish(widget.username!, {
                          "content": model.groupScreenChatController.text,
                          "userID": barUser.id!.toString(),
                          "time":DateTime.now().toString(),
                          "name" : barUser.username,
                        });
                        model.groupScreenChatController.clear();
                        Future.delayed(Duration(seconds: 2), () {
                          model.scrollDown();
                        });
                        model.notifyListeners();
                      },
                      child:
                      model.recordPressed == false ?
                        Container(
                        margin: EdgeInsets.only(bottom: 2.2.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.text_red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            ImageUtils.sendIcon1,
                            color: Colors.white,
                          ),
                        ),
                      ) : Text(""),
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                                        model.navigateToFriendListScreen1();
                                      },
                                      iconSize: 18.0,
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: ColorUtils.black,
                                        size: 4.5.i,
                                      )),
                                  SizedBox(
                                    width: 2.5.w,
                                  ),
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            height: 6.7.h,
                                            width: 14.w,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(80),
                                              child: widget.groupImg == null ?
                                              SvgPicture.asset(ImageUtils.profile) :
                                              Image.network(widget.groupImg!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                widget.username!,
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils.modernistBold,
                                                    fontSize: 1.9.t,
                                                    color:
                                                    ColorUtils.text_dark),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              SvgPicture.asset(
                                                  ImageUtils.groupLock, height: 2.h,),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.8.h,
                                          ),
                                          Text(
                                           widget.userLength!.toString() +  " Members" ,
                                            style: TextStyle(
                                                fontFamily:
                                                FontUtils.modernistBold,
                                                fontSize: 1.5.t,
                                                color: ColorUtils.activeColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //SvgPicture.asset(ImageUtils.chatMenuIcon),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
                      height: 70.h,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          controller: model.chatScroll,
                          itemBuilder: (context, index) {

                            if(model.chats[index]["file"] != null)
                            {
                              if(lookupMimeType(model.chats[index]["file"]["name"])!.contains("video"))
                              {
                                return ChatVideoWidget(index: index, id: widget.id.toString(), name: widget.username);
                              }
                              else if(lookupMimeType(model.chats[index]["file"]["name"])!.contains("audio")) {
                                return ChatAudioWidget(index: index, id: widget.id.toString(), name: widget.username);
                              }
                              else {
                                return ChatImageWidget(index: index, id: widget.id.toString(), name:widget.username);
                              }
                            }
                            else
                            {
                              return ChatTextWidget(index : index);
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5.h,
                          ),
                          itemCount: model.chats.length),
                    ),
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     SvgPicture.asset(ImageUtils.quietSmiley),
                    //     SizedBox(
                    //       height: 2.h,
                    //     ),
                    //     Text(
                    //       "Awfully quite in here",
                    //       style: TextStyle(
                    //         fontFamily: FontUtils.modernistRegular,
                    //         fontSize: 2.t,
                    //         color: ColorUtils.text_dark,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Container(
                    //  // margin: EdgeInsets.only(bottom:2.h),
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: Dimensions.horizontalPadding,
                    //       vertical: Dimensions.verticalPadding),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     //crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Expanded(
                    //         child: Container(
                    //           //width: 200.0,
                    //           margin: EdgeInsets.only(
                    //             //left: SizeConfig.widthMultiplier * 4.5,
                    //             right: SizeConfig.widthMultiplier * 2,
                    //             //top: SizeConfig.heightMultiplier * 3,
                    //           ),
                    //           decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: BorderRadius.all(
                    //                 Radius.circular(15.0),
                    //               ),
                    //               border: Border.all(color: ColorUtils.text_red)
                    //           ),
                    //           child: Container(
                    //             //color: Colors.amber,
                    //             margin:
                    //             EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                    //             child: Row(
                    //               children: [
                    //                 ExpandTapWidget(
                    //                   onTap: () {
                    //                     model.groupScreenEmojiShowing = !model.groupScreenEmojiShowing;
                    //                     model.groupScreenEmojiSelected = !model.groupScreenEmojiSelected;
                    //                     model.notifyListeners();
                    //                   },
                    //                   tapPadding: EdgeInsets.all(25.0),
                    //                   child: SvgPicture.asset(ImageUtils.smileyIcon),
                    //                 ),
                    //                 // GestureDetector(
                    //                 //   onTap: (){
                    //                 //     emojiShowing = !emojiShowing;
                    //                 //     emojiSelected = !emojiSelected;
                    //                 //     SchedulerBinding.instance!.addPostFrameCallback((_) {
                    //                 //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    //                 //     });
                    //                 //     setState(() {
                    //                 //     });
                    //                 //   },
                    //                 //   child: Container(
                    //                 //     child: SvgPicture.asset(ImageUtils.smileyIcon),
                    //                 //   ),
                    //                 // ),
                    //                 SizedBox(width: 1.w,),
                    //                 Expanded(
                    //                   child: Container(
                    //                     margin: EdgeInsets.only(
                    //                         left: SizeConfig.widthMultiplier * 3,
                    //                         right: SizeConfig.widthMultiplier * 3),
                    //                     child: TextField(
                    //                       onTap: () {},
                    //                       enabled: true,
                    //                       //readOnly: true,
                    //                       //focusNode: model.searchFocus,
                    //                       controller: model.groupScreenChatController,
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
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                     //color: ColorUtils.text_red,
                    //                     borderRadius: BorderRadius.all(Radius.circular(15)),
                    //                   ),
                    //                   child: Row(
                    //                     children: [
                    //                       ExpandTapWidget(
                    //                         onTap: () {
                    //                           model.getImage();
                    //                           setState(() {
                    //                           });
                    //                         },
                    //                         tapPadding: EdgeInsets.all(4.i),
                    //                         child: SvgPicture.asset(ImageUtils.plusIcon),
                    //                       ),
                    //                       // GestureDetector(
                    //                       //   onTap: (){
                    //                       //     model.getImage();
                    //                       //   },
                    //                       //     child: SvgPicture.asset(ImageUtils.plusIcon),
                    //                       // ),
                    //                       SizedBox(width: 4.w,),
                    //                       ExpandTapWidget(
                    //                         onTap: () async{
                    //                           // final cameras = await availableCameras();
                    //                           // final firstCamera = cameras.first;
                    //                           //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                    //                           model.openCamera();
                    //                         },
                    //                         tapPadding: EdgeInsets.all(25.0),
                    //                         child: SvgPicture.asset(ImageUtils.photoCamera,
                    //                           color: ColorUtils.text_red,
                    //                         ),
                    //                       ),
                    //                       // GestureDetector(
                    //                       //   onTap: (){
                    //                       //   },
                    //                       //   child: SvgPicture.asset(ImageUtils.photoCamera)
                    //                       // ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 // Text(searchHere,
                    //                 //   style: TextStyle(
                    //                 //     fontFamily: FontUtils.gibsonRegular,
                    //                 //     fontWeight: FontWeight.w400,
                    //                 //     fontSize: SizeConfig.textMultiplier * 1.8,
                    //                 //     color: ColorUtils.searchFieldText,
                    //                 //   ),
                    //                 // ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: ColorUtils.text_red,
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(15.0),
                    //           child: SvgPicture.asset(ImageUtils.voiceRecorder,
                    //             //color: ColorUtils.blueColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // if(model.groupScreenEmojiSelected == true)
                    //   Container(
                    //     height: 30.h,
                    //     child: Offstage(
                    //       offstage: !model.groupScreenEmojiShowing,
                    //       child: EmojiPicker(onEmojiSelected: (Category category, Emoji emoji) {
                    //             // _onEmojiSelected(emoji);
                    //             model.groupScreenOnEmojiSelected(emoji);
                    //           },
                    //           onBackspacePressed: model.groupScreenOnBackspacePressed(),
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
        );
      },
    );
  }
}

///----------------------Chat Image-------------------------------///

class ChatImageWidget extends StatefulWidget {
  int? index;
  String? id;
  String? name;
  ChatImageWidget({Key? key, this.index, this.id, this.name}) : super(key: key);

  @override
  _ChatImageWidgetState createState() => _ChatImageWidgetState();
}

class _ChatImageWidgetState extends State<ChatImageWidget> {

  Uri? uri;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: ()=> locator<MainViewModel>(),
      onModelReady: (model) {
        getFileUrl(model, widget.name!);
      },
      builder: (context, model,child){
        return Align(
          alignment: model.chats[widget.index!]["message"]["userID"] ==
              model.barModel!.id!.toString()
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            width:
            MediaQuery.of(context).size.width /
                1.7,
            decoration: BoxDecoration(
              color: ColorUtils.messageChat,
              borderRadius: model.chats[widget.index!]["message"]
              ["userID"] ==
                  model.barModel!.id!.toString()
                  ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft:
                Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: model.chats[widget.index!]["message"]
              ["userID"] ==
                  model.barModel!.id!.toString()
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 3.w,
                //       vertical: 1.5.h),
                //   child: Image.asset(
                //     ImageUtils.drinkImage,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.chats[widget.index!]["message"]["name"] != null ?
                      Text(model.chats[widget.index!]["message"]["name"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),) : Text(""),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 3.w,
                      right: 3.w,
                      top: 1.5.h),
                  child: Image.network(
                    uri.toString(),
                    // height: 30.h,
                    // width: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
                //SizedBox(height: 1.h,),

                Align(
                  alignment: model.chats[widget.index!]["message"]
                  ["userID"] ==
                      model.barModel!.id!
                          .toString()
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat("dd hh:mm").format(DateTime.parse(model.chats[widget.index!]["message"]["time"])),
                      style: TextStyle(
                        //fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 1.5.t,
                          color: ColorUtils
                              .icon_color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      disposeViewModel: false,
    );
  }
  void getFileUrl (MainViewModel model, String name)async{
    print(model.chats[widget.index!]);

    uri = await model.pubnub!.files.getFileUrl(
      name,
      model.chats[widget.index!]["file"]["id"],
      model.chats[widget.index!]["file"]["name"],
    );
    print(uri);
    setState(() {
    });
  }
}

///-------------------Chat Text ---------------------------///

class ChatTextWidget extends StatefulWidget {
  int? index;

  ChatTextWidget({Key? key, this.index}) : super(key: key);

  @override
  _ChatTextWidgetState createState() => _ChatTextWidgetState();
}

class _ChatTextWidgetState extends State<ChatTextWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: ()=> locator<MainViewModel>(),
      onModelReady: (model) {
        //getFileUrl(model);
      },
      builder: (context, model,child){
        return Align(
          alignment: model.chats[widget.index!]["userID"] ==
              model.barModel!.id!.toString()
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            width:
            MediaQuery.of(context).size.width /
                1.7,
            decoration: BoxDecoration(
              color: ColorUtils.messageChat,
              borderRadius: model.chats[widget.index!]
              ["userID"] ==
                  model.barModel!.id!.toString()
                  ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft:
                Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: model.chats[widget.index!]
              ["userID"] ==
                  model.barModel!.id!.toString()
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 3.w,
                //       vertical: 1.5.h),
                //   child: Image.asset(
                //     ImageUtils.drinkImage,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.chats[widget.index!]["name"] != null ?
                      Text(model.chats[widget.index!]["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                        ),) : Text(""),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 3.w,
                        right: 3.w,
                        top: 1.5.h),
                    child: Text(
                      model.chats[widget.index!]["content"].toString(),
                      style: TextStyle(
                        //fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 1.8.t,
                          color:
                          ColorUtils.text_dark),
                    )
                ),
                //SizedBox(height: 1.h,),

                Align(
                  alignment: model.chats[widget.index!]
                  ["userID"] ==
                      model.barModel!.id!
                          .toString()
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat("dd hh:mm").format(DateTime.parse(model.chats[widget.index!]["time"])),
                      //model.chats[widget.index!]["createdAt"].toString(),
                      style: TextStyle(
                        //fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 1.5.t,
                          color: ColorUtils
                              .icon_color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      disposeViewModel: false,
    );
  }
}

///------------------ Chat Video---------------------------------///

class ChatVideoWidget extends StatefulWidget {
  int? index;
  String? id;
  String? name;

  ChatVideoWidget({Key? key, this.index, this.id,  this.name}) : super(key: key);

  @override
  _ChatVideoWidgetState createState() => _ChatVideoWidgetState();
}

class _ChatVideoWidgetState extends State<ChatVideoWidget> {

  Uri? uri;

  BetterPlayerController? _betterPlayerController;
  BetterPlayerDataSource? _betterPlayerDataSource;


  @override
  void dispose() {
    _betterPlayerController!.dispose();
    super.dispose();
  }

  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: ()=> locator<MainViewModel>(),
      onModelReady: (model) {
        getFileUrl(model, widget.name);
      },
      builder: (context, model,child){
        return Align(
          alignment: model.chats[widget.index!]["message"]["userID"] ==
              model.barModel!.id!.toString()
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            width:
            MediaQuery.of(context).size.width /
                1.7,
            decoration: BoxDecoration(
              color: ColorUtils.messageChat,
              borderRadius: model.chats[widget.index!]["message"]
              ["userID"] ==
                  model.barModel!.id!.toString()
                  ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft:
                Radius.circular(15),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight:
                Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: model.chats[widget.index!]["message"]
              ["userID"] ==
                  model.barModel!.id!.toString()
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 3.w,
                //       vertical: 1.5.h),
                //   child: Image.asset(
                //     ImageUtils.drinkImage,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.chats[widget.index!]["message"]["name"] != null ?
                      Text(model.chats[widget.index!]["message"]["name"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),) : Text(""),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if(_betterPlayerController!=null)
                  Container(
                    height: 20.h,
                    width: 60.w,
                    child: AspectRatio(
                      aspectRatio: 28 / 40,
                      child: BetterPlayer(
                          controller: _betterPlayerController!),
                    ),
                  ),
                if(_betterPlayerController==null)
                  Container(
                    height: 20.h,
                    child: Loader(),
                  ),

                Align(
                  alignment: model.chats[widget.index!]["message"]
                  ["userID"] ==
                      model.barModel!.id!
                          .toString()
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat("dd hh:mm").format(DateTime.parse(model.chats[widget.index!]["message"]["time"])),
                      style: TextStyle(
                        //fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 1.5.t,
                          color: ColorUtils
                              .icon_color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      disposeViewModel: false,
    );
  }
  void getFileUrl (MainViewModel model, name)async{
    print(model.chats[widget.index!]);
    //var fileInfo = widget.ImageData;
    uri = await model.pubnub!.files.getFileUrl(

      name,
      model.chats[widget.index!]["file"]["id"],
      model.chats[widget.index!]["file"]["name"],

    );
    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ],
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      uri.toString(),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    await _betterPlayerController!.setupDataSource(_betterPlayerDataSource!);
    print(uri);
    setState(() {

    });

  }

}


///------------ Chat Audio ----------------------///
class ChatAudioWidget extends StatefulWidget {
  int? index;
  String? id;
  String? name;

  ChatAudioWidget({Key? key, this.index, this.id, this.name}) : super(key: key);

  @override
  _ChatAudioWidgetState createState() => _ChatAudioWidgetState();
}

class _ChatAudioWidgetState extends State<ChatAudioWidget> {

  Uri? uri;

  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerCompletion.listen((state) async {
          await stop();
          setState(() {});
        });
    _positionChangedSubscription = _audioPlayer.onAudioPositionChanged.listen(
          (position) => setState(() {
        _position = position;
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
          (duration) => setState(() {
        _duration = duration;
      }),
    );

    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: ()=>locator<MainViewModel>(),
      builder: (context, model, child) {
        return Align(
            alignment: model.chats[widget.index!]["message"]["userID"] ==
                model.barModel!.id!.toString()
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: EdgeInsets.only(top: 0.6.h, bottom: 0.6.h, left: 0.6.h),
                  width:
                  MediaQuery.of(context).size.width /
                      1.2,
                  decoration: BoxDecoration(
                    color: ColorUtils.messageChat,
                    borderRadius: model.chats[widget.index!]["message"]
                    ["userID"] ==
                        model.barModel!.id!.toString()
                        ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                        : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            model.chats[widget.index!]["message"]["name"] != null ?
                            Text(model.chats[widget.index!]["message"]["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                              ),) : Text(""),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildControl(),
                          _buildSlider(constraints.maxWidth),
                          // IconButton(
                          //   icon: const Icon(Icons.delete,
                          //       color: Color(0xFF73748D), size: _deleteBtnSize),
                          //   onPressed: () {
                          //     stop().then((value) => widget.onDelete());
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  )
                );
              },
            )
        );
      },
      onModelReady: (model){
        getFileUrl(model, widget.name!);
      },
      disposeViewModel: false,
    );
  }
  Widget _buildControl() {
    Icon icon;
    Color color;

    if (_audioPlayer.state == ap.PlayerState.PLAYING) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 28);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: Colors.red, size: 28);
      color = theme.scaffoldBackgroundColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
          SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            if (_audioPlayer.state == ap.PlayerState.PLAYING) {
              pause();
            } else {
              play();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    bool canSetValue = false;
    final duration = _duration;
    final position = _position;

    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;

    return SizedBox(
      //height: 0.2.h,
      width: width,
      child: Slider(
        activeColor: Theme.of(context).errorColor,
        inactiveColor: Theme.of(context).colorScheme.onError,
        onChanged: (v) {
          if (duration != null) {
            final position = v * duration.inMilliseconds;
            _audioPlayer.seek(Duration(milliseconds: position.round()));
          }
        },
        value: canSetValue && duration != null && position != null
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0,
      ),
    );
  }

  Future<void> play() {
    return _audioPlayer.play(
      uri.toString(),
      //ap.AudioPlayer(widget.source);
      //DeviceFileSource(widget.source),
    );
  }
  // void getFileUrl (MainViewModel model)async{
  //   print(model.chats[widget.index!]);
  //   //var fileInfo = widget.ImageData;
  //   uri = await model.pubnub!.files.getFileUrl(
  //     model.getConversationID(
  //         model.userModel!.id.toString(),
  //         widget.id.toString()
  //     ),
  //     model.chats[widget.index!]["file"]["id"],
  //     model.chats[widget.index!]["file"]["name"],
  //   );
  //   print(uri);
  //   setState(() {
  //
  //   });
  //
  // }

  void getFileUrl (MainViewModel model, String name)async{
    print(model.chats[widget.index!]);

    uri = await model.pubnub!.files.getFileUrl(
      name,
      model.chats[widget.index!]["file"]["id"],
      model.chats[widget.index!]["file"]["name"],
    );
    print(uri);
    setState(() {
    });
  }

  Future<void> pause() => _audioPlayer.pause();

  Future<void> stop() => _audioPlayer.stop();
}

