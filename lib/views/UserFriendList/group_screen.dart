import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:page_transition/page_transition.dart';
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
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';

import 'group_detail_screen.dart';

class GroupScreen extends StatefulWidget {

  int? id;
  String? username;
  int? userLength;
  String? groupImg;
  List<UserModel>? groupUser;

  GroupScreen({Key? key, this.id, this.username,  this.userLength, this.groupUser, this.groupImg}) : super(key: key);

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

        //print("Testing");
        // Print every message
        model.subscription!.messages.listen((message) async {
          model.chats.add(message.content);
          model.notifyListeners();
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
                                            model.sendImageMessageGrpUser(widget.id!, widget.username!);
                                            // model.getImagE();
                                            // setState(() {});
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
                                                  model.openCameraGrp(widget.id!, widget.username!);
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

                        model.pubnub!.publish(widget.username!, {
                          "content": model.groupScreenChatController.text,
                          "userID": user.id!.toString(),
                          "time":DateTime.now().toString()
                        });
                        model.groupScreenChatController.clear();
                        Future.delayed(Duration(seconds: 2), () {
                          model.scrollDown();
                        });
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
                                        model.navigateToFriendListScreen();
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context ,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .fade,
                                              child:
                                              Group_Details(
                                                  id: widget.id,
                                                  username: widget.username,
                                                  userLength: widget.userLength,
                                                  groupUser: widget.groupUser
                                              )
                                          )
                                      );
                                    },
                                    child: Row(
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
                                                    ImageUtils.groupLock),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.8.h,
                                            ),
                                            Text(
                                              widget.userLength!.toString() + " Members" ,
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
                          controller: model.chatScroll,
                          itemBuilder: (context, index) {

                            if(model.chats[index]["file"] != null)
                            {
                              if(lookupMimeType(model.chats[index]["file"]["name"])!.contains("video"))
                              {
                                return ChatVideoWidget(index: index, id: widget.id.toString(), name: widget.username);
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
                bottomLeft:
                Radius.circular(15),
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
              model.userModel!.id!.toString()
              ? Alignment.centerLeft
              : Alignment.centerRight,
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
              model.userModel!.id!.toString()
              ? Alignment.centerRight
              : Alignment.centerLeft,
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
