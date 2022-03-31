import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
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

import 'message_screen_for_user.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  // void initState() {
  //   super.initState();
  //   selected = List<bool>.filled(contactChecked.length, false);
  // }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return ColorUtils.text_red;
      }
      return ColorUtils.text_red;
    }

    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        model.groupList.clear();
        model.selected = List<bool>.filled(model.userForChats.length, false);
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
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
                            "Individual Chat",
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
                                    controller:
                                        model.friendListSearchController,
                                    decoration: InputDecoration(
                                      hintText: "Search",
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
                                              SizeConfig.heightMultiplier * 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Expanded(
                        child:  Container(
                          child: Column(
                            children: [
                              ListView.separated(
                                  padding:
                                  EdgeInsets.only(top: 0.h),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if(model.userModel!.role == 1){
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .fade,
                                                  child:
                                                  MessageScreenForUser(
                                                    id: model
                                                        .matchedUsers[index]
                                                        .id,
                                                    username: model
                                                        .matchedUsers[index]
                                                        .username,
                                                    profilePic: model
                                                        .matchedUsers[index]
                                                        .profile_picture,
                                                  )));
                                        }
                                        else{
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .fade,
                                                  child:
                                                  MessageScreenForUser(
                                                    id: model
                                                        .barsList[index]
                                                        .id,
                                                    username: model
                                                        .barsList[index]
                                                        .username,
                                                    profilePic: model
                                                        .barsList[index]
                                                        .profile_picture,
                                                  )));
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Stack(
                                                  //   alignment:
                                                  //       Alignment.topCenter,
                                                  //   children: [
                                                  CircleAvatar(
                                                    radius: 30.0,
                                                    backgroundImage:
                                                    model.userModel!.role == 1 ?
                                                    NetworkImage(
                                                        model
                                                            .matchedUsers[
                                                        index]
                                                            .profile_picture ??
                                                            "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164")
                                                        :
                                                    NetworkImage(model
                                                        .matchedUsers[
                                                    index]
                                                        .profile_picture ??
                                                        "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"),
                                                    backgroundColor:
                                                    Colors
                                                        .transparent,
                                                  ),
                                                  // if (friendsList[index]
                                                  //         ["online"] ==
                                                  //     true)
                                                  //   Positioned(
                                                  //     top: 0.5.h,
                                                  //     right: 0.w,
                                                  //     child: Container(
                                                  //       decoration:
                                                  //           BoxDecoration(
                                                  //         shape: BoxShape
                                                  //             .circle,
                                                  //         color: ColorUtils
                                                  //             .onlineProfileColor,
                                                  //       ),
                                                  //       width: 2.5.i,
                                                  //       height: 2.5.i,
                                                  //     ),
                                                  //   ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      model.userModel!.role == 1 ?
                                                      Text(
                                                        model
                                                            .matchedUsers[
                                                        index]
                                                            .username
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                            FontUtils
                                                                .modernistBold,
                                                            fontSize:
                                                            1.9.t,
                                                            color: ColorUtils
                                                                .text_dark),
                                                      ):
                                                      Text(
                                                        model
                                                            .barsList[
                                                        index]
                                                            .username
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                            FontUtils
                                                                .modernistBold,
                                                            fontSize:
                                                            1.9.t,
                                                            color: ColorUtils
                                                                .text_dark),
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 2.h,
                                    );
                                  },
                                  itemCount: model.userModel!.role == 1 ?
                                  model.matchedUsers.length :
                                  model.barsList.length
                              ),
                              ListView.separated(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.h),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if(model.userModel!.role == 1){
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .fade,
                                                  child:
                                                  MessageScreenForUser(
                                                    id: model
                                                        .listOfBar[index]
                                                        .id,
                                                    username: model
                                                        .listOfBar[index]
                                                        .username,
                                                    profilePic: model
                                                        .listOfBar[index]
                                                        .profile_picture,
                                                  )));
                                        }
                                        else{
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .fade,
                                                  child:
                                                  MessageScreenForUser(
                                                    id: model
                                                        .barsList[index]
                                                        .id,
                                                    username: model
                                                        .barsList[index]
                                                        .username,
                                                    profilePic: model
                                                        .barsList[index]
                                                        .profile_picture,
                                                  )));
                                        }
                                      },
                                      child: Column(
                                        children: [

                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Stack(
                                                  //   alignment:
                                                  //       Alignment.topCenter,
                                                  //   children: [
                                                  CircleAvatar(
                                                    radius: 28.0,
                                                    backgroundImage:
                                                    model.userModel!.role == 1 ?
                                                    NetworkImage(
                                                        model
                                                            .listOfBar[
                                                        index]
                                                            .profile_picture ??
                                                            "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164")
                                                        :
                                                    NetworkImage(model
                                                        .listOfBar[
                                                    index]
                                                        .profile_picture ??
                                                        "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"),
                                                    backgroundColor:
                                                    Colors
                                                        .transparent,
                                                  ),
                                                  // if (friendsList[index]
                                                  //         ["online"] ==
                                                  //     true)
                                                  //   Positioned(
                                                  //     top: 0.5.h,
                                                  //     right: 0.w,
                                                  //     child: Container(
                                                  //       decoration:
                                                  //           BoxDecoration(
                                                  //         shape: BoxShape
                                                  //             .circle,
                                                  //         color: ColorUtils
                                                  //             .onlineProfileColor,
                                                  //       ),
                                                  //       width: 2.5.i,
                                                  //       height: 2.5.i,
                                                  //     ),
                                                  //   ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      model.userModel!.role == 1 ?
                                                      Text(
                                                        model
                                                            .listOfBar[
                                                        index]
                                                            .username
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                            FontUtils
                                                                .modernistBold,
                                                            fontSize:
                                                            1.9.t,
                                                            color: ColorUtils
                                                                .text_dark),
                                                      ):
                                                      Text(
                                                        model
                                                            .barsList[
                                                        index]
                                                            .username
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                            FontUtils
                                                                .modernistBold,
                                                            fontSize:
                                                            1.9.t,
                                                            color: ColorUtils
                                                                .text_dark),
                                                      ),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      // Container(
                                                      //   width: MediaQuery.of(
                                                      //               context)
                                                      //           .size
                                                      //           .width /
                                                      //       2,
                                                      //   child: Text(
                                                      //     friendsList[index]
                                                      //         ["message"],
                                                      //     style: TextStyle(
                                                      //         fontFamily: FontUtils
                                                      //             .modernistRegular,
                                                      //         fontSize: 1.8.t,
                                                      //         color: ColorUtils
                                                      //             .lightTextColor),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  // Text(
                                                  //   friendsList[index]["time"],
                                                  //   style: TextStyle(
                                                  //     fontFamily: FontUtils
                                                  //         .modernistRegular,
                                                  //     fontSize: 1.6.t,
                                                  //     color:
                                                  //         ColorUtils.chatTime,
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  // if (friendsList[index]
                                                  //         ["online"] ==
                                                  //     true)
                                                  //   Container(
                                                  //     decoration: BoxDecoration(
                                                  //       shape: BoxShape.circle,
                                                  //       color:
                                                  //           ColorUtils.text_red,
                                                  //     ),
                                                  //     child: Center(
                                                  //       child: Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .all(8.0),
                                                  //         child: Text(
                                                  //           "1",
                                                  //           style: TextStyle(
                                                  //               fontFamily:
                                                  //                   FontUtils
                                                  //                       .modernistBold,
                                                  //               fontSize: 1.5.t,
                                                  //               color: Colors
                                                  //                   .white),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 2.h,
                                    );
                                  },
                                  itemCount: model.userModel!.role == 1 ?
                                  model.listOfBar.length :
                                  model.barsList.length
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),  
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
