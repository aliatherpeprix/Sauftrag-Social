import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/create_group_chat.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/UserFriendList/create_group.dart';
import 'package:stacked/stacked.dart';

import 'group_screen.dart';
import 'message_screen_for_user.dart';

class Group_Details extends StatefulWidget {

  int? id;
  String? username;
  int? userLength;
  List<UserModel>? groupUser;

  Group_Details({Key? key, this.id, this.username, this.userLength, this.groupUser}) : super(key: key);

  @override
  _Group_DetailsState createState() => _Group_DetailsState();
}

class _Group_DetailsState extends State<Group_Details> {

  bool _isSwitch =false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        //model.getAllUserForChat();
        model.getGroupList();
        model.matchingUsers();
        model.getListOfbars();
        model.initUserGrpPubNub();
        model.openGroupMenu = false;
        // model.selectedGroup = (model.getListGroup.);
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            context.unFocus();
            model.openGroupMenu = false;
            model.getListOfbars();
            model.notifyListeners();

          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:
                            AssetImage(ImageUtils.cosmos),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: 1.5.h,),
                          Row(
                            children: [
                              Text(
                                widget.username!,
                                style: TextStyle(
                                  fontFamily: FontUtils.modernistBold,
                                  color: Colors.black,
                                  fontSize: 2.5.t,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SvgPicture.asset(
                                  ImageUtils.groupLock , height: 5.i,),
                            ],
                          ),
                          SizedBox(height: 0.5.h,),
                          Row(
                            children: [
                              Text(
                                widget.userLength.toString() + " Members,",
                                style: TextStyle(
                                  fontFamily: FontUtils.modernistBold,
                                  color: Colors.green,
                                  fontSize: 1.9.t,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                "1 Online",
                                style: TextStyle(
                                  fontFamily: FontUtils.modernistBold,
                                  color: Colors.green,
                                  fontSize: 1.9.t,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.5.h,),
                          SvgPicture.asset(ImageUtils.addImages),
                          Text("Add", style: TextStyle(
                            fontFamily: FontUtils.modernistBold,
                            color: ColorUtils.red_color,
                            fontSize: 1.9.t,
                          ),)

                        ],
                      ),
                      Container()
                    ],
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Notifications",
                    style:
                    TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                    width: 350.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mute Notifications",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                        Switch(
                          value: _isSwitch,
                          onChanged: (value) {
                            setState(() {
                              _isSwitch = value;
                              print(_isSwitch);
                            });
                          },
                          activeTrackColor:ColorUtils.red_color,
                          activeColor: ColorUtils.red_color,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Media, Links and Docs",
                    style:
                    TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                    width: 350.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mute Notifications",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                        Switch(
                          value: _isSwitch,
                          onChanged: (value) {
                            setState(() {
                              _isSwitch = value;
                              print(_isSwitch);
                            });
                          },
                          activeTrackColor:ColorUtils.red_color,
                          activeColor: ColorUtils.red_color,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Group Participants",
                    style:
                    TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.userLength.toString() + " Participants",
                              style: TextStyle(
                                  color: ColorUtils.text_grey,
                                  fontFamily: FontUtils.modernistBold
                              ),),
                            SvgPicture.asset(ImageUtils.searchIcon)

                          ],
                        ),
                        SizedBox(height: 2.h,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 25.0,
                        //       backgroundImage:
                        //       AssetImage(ImageUtils.cosmos),
                        //       backgroundColor: Colors.transparent,
                        //     ),
                        //     Container(
                        //       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: ColorUtils.red_color),
                        //           borderRadius: BorderRadius.circular(5)
                        //       ),
                        //       child: Text("Group Admin",
                        //         style: TextStyle(
                        //             fontSize: 1.8.t,
                        //             fontFamily: FontUtils.modernistRegular,
                        //             color: ColorUtils.red_color
                        //         ),),
                        //     )
                        //
                        //   ],
                        // ),
                        ListView.separated(
                            padding:
                            EdgeInsets.only(top: 0.h),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
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
                                            NetworkImage(
                                                widget.groupUser![index].profile_picture??
                                                    "https://tse2.mm.bing.net/th?id=OIP.4gcGG1F0z6LjVlJjYWGGcgHaHa&pid=Api&P=0&w=164&h=164"),
                                          backgroundColor:
                                            Colors
                                                .transparent,
                                          ),
                                          SizedBox(width: 5.w,),
                                          Text(widget.groupUser![index].username!,
                                            style: TextStyle(
                                                        fontSize: 1.8.t,
                                                        fontFamily: FontUtils.modernistBold,
                                                        color: ColorUtils.black
                                                    ))
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 2.h,
                              );
                            },
                            itemCount: widget.groupUser!.length
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                    width: 350.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.red_color),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageUtils.exitGroup),
                        SizedBox(width: 3.w,),
                        Text("Exit Group",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
