import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/views/Drawer/follower_profile.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) {
        model.followers();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(height: Dimensions.topMargin),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding),
                  child: Row(
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
                        "Followers",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 3.t,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalPadding,
                  ),
                  //width: 200.0,
                  // margin: EdgeInsets.only(
                  //     left: SizeConfig.widthMultiplier * 4.5,
                  //     right: SizeConfig.widthMultiplier * 5,
                  //     top: SizeConfig.heightMultiplier * 3),
                  decoration: BoxDecoration(
                    color: ColorUtils.searchFieldColor,
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
                              //controller: model.friendListSearchController,
                              decoration: InputDecoration(
                                hintText: "People, groups & messages",
                                hintStyle: TextStyle(
                                  //fontFamily: FontUtils.proximaNovaRegular,
                                  color: ColorUtils.icon_color,
                                  fontSize: SizeConfig.textMultiplier * 1.9,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.heightMultiplier * 2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       model.followers();
                //     },
                //     child: Text("data")),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FollowerProfile(
                                          username: model.follower[index]
                                              .follow_by!.username,
                                          profilePicture: model.follower[index]
                                              .follow_by!.profile_picture,
                                          address: model.follower[index]
                                              .follow_by!.address,
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: ColorUtils.black.withOpacity(0.1),
                              //     spreadRadius: 0,
                              //     blurRadius: 10,
                              //     offset: Offset(0, 5), // changes position of shadow
                              //   ),
                              // ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              // border: Border.all(color: ColorUtils.text_red),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        model.follower[index].follow_by!
                                            .profile_picture
                                            .toString(),
                                        width: 15.i,
                                        height: 15.i,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      model.follower[index].follow_by!.username
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.2.t,
                                          color: ColorUtils.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Followers"),
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorUtils.text_red,
                                      onPrimary: ColorUtils.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.2.h, horizontal: 4.w),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.roundCorner),
                                          side: BorderSide(
                                              color: ColorUtils.text_red,
                                              width: 1)),
                                      textStyle: TextStyle(
                                        //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.t,
                                        //height: 0
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
                      );
                    },
                    itemCount: model.follower.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
