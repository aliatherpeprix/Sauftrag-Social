import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/UserFriendList/group_screen_user.dart';

import 'package:sauftrag/views/UserFriendList/groupScreen.dart';
import 'package:sauftrag/views/UserFriendList/message_screen.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:stacked/stacked.dart';

import 'bar_group_screen.dart';
import 'message_screen_for_bar.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  String dropdownValue = 'hi';

  List friendsList = [
    {
      'name': "Athalia Putri",
      'message': "Good morning, did you sleep well?",
      'time': "Today",
      'image': ImageUtils.messagePerson1,
      'online': true,
    },
    {
      'name': "Erlan Sadewa",
      'message': "Alright, Noted.",
      'time': "23 min ago",
      'image': ImageUtils.messagePerson2,
      'online': false,
    },
    {
      'name': "Raki Devon",
      'message': "How is it going?",
      'time': "Today",
      'image': ImageUtils.messagePerson3,
      'online': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        model.getGroupList();
        model.getBarsFollowerList();
        //model.initBarPubNub();
        model.openGroupMenu = false;
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            context.unFocus();
            model.openGroupMenu = false;
            model.notifyListeners();
          },
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalPadding,
                ),
                child: Stack(
                  children: [
                    // if (model.openGroupMenu == true)
                    //   Positioned(
                    //       right: 0.w,
                    //       top: 10.7.h,
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           model.navigateToBarGroupScreen();
                    //         },
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.black.withOpacity(0.1),
                    //                 spreadRadius: 0,
                    //                 blurRadius: 10,
                    //                 offset: Offset(
                    //                     0, 5), // changes position of shadow
                    //               ),
                    //             ],
                    //             color: Colors.white,
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(6)),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 SvgPicture.asset(ImageUtils.multipleUsers),
                    //                 SizedBox(
                    //                   width: 2.w,
                    //                 ),
                    //                 Text(
                    //                   "New Group",
                    //                   style: TextStyle(
                    //                       fontFamily:
                    //                           FontUtils.modernistRegular,
                    //                       fontSize: 1.7.t,
                    //                       color: ColorUtils.text_dark),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    Column(
                      children: [
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       model.getGroupChannelFromPubnub();
                        //     },
                        //     child: Text("click me")),
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Messages",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                color: Colors.black,
                                fontSize: 3.t,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    model.navigateToInvitePeopleScreen();
                                    // if(model.openGroupMenu == false){
                                    //   model.openGroupMenu = true;
                                    //   model.notifyListeners();
                                    // }
                                    // else if (model.openGroupMenu == true){
                                    //   model.openGroupMenu = false;
                                    //   model.notifyListeners();
                                    // }
                                  },
                                  icon: SvgPicture.asset(
                                      ImageUtils.addFriendIcon),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    model
                                        .navigateToBarIndividualChatScreen();
                                    // if(model.openGroupMenu == false){
                                    //   model.openGroupMenu = true;
                                    //   model.notifyListeners();
                                    // }
                                    // else if (model.openGroupMenu == true){
                                    //   model.openGroupMenu = false;
                                    //   model.notifyListeners();
                                    // }
                                  },
                                  icon:
                                      SvgPicture.asset(ImageUtils.messageIcon),
                                ),
                                IconButton(
                                  onPressed: () {
                                    model.navigateToBarGroupScreen();
                                    // if (model.openGroupMenu == false) {
                                    //   model.openGroupMenu = true;
                                    //   model.notifyListeners();
                                    // } else if (model.openGroupMenu == true) {
                                    //   model.openGroupMenu = false;
                                    //   model.notifyListeners();
                                    // }
                                  },
                                  icon: SvgPicture.asset(ImageUtils.multipleUsers),
                                )
                              ],
                            ),
                          ],
                        ),
                        //if(model.openMenu == false)
                        SizedBox(
                          height: 3.7.h,
                        ),
                        // if(model.openMenu == true)
                        //   Align(
                        //     alignment: Alignment.centerRight,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black.withOpacity(0.1),
                        //             spreadRadius: 0,
                        //             blurRadius: 10,
                        //             offset: Offset(0, 5), // changes position of shadow
                        //           ),
                        //         ],
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.all(Radius.circular(6)),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             SvgPicture.asset(ImageUtils.multipleUsers),
                        //             SizedBox(width: 2.w,),
                        //             Text("New Group",
                        //               style: TextStyle(
                        //                   fontFamily: FontUtils.modernistRegular,
                        //                   fontSize: 1.7.t,
                        //                   color: ColorUtils.text_dark
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
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
                        SizedBox(
                          height: 2.h,
                        ),
                        //SizedBox(height: 2.h),
                        Container(
                          child: TabBar(
                            labelPadding: EdgeInsets.zero,
                            indicatorColor: ColorUtils.text_red,
                            labelColor: ColorUtils.text_red,
                            labelStyle: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.t,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 2.t,
                            ),
                            unselectedLabelColor: ColorUtils.icon_color,
                            tabs: [
                              Tab(
                                text: "Direct",
                              ),
                              Tab(
                                text: "Groups",
                              ),
                            ],
                          ),
                        ),
                        model.userComing == true
                            ? Container(
                                color: Colors.white,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 25.h),
                                    child: SizedBox(
                                      height: 10.i,
                                      width: 10.i,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            ColorUtils.red_color),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: TabBarView(
                                  children: [
                                    ///------- Direct Message -------///
                                    // first tab bar view widget
                                    ListView.separated(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3.h),
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {


                                          dynamic image = model.getFollowerList[index].follow_by?[0].profile_picture??"";

                                          return GestureDetector(
                                            onTap: () {
                                              if(model.barModel!.role == 2){
                                                Navigator.push(
                                                    context,

                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                        MessageScreenForBar(
                                                          id: model.getFollowerList[index].follow_by?[0]
                                                              .id,
                                                          username: model.getFollowerList[index].follow_by?[0]
                                                              .username,
                                                          profilePic: model.getFollowerList[index].follow_by?[0]
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
                                                        MessageScreenForBar(
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
                                                              NetworkImage(image??"" /*?? "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"*/),
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
                                                            Text(
                                                              model.getFollowerList[index].follow_by?[0].username??"",
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
                                        itemCount: model.getFollowerList.length),

                                    // second tab bar viiew widget

                                    ///------- Group Message -------///
                                    GestureDetector(
                                      onTap: () {
                                        //model.navigateToGroupScreen();
                                      },
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            ListView.separated(
                                                padding:
                                                EdgeInsets.only(top: 3.h),
                                                physics: BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if(model.barModel!.role == 2){
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                type: PageTransitionType
                                                                    .fade,
                                                                child:
                                                                BarGroupScreen(
                                                                    id: model.getListGroup[index].id,
                                                                    username: model.getListGroup[index].name,
                                                                    userLength: model.getListGroup[index].users!.length
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
                                                                    id: model.getListGroup[index].id,
                                                                    username: model.getListGroup[index].name,
                                                                    userLength: model.getListGroup[index].users!.length
                                                                )
                                                            ));
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
                                                                CircleAvatar(
                                                                  radius: 28.0,
                                                                  backgroundImage: AssetImage(
                                                                      ImageUtils.cosmos),
                                                                  backgroundColor:
                                                                  Colors.transparent,
                                                                ),
                                                                SizedBox(
                                                                  width: 3.w,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      model.getListGroup[index].name!,
                                                                      style: TextStyle(
                                                                          fontFamily: FontUtils
                                                                              .modernistBold,
                                                                          fontSize: 1.9.t,
                                                                          color: ColorUtils
                                                                              .text_dark),
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height: 1.h,
                                                                    // ),
                                                                    // Container(
                                                                    //   width:
                                                                    //   MediaQuery.of(context)
                                                                    //       .size
                                                                    //       .width /
                                                                    //       2,
                                                                    //   child: Text(
                                                                    //     "Did you see the last episode of cosmos?",
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
                                                                Text(
                                                                  "Today",
                                                                  style: TextStyle(
                                                                    fontFamily: FontUtils
                                                                        .modernistRegular,
                                                                    fontSize: 1.6.t,
                                                                    color: ColorUtils.chatTime,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 1.h,
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
                                                itemCount: model.getListGroup.length
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //GroupScreenUser(),
                                    //GroupScreenChat()

                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
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
