import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) async {
        NewBarModel barUser =
            (await locator<PrefrencesViewModel>().getBarUser())!;
        UserModel user = (await locator<PrefrencesViewModel>().getUser())!;
        var pubnub = PubNub(
            defaultKeyset: Keyset(
                subscribeKey: 'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4',
                publishKey: 'pub-c-1f404751-6cfb-44a8-bfea-4ab9102975ac',
                uuid: UUID("Cosmos")));
        // Subscribe to a channel
        var subscription = pubnub.subscribe(channels: {"Cosmos"});

        var channel = pubnub.channel("Cosmos");
        var chat = await channel.messages();
        var data = await chat.count();
        await chat.fetch().whenComplete(() {
          model.chats.clear();
          print(chat.messages.length);
          for (var data in chat.messages) {
            model.chats.add(data.content);
          }
          model.notifyListeners();
        });

        //print("Testing");
        // Print every message
        subscription.messages.listen((message) async {
          //print(message.content);
          //model.message = message.content;
          model.chats.add(message.content);
          // message.uuid;
          // print(message.flags);
          model.notifyListeners();
          // model.chats = (message.content['content'] as List)
          //     .map((e) => Envelope.fromJson(e))
          //     .toList();
          // model.pubnub
          //     .publish(model.channel, model.groupScreenChatController.text);
          //   for (var i in model.chats) {
          //     await model.pubnub.publish(model.channel, i[Envelope]);
          //   }
        });
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
              floatingActionButton: Container(
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
                                    //left: SizeConfig.widthMultiplier * 4.5,
                                    //right: SizeConfig.widthMultiplier * 2,
                                    //top: SizeConfig.heightMultiplier * 3,
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
                                            model.getImagE();
                                            setState(() {});
                                          },
                                          tapPadding: EdgeInsets.all(4.i),
                                          child: SvgPicture.asset(
                                              ImageUtils.plusIcon),
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
                                              child: TextField(
                                                onTap: () {},
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
                                              ),
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
                                                model.openCamera();
                                              },
                                              tapPadding: EdgeInsets.all(25.0),
                                              child: SvgPicture.asset(
                                                ImageUtils.photoCamera,
                                                color: ColorUtils.text_red,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            ExpandTapWidget(
                                              onTap: () {
                                                // model.getImage();
                                                setState(() {});
                                              },
                                              tapPadding: EdgeInsets.all(0.i),
                                              child: SvgPicture.asset(
                                                ImageUtils.voiceRecorder,
                                                color: ColorUtils.red_color,
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
                    InkWell(
                      onTap: () async {
                        NewBarModel barUser =
                            (await locator<PrefrencesViewModel>()
                                .getBarUser())!;
                        UserModel user =
                            (await locator<PrefrencesViewModel>().getUser())!;
                        // model.chat();
                        var pubnub = PubNub(
                            defaultKeyset: Keyset(
                                subscribeKey:
                                    'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4',
                                publishKey:
                                    'pub-c-1f404751-6cfb-44a8-bfea-4ab9102975ac',
                                uuid: UUID("Cosmos")));
                        pubnub.publish("Cosmos", {
                          "content": model.groupScreenChatController.text,
                          "userID": barUser.id!.toString()
                        });
                        model.groupScreenChatController.clear();
                        model.notifyListeners();
                      },
                      child: Container(
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
                      ),
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
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          CircleAvatar(
                                            radius: 26.0,
                                            backgroundImage:
                                                AssetImage(ImageUtils.cosmos),
                                            backgroundColor: Colors.transparent,
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
                                                "Cosmos",
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
                                                  ImageUtils.groupLock),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.8.h,
                                          ),
                                          Text(
                                            "4 Members, 1 Online",
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
                              SvgPicture.asset(ImageUtils.chatMenuIcon),
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
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: model.chats[index]["userID"] ==
                                      model.barModel!.id!.toString()
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.7,
                                decoration: BoxDecoration(
                                  color: ColorUtils.messageChat,
                                  borderRadius: model.chats[index]["userID"] ==
                                          model.barModel!.id!.toString()
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        )
                                      : BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
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
                                          left: 3.w, right: 3.w, top: 1.5.h),
                                      child: Text(
                                        model.chats[index]["content"]
                                            .toString(),
                                        style: TextStyle(
                                            //fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.text_dark),
                                      ),
                                    ),
                                    //SizedBox(height: 1.h,),
                                    Align(
                                      alignment: model.chats[index]["userID"] ==
                                              model.barModel!.id!.toString()
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "02:45 pm",
                                          style: TextStyle(
                                              //fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.5.t,
                                              color: ColorUtils.icon_color),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
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
