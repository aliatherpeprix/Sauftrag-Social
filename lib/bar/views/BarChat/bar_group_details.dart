import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/UserFriendList/group_screen.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/image_edit_dialog.dart';
import 'package:stacked/stacked.dart';

import '../../../models/create_group_chat.dart';
import 'bar_group_screen.dart';

class BarGroupDetails extends StatefulWidget {
  int? id;
  BarGroupDetails({Key? key, this.id}) : super(key: key);

  @override
  _BarGroupDetailsState createState() => _BarGroupDetailsState();
}

class _BarGroupDetailsState extends State<BarGroupDetails> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        model.barGroupNameController.clear();
        model.createEventImage = File("");
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            model.emojiSelected = false;
            model.emojiShowing = false;
            model.notifyListeners();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              //resizeToAvoidBottomInset: false,
              floatingActionButton: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalPadding,
                ),
                child: ElevatedButton(

                  onPressed: () async {
                    if (model.barGroupNameController.text.isNotEmpty){
                      model.getUserId = [];
                      for (var data in model.groupList) {
                        model.getUserId.add(data['id']);
                      }
                      if (await model.createGroupChatBar() is List<CreateGroupChat>){
                          NewBarModel barUser =
                          (await locator<PrefrencesViewModel>().getBarUser())!;
                          UserModel user =
                          (await locator<PrefrencesViewModel>().getUser())!;
                          model.subscription = model.pubnub!.subscribe(channels: {model.barGroupNameController.text});
                          model.channel = model.pubnub!.channel(model.barGroupNameController.text);
                          List<ChannelMemberMetadataInput> setMetadata = [];
                          for (var data in model.groupList) {
                            var user =
                            ChannelMemberMetadataInput(data['id'].toString());
                            setMetadata.add(user);
                          }
                          model.pubnub!.objects.setChannelMetadata(model.barGroupNameController.text,
                              ChannelMetadataInput(name: model.barGroupNameController.text,description: "Group", custom: {
                                "admin" : model.barModel!.id
                              }));
                          model.pubnub!.objects.setChannelMembers(model.barGroupNameController.text, setMetadata);
                          print(setMetadata);
                          if(model.barModel!.role == 2){
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType
                                        .fade,
                                    child:
                                    BarGroupScreen(
                                      // id: model.groupChatUser!.id ?? 0,
                                      // username: model.groupChatUser!.name,
                                        id: model.getUserGroup!.first.id ?? 0,
                                        username: model.getUserGroup!.first.name,
                                        groupImg: model.getUserGroup!.first.image,
                                        userLength: model.getUserGroup!.first.users!.length
                                    )
                                ));
                          }
                          else{
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType
                                        .fade,
                                    child:
                                    BarGroupScreen(
                                        id: model.getUserGroup!.first.id! ?? 0,
                                        username: model.getUserGroup!.first.name,
                                        groupImg: model.getUserGroup!.first.image,
                                        userLength: model.getUserGroup!.first.users!.length
                                      //userLength: model.getListGroup[index].users!.length
                                    )
                                ));
                          }
                        }
                      }

                  },
                  child: const Text("Create Group"),
                  style: ElevatedButton.styleFrom(
                    primary: ColorUtils.text_red,
                    onPrimary: ColorUtils.white,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.containerVerticalPadding),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.roundCorner)),
                    textStyle: TextStyle(
                      color: ColorUtils.white,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 1.8.t,
                      //height: 0
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              backgroundColor: ColorUtils.white,
              body: Container(
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
                          "Group Name",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 3.t,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: ()  {
                                    model.createEventGetImage();
                                    //model.openCamera();
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return EditImageDialog(
                                    //           from: Constants.profileImage);
                                    //     });
                                  },
                                  child: Container(
                                    height: 6.7.h,
                                    width: 14.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorUtils.textFieldBg,
                                    ),
                                    child: model.createEventImage!.path.isEmpty?
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(ImageUtils.photoCamera),
                                    )
                                        : ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(model.createEventImage!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: Container(
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
                                        horizontal:
                                            SizeConfig.widthMultiplier * 3,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .widthMultiplier *
                                                      3,
                                                  right: SizeConfig
                                                          .widthMultiplier *
                                                      3),
                                              child: TextField(
                                                onTap: () {},
                                                enabled: true,
                                                //readOnly: true,
                                                //focusNode: model.searchFocus,
                                                controller:
                                                    model.barGroupNameController,
                                                decoration: InputDecoration(
                                                  hintText: "Enter Group Name",
                                                  hintStyle: TextStyle(
                                                    //fontFamily: FontUtils.proximaNovaRegular,
                                                    color:
                                                        ColorUtils.icon_color,
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        1.9,
                                                  ),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: SizeConfig
                                                                  .heightMultiplier *
                                                              2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ExpandTapWidget(
                                            onTap: () {
                                              model.emojiShowing =
                                                  !model.emojiShowing;
                                              model.emojiSelected =
                                                  !model.emojiSelected;
                                              model.notifyListeners();
                                            },
                                            tapPadding: EdgeInsets.all(25.0),
                                            child: SvgPicture.asset(
                                                ImageUtils.smileyIcon),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (model.emojiSelected == true)
                              Container(
                                height: 25.h,
                                child: Offstage(
                                  offstage: !model.emojiShowing,
                                  child: EmojiPicker(
                                      onEmojiSelected:
                                          (Category category, Emoji emoji) {
                                        model.onEmojiSelected(emoji);
                                      },
                                      onBackspacePressed:
                                          model.onBackspacePressed,
                                      config: Config(
                                          columns: 7,
                                          // Issue: https://github.com/flutter/flutter/issues/28894
                                          emojiSizeMax: 32 *
                                              (Platform.isIOS ? 1.30 : 1.0),
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
                                              fontSize: 20,
                                              color: Colors.black26),
                                          tabIndicatorAnimDuration:
                                              kTabScrollDuration,
                                          categoryIcons: const CategoryIcons(),
                                          buttonMode: ButtonMode.MATERIAL)),
                                ),
                              ),
                            // SizedBox(
                            //   height: 4.h,
                            // ),
                            // Center(
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () {
                            //           model.privateGroupSelected = true;
                            //           model.publicGroupSelected = false;
                            //           model.notifyListeners();
                            //         },
                            //         child: Row(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Container(
                            //               width: 25.w,
                            //               height: 5.5.h,
                            //               decoration: BoxDecoration(
                            //                 shape: BoxShape.rectangle,
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(15)),
                            //                 border: Border.all(
                            //                     color: ColorUtils.text_red),
                            //                 color: model.privateGroupSelected ==
                            //                         true
                            //                     ? ColorUtils.text_red
                            //                     : Colors.white,
                            //               ),
                            //               child: Row(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   SvgPicture.asset(
                            //                     ImageUtils.lockIcon,
                            //                     color:
                            //                         model.privateGroupSelected ==
                            //                                 true
                            //                             ? Colors.white
                            //                             : ColorUtils.text_red,
                            //                   ),
                            //                   SizedBox(
                            //                     width: 2.w,
                            //                   ),
                            //                   Text(
                            //                     "Private",
                            //                     style: TextStyle(
                            //                       color:
                            //                           model.privateGroupSelected ==
                            //                                   true
                            //                               ? Colors.white
                            //                               : ColorUtils.text_red,
                            //                       fontFamily: FontUtils
                            //                           .modernistRegular,
                            //                       fontSize: 1.8.t,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         width: 4.w,
                            //       ),
                            //       GestureDetector(
                            //         onTap: () {
                            //           model.publicGroupSelected = true;
                            //           model.privateGroupSelected = false;
                            //           model.notifyListeners();
                            //         },
                            //         child: Row(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Container(
                            //               width: 25.w,
                            //               height: 5.5.h,
                            //               decoration: BoxDecoration(
                            //                 color: model.publicGroupSelected ==
                            //                         true
                            //                     ? ColorUtils.text_red
                            //                     : Colors.white,
                            //                 shape: BoxShape.rectangle,
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(15)),
                            //                 border: Border.all(
                            //                     color: ColorUtils.text_red),
                            //               ),
                            //               child: Row(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   SvgPicture.asset(
                            //                     ImageUtils.speaker,
                            //                     color:
                            //                         model.publicGroupSelected ==
                            //                                 true
                            //                             ? Colors.white
                            //                             : ColorUtils.text_red,
                            //                   ),
                            //                   SizedBox(
                            //                     width: 2.w,
                            //                   ),
                            //                   Text(
                            //                     "Public",
                            //                     style: TextStyle(
                            //                       color:
                            //                           model.publicGroupSelected ==
                            //                                   true
                            //                               ? Colors.white
                            //                               : ColorUtils.text_red,
                            //                       fontFamily: FontUtils
                            //                           .modernistRegular,
                            //                       fontSize: 1.8.t,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Divider(
                              color: ColorUtils.divider,
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Text(
                              "Participants",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.2.t,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3.h),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: model.groupList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  //mainAxisSpacing: 18,
                                  childAspectRatio: 0.6,
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        child: Stack(
                                          //fit: StackFit.loose,
                                          alignment: Alignment.topCenter,
                                          children: [
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage: NetworkImage(
                                                  model.groupList[index]
                                                      ["image"]),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.groupList.removeAt(index);
                                                model.notifyListeners();
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 2.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: ColorUtils
                                                            .text_red),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: SvgPicture.asset(
                                                      ImageUtils.cross,
                                                      width: 2.0.i,
                                                      height: 2.0.i,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        //height: 30.h,
                                        child: Text(
                                          (model.groupList[index]["name"]),
                                          style: TextStyle(
                                              fontFamily:
                                                  FontUtils.modernistBold,
                                              fontSize: 1.6.t,
                                              color: ColorUtils.text_dark),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
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
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
