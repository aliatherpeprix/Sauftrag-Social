import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/extensions.dart';

import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/font_utils.dart';
import '../../../utils/image_utils.dart';
import '../../../viewModels/main_view_model.dart';
import '../../../widgets/exit_group_bar.dart';

import '../../../widgets/exit_group_dialog.dart';

class BarGroupDetailScreen extends StatefulWidget {

  int? id;
  String? username;
  User? originator;
  int? userLength;
  String? groupImg;
  List<User>? groupUser;

  BarGroupDetailScreen({Key? key, this.id,this.username,this.originator,this.userLength,this.groupImg, this.groupUser}) : super(key: key);

  @override
  _BarGroupDetailScreenState createState() => _BarGroupDetailScreenState();
}

class _BarGroupDetailScreenState extends State<BarGroupDetailScreen> {

  bool _isSwitch =false;

  List images = [
    {
      'image': ImageUtils.mess1,
    },
    {
      'image': ImageUtils.mess2,
    },
    {
      'image': ImageUtils.mess3,
    },
    {
      'image': ImageUtils.mess4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        //model.getAllUserForChat();
        model.getGroupList();
        //model.matchingUsers();
        //model.getListOfbars();
        //model.initUserGrpPubNub();
        model.openGroupMenu = false;
        // model.selectedGroup = (model.getListGroup.);
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            //context.unFocus();
            model.openGroupMenu = false;
            //model.getListOfbars();
            model.notifyListeners();

          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalPadding,vertical: Dimensions.verticalPadding
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                            Container(
                              height: 9.5.h,
                              width: 20.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: widget.groupImg == null ?
                                SvgPicture.asset(ImageUtils.profile) :
                                Image.network(widget.groupImg!,
                                  fit: BoxFit.fill,
                                ),
                              ),
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
                            GestureDetector(
                              onTap: (){
                                model.navigateToAddParticipantsScreen();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(ImageUtils.addImages),
                                    Text("Add", style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      color: ColorUtils.red_color,
                                      fontSize: 1.9.t,
                                    ),)

                                  ],
                                ),
                              ),
                            )
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
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: 1.3.h),

                      decoration: BoxDecoration(
                          border: Border.all(color: ColorUtils.red_color),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: images.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(images[index]['image'],
                                    width: 15.i,
                                    height: 15.i,
                                    fit: BoxFit.cover,

                                  ),
                                );
                              },
                            ),
                          )
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 6.7.h,
                                      width: 14.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: widget.originator!.profile_picture == null ?
                                        SvgPicture.asset(ImageUtils.profile) :
                                        Image.network(widget.originator!.profile_picture!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w,),
                                    Text(widget.originator!.username!,  style: TextStyle(
                                        fontSize: 1.8.t,
                                        fontFamily: FontUtils.modernistBold,
                                        color: ColorUtils.black
                                    ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: ColorUtils.red_color),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("Group Admin",
                                    style: TextStyle(
                                        fontSize: 1.8.t,
                                        fontFamily: FontUtils.modernistRegular,
                                        color: ColorUtils.red_color
                                    ),),
                                )

                              ],
                            ),
                            SizedBox(height: 1.5.h,),
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
                                                    widget.groupUser![index].profile_picture!),
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
                          GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return ExitGroupBar(id: widget.id!,title: "Add New Location",
                                          btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                    }
                                );
                              },
                              child:
                              Text("Exit Group",
                                style: TextStyle(
                                    color: ColorUtils.red_color,
                                    fontFamily: FontUtils.modernistBold),)),

                        ],
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
