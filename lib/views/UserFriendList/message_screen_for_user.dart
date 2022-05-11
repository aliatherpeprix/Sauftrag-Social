import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:pubnub/core.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/listOfFollowing_Bars.dart';
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
import 'package:sauftrag/views/UserFriendList/chat_input.dart';
import 'package:sauftrag/views/UserFriendList/chat_list_widget.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:sauftrag/widgets/loader_black.dart';
import 'package:stacked/stacked.dart';

class MessageScreenForUser extends StatefulWidget {
  int? id;
  String? username;
  String? profilePic;
  bool? fromUser;

  MessageScreenForUser({Key? key, this.id, this.username, this.profilePic, this.fromUser})
      : super(key: key);

  @override
  _MessageScreenForUserState createState() => _MessageScreenForUserState();
}

class _MessageScreenForUserState extends State<MessageScreenForUser> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MainViewModel model = locator<MainViewModel>();
    model.subscription!.pause();

  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) async {
        model.initUserGrpPubNub();
        // model.chat();
       // model.getAllUserForChat();
        model.chats.clear();
        
        // Subscribe to a channel
        UserModel User =
            (await locator<PrefrencesViewModel>().getUser())!;
        model.subscription = model.pubnub!.subscribe(
            channels: {"${model.getConversationID(User.id.toString(), widget.id.toString())}"});
        var channel =
            model.pubnub!.channel("${model.getConversationID(User.id.toString(), widget.id.toString())}");
        var chat = await channel.messages();
        var data = await chat.count();
        await chat.fetch().whenComplete(() {
          print(chat.messages.length);
          for (var data in chat.messages) {
            model.chats.add(data.content);
            SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
              model.chatScroll.animateTo(
                  model.chatScroll.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            });
          }
          model.notifyListeners();
        });

        model.pubnub!.fetchMessageActions("${model.getConversationID(User.id.toString(), widget.id.toString())}",limit: 20).then((value){
          print(value);
        });

        model.subscription!.messages.listen((message) async {
          model.chats.add(message.content);
          model.notifyListeners();
        });
        
        // Send a message every second for 5 seconds

        // Unsubscribe and quit
        // await subscription.dispose();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            context.unFocus();
            model.messageScreenEmojiSelected = false;
            model.messageScreenEmojiSelected = false;
            setState(() {});
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                //controller: model.chatScroll,
                //controller: myScrollController,
                // physics: NeverScrollableScrollPhysics(),
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding,
                    ),
                    child: Stack(
                      children: [
                        if (model.openBurgerMenu == true)
                          Positioned(
                              right: 2.5.w,
                              top: 12.5.h,
                              child: GestureDetector(
                                onTap: () {
                                  //model.navigateToMsgCreateGroupScreen();
                                },
                                child: Container(
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            model.reportUserIndChat();
                                          },
                                          child: model.addDrink == false ? Text(
                                            "Report Chat",
                                            style: TextStyle(
                                                fontFamily:
                                                FontUtils.modernistRegular,
                                                fontSize: 1.9.t,
                                                color: ColorUtils.text_dark),
                                          ) : LoaderBlack()
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          "Block",
                                          style: TextStyle(
                                              fontFamily:
                                              FontUtils.modernistRegular,
                                              fontSize: 1.9.t,
                                              color: ColorUtils.text_dark),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        Column(
                          children: [
                            SizedBox(height: Dimensions.topMargin),
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        model.navigateToFollowerList();
                                      },
                                      child: Row(
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
                                          SizedBox(
                                            width: 2.5.w,
                                          ),
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              CircleAvatar(
                                                radius: 26.0,
                                                backgroundImage: NetworkImage(
                                                    widget.profilePic ??
                                                        "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"),
                                                backgroundColor:
                                                Colors.transparent,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.username.toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils.modernistBold,
                                                    fontSize: 1.9.t,
                                                    color:
                                                    ColorUtils.text_dark),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                "Active",
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils.modernistBold,
                                                    fontSize: 1.5.t,
                                                    color:
                                                    ColorUtils.activeColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (model.openBurgerMenu == false) {
                                          model.openBurgerMenu = true;
                                          model.notifyListeners();
                                        } else if (model.openBurgerMenu ==
                                            true) {
                                          model.openBurgerMenu = false;
                                          model.notifyListeners();
                                        }
                                      },
                                      icon: SvgPicture.asset(
                                          ImageUtils.chatMenuIcon),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 2.h, top: 3.h),
                              height: 75.h,
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  controller: model.chatScroll,
                                  itemBuilder: (context, index) {
                                    if(model.chats[index]["file"] != null)
                                    {

                                      if(lookupMimeType(model.chats[index]["file"]["name"])!.contains("video"))
                                      {
                                        return ChatVideoWidget(index: index, id: widget.id.toString());
                                      }
                                      else {
                                        return ChatImageWidget(index: index, id: widget.id.toString());
                                      }
                                    }
                                    else
                                    {
                                      return ChatTextWidget(index : index);
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                  itemCount: model.chats.length
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(vertical: 1.h),
                              color: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      // margin: EdgeInsets.only(left: 2.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 1.3.w,
                                        //vertical: Dimensions.verticalPadding
                                      ),
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
                                                  borderRadius:
                                                  BorderRadius.all(
                                                    Radius.circular(15.0),
                                                  ),
                                                  border: Border.all(
                                                      color:
                                                      ColorUtils.text_red)),
                                              child: Container(
                                                //color: Colors.amber,
                                                // margin:
                                                // EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 2.2.h,
                                                          horizontal:
                                                          1.7.w),
                                                      child: ExpandTapWidget(
                                                        onTap: () {
                                                          model.sendImageMessage(widget.id!);
                                                          // showDialog(
                                                          //     context: context,
                                                          //     builder: (BuildContext context) {
                                                          //       return AddDialogPlusAttachment();
                                                          //     });
                                                          // model.getImagE();
                                                          // setState(() {});
                                                        },
                                                        tapPadding:
                                                        EdgeInsets.all(4.i),
                                                        child: SvgPicture.asset(
                                                            ImageUtils
                                                                .plusIcon),
                                                      ),
                                                    ),

                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: SizeConfig
                                                                .widthMultiplier *
                                                                3,
                                                            right: SizeConfig
                                                                .widthMultiplier *
                                                                3),
                                                        child: Container(
                                                          constraints:
                                                          BoxConstraints(
                                                              maxHeight:
                                                              100),
                                                          child: TextField(
                                                            onTap: () {},
                                                            onChanged: (value) {
                                                              model
                                                                  .notifyListeners();
                                                            },
                                                            // enabled: true,
                                                            //readOnly: true,
                                                            //focusNode: model.searchFocus,
                                                            controller: model
                                                                .groupScreenChatController,
                                                            decoration:
                                                            InputDecoration(
                                                              counterText: '',
                                                              hintText:
                                                              "Type your message...",
                                                              hintStyle:
                                                              TextStyle(
                                                                //fontFamily: FontUtils.proximaNovaRegular,
                                                                //color: ColorUtils.silverColor,
                                                                fontSize: SizeConfig
                                                                    .textMultiplier *
                                                                    1.9,
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
                                                    Container(
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 1.5.h,
                                                          horizontal:
                                                          1.5.w),
                                                      decoration: BoxDecoration(
                                                        //color: ColorUtils.text_red,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .end,
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
                                                              model.openCameraGrp(widget.id!, widget.username!);
                                                            },
                                                            tapPadding:
                                                            EdgeInsets.all(
                                                                25.0),
                                                            child: SvgPicture
                                                                .asset(
                                                              ImageUtils
                                                                  .photoCamera,
                                                              color: ColorUtils
                                                                  .text_red,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),
                                                          ExpandTapWidget(
                                                            onTap: () {
                                                              //model.getImage();
                                                              setState(() {});
                                                            },
                                                            tapPadding:
                                                            EdgeInsets.all(
                                                                0.i),
                                                            child: SvgPicture
                                                                .asset(
                                                              ImageUtils
                                                                  .voiceRecorder,
                                                              color: ColorUtils
                                                                  .red_color,
                                                              height: 5.5.i,
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
                                  model.groupScreenChatController.text.length <=
                                      0
                                      ? Container(
                                    //margin: EdgeInsets.only(bottom: 2.2.h),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorUtils.text_grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        ImageUtils.sendIcon1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                      : InkWell(
                                    onTap: () async {
                                      // NewBarModel barUser =
                                      //     (await locator<PrefrencesViewModel>()
                                      //         .getBarUser())!;
                                      UserModel barUser = (await locator<
                                          PrefrencesViewModel>()
                                          .getUser())!;
                                      // model.chat();
                                      model.pubnub!.publish(
                                          model.getConversationID(
                                              barUser.id.toString(),
                                              widget.id.toString()),
                                          {
                                            "content": model
                                                .groupScreenChatController
                                                .text,
                                            "userID":
                                            barUser.id!.toString(),
                                            "time":
                                            DateTime.now().toString()
                                          });
                                      // model.pubnub!.files.publishFileMessage(model.getConversationID(barUser.id.toString(), widget.id.toString()), FileMessage(file));
                                      model.groupScreenChatController
                                          .clear();
                                      model.notifyListeners();
                                      Future.delayed(Duration(seconds: 2),
                                              () {
                                            model.scrollDown();
                                          });
                                    },
                                    child: Container(
                                      //margin: EdgeInsets.only(bottom: 2.2.h),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorUtils.text_red,
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                          ImageUtils.sendIcon1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // child: Column(
                    //   children: [
                    //     Stack(
                    //       children: [
                    //         SizedBox(height: Dimensions.topMargin),
                    //         Stack(
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 GestureDetector(
                    //                   onTap: () {
                    //                     model.navigateToFollowerList();
                    //                   },
                    //                   child: Row(
                    //                     children: [
                    //                       IconButton(
                    //                           onPressed: () {
                    //                             model.navigateBack();
                    //                           },
                    //                           iconSize: 18.0,
                    //                           padding: EdgeInsets.zero,
                    //                           constraints: BoxConstraints(),
                    //                           icon: Icon(
                    //                             Icons.arrow_back_ios,
                    //                             color: ColorUtils.black,
                    //                             size: 4.5.i,
                    //                           )),
                    //                       SizedBox(
                    //                         width: 2.5.w,
                    //                       ),
                    //                       Stack(
                    //                         alignment: Alignment.topCenter,
                    //                         children: [
                    //                           CircleAvatar(
                    //                             radius: 26.0,
                    //                             backgroundImage: NetworkImage(
                    //                                 widget.profilePic ??
                    //                                     "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"),
                    //                             backgroundColor:
                    //                                 Colors.transparent,
                    //                           ),
                    //                         ],
                    //
                    //                       ),
                    //                       SizedBox(
                    //                         width: 3.w,
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         children: [
                    //                           Text(
                    //                             widget.username.toString(),
                    //                             style: TextStyle(
                    //                                 fontFamily:
                    //                                     FontUtils.modernistBold,
                    //                                 fontSize: 1.9.t,
                    //                                 color:
                    //                                     ColorUtils.text_dark),
                    //                           ),
                    //                           SizedBox(
                    //                             height: 0.5.h,
                    //                           ),
                    //                           Text(
                    //                             "Active",
                    //                             style: TextStyle(
                    //                                 fontFamily:
                    //                                     FontUtils.modernistBold,
                    //                                 fontSize: 1.5.t,
                    //                                 color:
                    //                                     ColorUtils.activeColor),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 IconButton(
                    //                   onPressed: () {
                    //                     if (model.openBurgerMenu == false) {
                    //                       model.openBurgerMenu = true;
                    //                       model.notifyListeners();
                    //                     } else if (model.openBurgerMenu ==
                    //                         true) {
                    //                       model.openBurgerMenu = false;
                    //                       model.notifyListeners();
                    //                     }
                    //                   },
                    //                   icon: SvgPicture.asset(
                    //                       ImageUtils.chatMenuIcon),
                    //                 )
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(
                    //           height: 1.h,
                    //         ),
                    //         Container(
                    //           padding: EdgeInsets.only(bottom: 2.h, top: 3.h),
                    //           height: 75.h,
                    //           child: ListView.separated(
                    //               physics: BouncingScrollPhysics(),
                    //               controller: model.chatScroll,
                    //               itemBuilder: (context, index) {
                    //                 if(model.chats[index]["file"] != null)
                    //                 {
                    //
                    //                   if(lookupMimeType(model.chats[index]["file"]["name"])!.contains("video"))
                    //                   {
                    //                     return ChatVideoWidget(index: index, id: widget.id.toString());
                    //                   }
                    //                   else {
                    //                     return ChatImageWidget(index: index, id: widget.id.toString());
                    //                   }
                    //                 }
                    //                 else
                    //                 {
                    //                   return ChatTextWidget(index : index);
                    //                 }
                    //               },
                    //               separatorBuilder: (context, index) =>
                    //                   SizedBox(
                    //                     height: 5.h,
                    //                   ),
                    //               itemCount: model.chats.length),
                    //         ),
                    //         Container(
                    //           // padding: EdgeInsets.symmetric(vertical: 1.h),
                    //           color: Colors.white,
                    //           child: Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             crossAxisAlignment: CrossAxisAlignment.end,
                    //             children: [
                    //               Expanded(
                    //                 child: Container(
                    //                   // margin: EdgeInsets.only(left: 2.w),
                    //                   padding: EdgeInsets.symmetric(
                    //                     horizontal: 1.3.w,
                    //                     //vertical: Dimensions.verticalPadding
                    //                   ),
                    //                   child: Row(
                    //                     children: [
                    //                       Expanded(
                    //                         child: Container(
                    //                           //width: 200.0,
                    //                           margin: EdgeInsets.only(
                    //                               //left: SizeConfig.widthMultiplier * 4.5,
                    //                               //right: SizeConfig.widthMultiplier * 2,
                    //                               //top: SizeConfig.heightMultiplier * 3,
                    //                               ),
                    //                           decoration: BoxDecoration(
                    //                               color: Colors.white,
                    //                               borderRadius:
                    //                                   BorderRadius.all(
                    //                                 Radius.circular(15.0),
                    //                               ),
                    //                               border: Border.all(
                    //                                   color:
                    //                                       ColorUtils.text_red)),
                    //                           child: Container(
                    //                             //color: Colors.amber,
                    //                             // margin:
                    //                             // EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                    //                             child: Row(
                    //                               crossAxisAlignment:
                    //                                   CrossAxisAlignment.end,
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.end,
                    //                               children: [
                    //                                 Container(
                    //                                   padding:
                    //                                       EdgeInsets.symmetric(
                    //                                           vertical: 2.2.h,
                    //                                           horizontal:
                    //                                               1.7.w),
                    //                                   child: ExpandTapWidget(
                    //                                     onTap: () {
                    //                                       model.sendImageMessageUser(widget.id!);
                    //                                       // model.getImagE();
                    //                                       // setState(() {});
                    //                                     },
                    //                                     tapPadding:
                    //                                         EdgeInsets.all(4.i),
                    //                                     child: SvgPicture.asset(
                    //                                         ImageUtils
                    //                                             .plusIcon),
                    //                                   ),
                    //                                 ),
                    //
                    //                                 Expanded(
                    //                                   child: Container(
                    //                                     margin: EdgeInsets.only(
                    //                                         left: SizeConfig
                    //                                                 .widthMultiplier *
                    //                                             3,
                    //                                         right: SizeConfig
                    //                                                 .widthMultiplier *
                    //                                             3),
                    //                                     child: Container(
                    //                                       constraints:
                    //                                           BoxConstraints(
                    //                                               maxHeight:
                    //                                                   100),
                    //                                       child: TextField(
                    //                                         onTap: () {},
                    //                                         onChanged: (value){
                    //                                           model.notifyListeners();
                    //                                         },
                    //                                         // enabled: true,
                    //                                         //readOnly: true,
                    //                                         //focusNode: model.searchFocus,
                    //                                         controller: model
                    //                                             .groupScreenChatController,
                    //                                         decoration:
                    //                                             InputDecoration(
                    //                                           counterText: '',
                    //                                           hintText:
                    //                                               "Type your message...",
                    //                                           hintStyle:
                    //                                               TextStyle(
                    //                                             //fontFamily: FontUtils.proximaNovaRegular,
                    //                                             //color: ColorUtils.silverColor,
                    //                                             fontSize: SizeConfig
                    //                                                     .textMultiplier *
                    //                                                 1.9,
                    //                                           ),
                    //                                           border:
                    //                                               InputBorder
                    //                                                   .none,
                    //                                           // isDense: true,
                    //                                           contentPadding:
                    //                                               EdgeInsets.symmetric(
                    //                                                   vertical:
                    //                                                       SizeConfig.heightMultiplier *
                    //                                                           2),
                    //                                         ),
                    //                                         keyboardType:
                    //                                             TextInputType
                    //                                                 .multiline,
                    //                                         maxLines: null,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                                 Container(
                    //                                   padding:
                    //                                       EdgeInsets.symmetric(
                    //                                           vertical: 1.5.h,
                    //                                           horizontal:
                    //                                               1.5.w),
                    //                                   decoration: BoxDecoration(
                    //                                     //color: ColorUtils.text_red,
                    //                                     borderRadius:
                    //                                         BorderRadius.all(
                    //                                             Radius.circular(
                    //                                                 15)),
                    //                                   ),
                    //                                   child: Row(
                    //                                     mainAxisAlignment:
                    //                                         MainAxisAlignment
                    //                                             .end,
                    //                                     children: [
                    //                                       // ExpandTapWidget(
                    //                                       //   onTap: () {
                    //                                       //     model.getImage();
                    //                                       //     setState(() {
                    //                                       //     });
                    //                                       //   },
                    //                                       //   tapPadding: EdgeInsets.all(4.i),
                    //                                       //   child: SvgPicture.asset(ImageUtils.plusIcon),
                    //                                       // ),
                    //                                       // GestureDetector(
                    //                                       //   onTap: (){
                    //                                       //     model.getImage();
                    //                                       //   },
                    //                                       //     child: SvgPicture.asset(ImageUtils.plusIcon),
                    //                                       // ),
                    //                                       // SizedBox(width: 3.w,),
                    //                                       ExpandTapWidget(
                    //                                         onTap: () async {
                    //                                           // final cameras = await availableCameras();
                    //                                           // final firstCamera = cameras.first;
                    //                                           //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                    //                                           model.openCameraUser(widget.id!);
                    //                                         },
                    //                                         tapPadding:
                    //                                             EdgeInsets.all(
                    //                                                 25.0),
                    //                                         child: SvgPicture
                    //                                             .asset(
                    //                                           ImageUtils
                    //                                               .photoCamera,
                    //                                           color: ColorUtils
                    //                                               .text_red,
                    //                                         ),
                    //                                       ),
                    //                                       SizedBox(
                    //                                         width: 3.w,
                    //                                       ),
                    //                                       ExpandTapWidget(
                    //                                         onTap: () {
                    //                                           //model.getImage();
                    //                                           setState(() {});
                    //                                         },
                    //                                         tapPadding:
                    //                                             EdgeInsets.all(
                    //                                                 0.i),
                    //                                         child: SvgPicture
                    //                                             .asset(
                    //                                           ImageUtils
                    //                                               .voiceRecorder,
                    //                                           color: ColorUtils
                    //                                               .red_color,
                    //                                           height: 5.5.i,
                    //                                         ),
                    //                                       ),
                    //
                    //                                       SizedBox(
                    //                                         width: 1.5.w,
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 )
                    //                   // child: Padding(
                    //                   //   padding: const EdgeInsets.all(8.0),
                    //                   //   child: Column(
                    //                   //     mainAxisAlignment:
                    //                   //         MainAxisAlignment.start,
                    //                   //     crossAxisAlignment:
                    //                   //         CrossAxisAlignment.start,
                    //                   //     children: [
                    //                   //       Text(
                    //                   //         "Report Chat",
                    //                   //         style: TextStyle(
                    //                   //             fontFamily:
                    //                   //                 FontUtils.modernistRegular,
                    //                   //             fontSize: 1.9.t,
                    //                   //             color: ColorUtils.text_dark),
                    //                   //       ),
                    //                   //       SizedBox(
                    //                   //         height: 1.h,
                    //                   //       ),
                    //                   //       Text(
                    //                   //         "Block",
                    //                   //         style: TextStyle(
                    //                   //             fontFamily:
                    //                   //                 FontUtils.modernistRegular,
                    //                   //             fontSize: 1.9.t,
                    //                   //             color: ColorUtils.text_dark),
                    //                   //       ),
                    //                   //     ],
                    //                   //   ),
                    //                   // ),
                    //                 ])
                    //               )),
                    //         Column(
                    //           children: [
                    //             SizedBox(height: Dimensions.topMargin),
                    //             Stack(
                    //               children: [
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     GestureDetector(
                    //                       onTap: () {
                    //                         model.navigateToFollowerList();
                    //                       },
                    //                       child: Row(
                    //                         children: [
                    //                           IconButton(
                    //                               onPressed: () {
                    //                                 model.navigateBack();
                    //                               },
                    //                               iconSize: 18.0,
                    //                               padding: EdgeInsets.zero,
                    //                               constraints: BoxConstraints(),
                    //                               icon: Icon(
                    //                                 Icons.arrow_back_ios,
                    //                                 color: ColorUtils.black,
                    //                                 size: 4.5.i,
                    //                               )),
                    //                           SizedBox(
                    //                             width: 2.5.w,
                    //                           ),
                    //                           GestureDetector(
                    //                             onTap: () async{
                    //                               //model.getMatchedUserData = (model.acceptMatchedtModel[index]);
                    //                               if(widget.fromUser == true){
                    //                                 await model.getAnitherUserInfo(widget.id.toString());
                    //                                 model.navigateToMatchedProfileUser();
                    //                               }
                    //                               else if(widget.fromUser == false){
                    //                                 List myBars = [];
                    //                                 model.selectedBar = model.listOfAllBars.where((element) => element.id == widget.id).first;
                    //                                 //print(myBars);
                    //                                 //myBars.add(model.listOfAllBars.map((e) => e.id == widget.id));
                    //                                 // myBars.add(model.listOfAllBars.contains(widget.id));
                    //                                 print(myBars);
                    //                                 model.navigateToBarProfile();
                    //                               }
                    //                             },
                    //                             child: Stack(
                    //                               alignment: Alignment.topCenter,
                    //                               children: [
                    //                                 CircleAvatar(
                    //                                   radius: 26.0,
                    //                                   backgroundImage: NetworkImage(
                    //                                       widget.profilePic ??
                    //                                           "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"),
                    //                                   backgroundColor:
                    //                                       Colors.transparent,
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             width: 3.w,
                    //                           ),
                    //                           Column(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.start,
                    //                             children: [
                    //                               Text(
                    //                                 widget.username.toString(),
                    //                                 style: TextStyle(
                    //                                     fontFamily:
                    //                                         FontUtils.modernistBold,
                    //                                     fontSize: 1.9.t,
                    //                                     color:
                    //                                         ColorUtils.text_dark),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: 0.5.h,
                    //                               ),
                    //                               Text(
                    //                                 "Active",
                    //                                 style: TextStyle(
                    //                                     fontFamily:
                    //                                         FontUtils.modernistBold,
                    //                                     fontSize: 1.5.t,
                    //                                     color:
                    //                                         ColorUtils.activeColor),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     IconButton(
                    //                       onPressed: () {
                    //                         if (model.openBurgerMenu == false) {
                    //                           model.openBurgerMenu = true;
                    //                           model.notifyListeners();
                    //                         } else if (model.openBurgerMenu ==
                    //                             true) {
                    //                           model.openBurgerMenu = false;
                    //                           model.notifyListeners();
                    //                         }
                    //                       },
                    //                       icon: SvgPicture.asset(
                    //                           ImageUtils.chatMenuIcon),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               height: 1.h,
                    //             ),
                    //             Container(
                    //               padding: EdgeInsets.only(bottom: 2.h, top: 3.h),
                    //               height: 75.h,
                    //               child: ListView.separated(
                    //                   physics: BouncingScrollPhysics(),
                    //                   controller: model.chatScroll,
                    //                   itemBuilder: (context, index) {
                    //                     return Align(
                    //                       child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 1.7,
                    //                         decoration: BoxDecoration(
                    //                           color: ColorUtils.red_color.withOpacity(0.9),
                    //                           borderRadius: model.chats[index]
                    //                                       ["userID"] ==
                    //                                   model.barModel!.id!.toString()
                    //                               ? BorderRadius.only(
                    //                                   topLeft: Radius.circular(15),
                    //                                   topRight: Radius.circular(15),
                    //                                   bottomLeft:
                    //                                       Radius.circular(15),
                    //                                 )
                    //                               : BorderRadius.only(
                    //                                   topLeft: Radius.circular(15),
                    //                                   topRight: Radius.circular(15),
                    //                                   bottomRight:
                    //                                       Radius.circular(15),
                    //                                 ),
                    //                         ),
                    //                         child: Column(
                    //                           crossAxisAlignment: model.chats[index]
                    //                                       ["userID"] ==
                    //                                   model.barModel!.id!.toString()
                    //                               ? CrossAxisAlignment.end
                    //                               : CrossAxisAlignment.start,
                    //                           children: [
                    //                             // Padding(
                    //                             //   padding: EdgeInsets.symmetric(
                    //                             //       horizontal: 3.w,
                    //                             //       vertical: 1.5.h),
                    //                             //   child: Image.asset(
                    //                             //     ImageUtils.drinkImage,
                    //                             //   ),
                    //                             // ),
                    //                             Padding(
                    //                               padding: EdgeInsets.only(
                    //                                   left: 3.w,
                    //                                   right: 3.w,
                    //                                   top: 1.5.h),
                    //                               child: Text(
                    //                                 model.chats[index]["content"]
                    //                                     .toString(),
                    //                                 style: TextStyle(
                    //                                     //fontFamily: FontUtils.avertaDemoRegular,
                    //                                     fontSize: 1.8.t,
                    //                                     color:
                    //                                         ColorUtils.white),
                    //                               ),
                    //                             ),
                    //                             //SizedBox(height: 1.h,),
                    //                             Align(
                    //                               alignment: model.chats[index]
                    //                                           ["userID"] ==
                    //                                       model.barModel!.id!
                    //                                           .toString()
                    //                                   ? Alignment.centerLeft
                    //                                   : Alignment.centerRight,
                    //                               child: Padding(
                    //                                 padding: EdgeInsets.all(8.0),
                    //                                 child: Text(
                    //                                   model.chats[index]["time"].toString().substring(11,16),
                    //                                   style: TextStyle(
                    //                                       //fontFamily: FontUtils.avertaDemoRegular,
                    //                                       fontSize: 1.5.t,
                    //                                       color: ColorUtils
                    //                                           .icon_color),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //
                    //               ]),
                    //
                    //
                    //              // : InkWell(
                    //              //    onTap: () async {
                    //              //      // NewBarModel barUser =
                    //              //      //     (await locator<PrefrencesViewModel>()
                    //              //      //         .getBarUser())!;
                    //              //      UserModel User =
                    //              //          (await locator<PrefrencesViewModel>()
                    //              //              .getUser())!;
                    //              //      // model.chat();
                    //              //      model.pubnub!.publish(
                    //              //          model.getConversationID(User.id.toString(), widget.id.toString()),
                    //              //          {
                    //              //            "content": model.groupScreenChatController.text,
                    //              //            "userID": User.id!.toString(),
                    //              //            "time": DateTime.now().toString()
                    //              //          });
                    //              //          // model.pubnub!.files.publishFileMessage(model.getConversationID(barUser.id.toString(), widget.id.toString()), FileMessage(file));
                    //              //      model.groupScreenChatController.clear();
                    //              //      model.notifyListeners();
                    //              //      Future.delayed(Duration(seconds: 2), () {
                    //              //      model.scrollDown();
                    //              //      });
                    //              //    },
                    //              //    child: Container(
                    //              //      //margin: EdgeInsets.only(bottom: 2.2.h),
                    //              //      decoration: BoxDecoration(
                    //              //        shape: BoxShape.circle,
                    //              //        color: ColorUtils.text_red,
                    //              //      ),
                    //              //      child: Padding(
                    //              //        padding: const EdgeInsets.all(15.0),
                    //              //        child: SvgPicture.asset(
                    //              //          ImageUtils.sendIcon1,
                    //              //          color: Colors.white,
                    //              //        ),
                    //              //      ),
                    //              //    ),
                    //              //  ),
                    //         ))],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //
                    //   ],
                    // ),
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

  ChatImageWidget({Key? key, this.index, this.id}) : super(key: key);

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
        getFileUrl(model);
      },
      builder: (context, model,child){
        return Align(
          alignment: model.chats[widget.index!]["message"]["userID"] ==
              model.userModel!.id!.toString()
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
                  model.userModel!.id!.toString()
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
              crossAxisAlignment: model.chats[widget.index!]["message"]
              ["userID"] ==
                  model.userModel!.id!.toString()
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
                      model.userModel!.id!
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
  void getFileUrl (MainViewModel model)async{
    print(model.chats[widget.index!]);
    //var fileInfo = widget.ImageData;
    uri = await model.pubnub!.files.getFileUrl(
      model.getConversationID(
          model.userModel!.id.toString(),
          widget.id.toString()
      ),
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
              model.userModel!.id!.toString()
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
                  model.userModel!.id!.toString()
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
              crossAxisAlignment: model.chats[widget.index!]
              ["userID"] ==
                  model.userModel!.id!.toString()
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
                    padding: EdgeInsets.only(
                        left: 3.w,
                        right: 3.w,
                        top: 1.5.h),
                    child: Text(
                      model.chats[widget.index!]["content"]
                          .toString(),
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
                      model.userModel!.id!
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

  ChatVideoWidget({Key? key, this.index, this.id}) : super(key: key);

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
        getFileUrl(model);
      },
      builder: (context, model,child){
        return Align(
          alignment: model.chats[widget.index!]["message"]["userID"] ==
              model.userModel!.id!.toString()
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
                  model.userModel!.id!.toString()
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
              crossAxisAlignment: model.chats[widget.index!]["message"]
              ["userID"] ==
                  model.userModel!.id!.toString()
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
                      model.userModel!.id!
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
  void getFileUrl (MainViewModel model)async{
    print(model.chats[widget.index!]);
    //var fileInfo = widget.ImageData;
    uri = await model.pubnub!.files.getFileUrl(
      model.getConversationID(
          model.userModel!.id.toString(),
          widget.id.toString()
      ),
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

