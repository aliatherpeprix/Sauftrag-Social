import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pubnub/core.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
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
import 'package:stacked/stacked.dart';

class MessageScreenForUser extends StatefulWidget {
  int? id;
  String? username;
  String? profilePic;
  MessageScreenForUser({Key? key, this.id, this.username, this.profilePic})
      : super(key: key);

  @override
  _MessageScreenForUserState createState() => _MessageScreenForUserState();
}

class _MessageScreenForUserState extends State<MessageScreenForUser> {
  final scrollController = ScrollController();

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
        model.initBarPubNub();
        // model.chat();
       // model.getAllUserForChat();
        model.chats.clear();
        
        // Subscribe to a channel
        UserModel barUser =
            (await locator<PrefrencesViewModel>().getUser())!;
        model.subscription = model.pubnub!.subscribe(
            channels: {"${model.getConversationID(barUser.id.toString(), widget.id.toString())}"});
        var channel =
            model.pubnub!.channel("${model.getConversationID(barUser.id.toString(), widget.id.toString())}");
        var chat = await channel.messages();
        var data = await chat.count();
        await chat.fetch().whenComplete(() {
          print(chat.messages.length);
          for (var data in chat.messages) {
            model.chats.add(data.content);
          }
          model.notifyListeners();
        });

        model.pubnub!.fetchMessageActions("${model.getConversationID(barUser.id.toString(), widget.id.toString())}",limit: 20).then((value){
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
              // resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              
              body: SingleChildScrollView(
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
                                        Text(
                                          "Report Chat",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontUtils.modernistRegular,
                                              fontSize: 1.9.t,
                                              color: ColorUtils.text_dark),
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
                                    return Align(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        decoration: BoxDecoration(
                                          color: ColorUtils.red_color.withOpacity(0.9),
                                          borderRadius: model.chats[index]
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
                                          crossAxisAlignment: model.chats[index]
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
                                              padding: EdgeInsets.only(
                                                  left: 3.w,
                                                  right: 3.w,
                                                  top: 1.5.h),
                                              child: Text(
                                                model.chats[index]["content"]
                                                    .toString(),
                                                style: TextStyle(
                                                    //fontFamily: FontUtils.avertaDemoRegular,
                                                    fontSize: 1.8.t,
                                                    color:
                                                        ColorUtils.white),
                                              ),
                                            ),
                                            //SizedBox(height: 1.h,),
                                            Align(
                                              alignment: model.chats[index]
                                                          ["userID"] ==
                                                      model.barModel!.id!
                                                          .toString()
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  model.chats[index]["time"].toString().substring(11,16),
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
                                      alignment: model.chats[index]["userID"] ==
                                          model.barModel!.id!.toString()
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                  itemCount: model.chats.length),
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
                                                          model.getImagE();
                                                          setState(() {});
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
                                                            onChanged: (value){
                                                              model.notifyListeners();
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
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              // isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          SizeConfig.heightMultiplier *
                                                                              2),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
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
                                                              model
                                                                  .openCamera();
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
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  model.groupScreenChatController.text.length <=0 ?
                                  Container(
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
                                      UserModel barUser =
                                          (await locator<PrefrencesViewModel>()
                                              .getUser())!;
                                      // model.chat();
                                      model.pubnub!.publish(
                                          model.getConversationID(barUser.id.toString(), widget.id.toString()),
                                          {
                                            "content": model
                                                .groupScreenChatController.text,
                                            "userID": barUser.id!.toString(),
                                            "time": DateTime.now().toString()
                                          });
                                          // model.pubnub!.files.publishFileMessage(model.getConversationID(barUser.id.toString(), widget.id.toString()), FileMessage(file));
                                      model.groupScreenChatController.clear();
                                      model.notifyListeners();
                                      Future.delayed(Duration(seconds: 2), () {
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
                                        padding: const EdgeInsets.all(15.0),
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
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
