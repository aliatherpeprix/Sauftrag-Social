// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sauftrag/app/locator.dart';
// import 'package:sauftrag/utils/color_utils.dart';
// import 'package:sauftrag/utils/dimensions.dart';
// import 'package:sauftrag/utils/extensions.dart';
// import 'package:sauftrag/utils/font_utils.dart';
// import 'package:sauftrag/utils/image_utils.dart';
// import 'package:sauftrag/utils/size_config.dart';
// import 'package:sauftrag/viewModels/main_view_model.dart';
// import 'package:sauftrag/widgets/back_arrow_with_container.dart';
// import 'package:stacked/stacked.dart';
//
// class SelectIndividualChat extends StatefulWidget {
//   const SelectIndividualChat({Key? key}) : super(key: key);
//
//   @override
//   _SelectIndividualChatState createState() => _SelectIndividualChatState();
// }
//
// class _SelectIndividualChatState extends State<SelectIndividualChat> {
//   @override
//   Widget build(BuildContext context) {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return ColorUtils.text_red;
//       }
//       return ColorUtils.text_red;
//     }
//     return ViewModelBuilder<MainViewModel>.reactive(
//       onModelReady: (model){
//         model.groupList.clear();
//         model.selected = List<bool>.filled(model.contactChecked.length, false);
//       },
//       builder: (context, model, child) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: SafeArea(
//             top: false,
//             bottom: false,
//             child: Scaffold(
//                 floatingActionButton: GestureDetector(
//                   onTap: (){
//                     //model.groupList.add(value);
//                     //model.navigationService.navigateTo(to: ServiceCategory());
//                     model.navigateToGroupDetails();
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 3.h,right: 2.w),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: ColorUtils.text_red,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: SvgPicture.asset(ImageUtils.floatingForwardIcon),
//                     ),
//                   ),
//                 ),
//
//                 backgroundColor: ColorUtils.white,
//                 body: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Dimensions.horizontalPadding,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: Dimensions.topMargin),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
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
//                           SizedBox(width: 2.w),
//                           Text(
//                             "Create Group",
//                             style: TextStyle(
//                               color: ColorUtils.black,
//                               fontFamily: FontUtils.modernistBold,
//                               fontSize: 3.t,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 4.h,
//                       ),
//                       Container(
//                         //width: 200.0,
//                         // margin: EdgeInsets.only(
//                         //     left: SizeConfig.widthMultiplier * 4.5,
//                         //     right: SizeConfig.widthMultiplier * 5,
//                         //     top: SizeConfig.heightMultiplier * 3),
//                         decoration: BoxDecoration(
//                           color: ColorUtils.textFieldBg,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15.0),
//                           ),
//                         ),
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                             horizontal: SizeConfig.widthMultiplier * 3,
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 child: SvgPicture.asset(
//                                   ImageUtils.searchIcon,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   margin: EdgeInsets.only(
//                                       left: SizeConfig.widthMultiplier * 3,
//                                       right: SizeConfig.widthMultiplier * 3),
//                                   child: TextField(
//                                     onTap: () {},
//                                     enabled: true,
//                                     //readOnly: true,
//                                     //focusNode: model.searchFocus,
//                                     controller:
//                                     model.friendListSearchController,
//                                     decoration: InputDecoration(
//                                       hintText: "Search",
//                                       hintStyle: TextStyle(
//                                         //fontFamily: FontUtils.proximaNovaRegular,
//                                         color: ColorUtils.icon_color,
//                                         fontSize:
//                                         SizeConfig.textMultiplier * 1.9,
//                                       ),
//                                       border: InputBorder.none,
//                                       isDense: true,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical:
//                                           SizeConfig.heightMultiplier *
//                                               2),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 3.h,),
//
//                       Expanded(
//                         child: ListView.separated(
//                             padding: EdgeInsets.zero,
//                             physics: BouncingScrollPhysics(),
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: (){
//                                   model.navigateToMessageScreen();
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 26.5,
//                                           backgroundImage: AssetImage(
//                                               model.userForChats[index].profile_picture.toString()),
//                                           backgroundColor: Colors.transparent,
//                                         ),
//                                         SizedBox(width: 3.w,),
//                                         Text(
//                                           model.userForChats[index].username.toString(),
//                                           style: TextStyle(
//                                               fontFamily: FontUtils.modernistBold,
//                                               fontSize: 1.8.t,
//                                               color: ColorUtils.text_dark
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Checkbox(
//                                       checkColor: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(4)
//                                       ),
//
//                                       fillColor: MaterialStateProperty.resolveWith(getColor),
//                                       value: model.selected![index],
//                                       onChanged: (val) {
//                                         setState(() {
//                                           model.selected![index] = val!;
//                                           model.selectedValue = val;
//                                           //model.groupMap["image"] =
//                                           print(model.selectedValue);
//                                           if(model.selectedValue == true){
//                                             model.currentIndex = index;
//                                             model.groupMap["image"] = model.userForChats[index].profile_picture;
//                                             model.groupMap["name"] = model.userForChats[index].username;
//                                             //print(groupMap);
//                                             model.groupList.add({
//                                               "image": model.groupMap["image"],
//                                               "name" : model.groupMap["name"]
//                                             });
//                                             print(model.groupList);
//                                             //containerBorder = ColorUtils.greenColor;
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) {
//                               return SizedBox(
//                                 height: 3.h,
//                               );
//                             },
//                             itemCount: model.userForChats.length),
//                       ),
//                     ],
//                   ),
//                 )),
//           ),
//         );
//       },
//       viewModelBuilder: () => locator<MainViewModel>(),
//       disposeViewModel: false,
//     );
//   }
// }

///Old Code
///

import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class UserGroupChat extends StatefulWidget {
  const UserGroupChat({Key? key}) : super(key: key);

  @override
  _UserGroupChatState createState() => _UserGroupChatState();
}

class _UserGroupChatState extends State<UserGroupChat> {
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
        //model.getBarsFollowerList();
        //model.getBarsFollowerForChat();
        //model.getAllUserForChat();
        model.selected = List<bool>.filled(model.matchedUser.toString().length, false);
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
                floatingActionButton: GestureDetector(
                  onTap: () {
                    //model.groupList.add(value);
                    //model.navigationService.navigateTo(to: ServiceCategory());
                    model.navigateToGroupDetails();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 3.h, right: 2.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.text_red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(ImageUtils.floatingForwardIcon),
                    ),
                  ),
                ),
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
                            "Create Group",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.containerVerticalPadding,
                                horizontal:
                                Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.roundCorner)),
                                border:
                                Border.all(color: ColorUtils.divider)),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageUtils.relationIcon),
                                SizedBox(width: 4.w),
                                Expanded(
                                    child: DropdownButton<String>(
                                      value: model.groupTypeValueStr,
                                      items: model.groupTypeList
                                          .asMap()
                                          .values
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 1.9.t,
                                              fontFamily:
                                              FontUtils.modernistRegular,
                                              color: ColorUtils.red_color,
                                              //height: 1.8
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (data) {
                                        setState(() {
                                          model.groupTypeValueStr = data as String;
                                          model.groupTypeValue = model
                                              .groupTypeMap[model.groupTypeValueStr]
                                          as int;
                                        });
                                      },
                                      hint: Text(
                                        "Select an option",
                                        style: TextStyle(
                                          fontSize: 1.8.t,
                                          fontFamily: FontUtils.modernistRegular,
                                          color: ColorUtils.text_grey,
                                        ),
                                      ),
                                      isExpanded: true,
                                      underline: Container(),
                                      icon: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: ColorUtils.black,
                                          )),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Type",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_grey,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      if (model.groupTypeValue==2)Container(
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
                      if (model.groupTypeValue==2)Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  model.navigateToMessageScreen();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
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
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                            model
                                                .matchedUsers[
                                            index]
                                                .username
                                                .toString(),
                                          style: TextStyle(
                                              fontFamily:
                                              FontUtils.modernistBold,
                                              fontSize: 1.8.t,
                                              color: ColorUtils.text_dark),
                                        ),
                                      ],
                                    ),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4)),
                                      fillColor:
                                      MaterialStateProperty.resolveWith(
                                          getColor),
                                      value: model.selected![index],
                                      onChanged: (val) {
                                        setState(() {
                                          model.selected![index] = val!;
                                          model.selectedValue = val;
                                          //model.groupMap["image"] =
                                          print(model.selectedValue);
                                          if (model.selectedValue == true) {
                                            model.currentIndex = index;
                                            model.groupMap["image"] = model
                                                .matchedUsers[index]
                                                .profile_picture;
                                            model.groupMap["name"] = model
                                                .matchedUsers[index].username;
                                            //print(groupMap);
                                            model.groupList.add({
                                              'id':
                                              model.matchedUsers[index].id,
                                              "image": model.matchedUsers[index].profile_picture,
                                              "name": model
                                                  .matchedUsers[index].username
                                            });
                                            print(model.groupList);
                                            //containerBorder = ColorUtils.greenColor;
                                          }
                                        });
                                      },
                                    ),
                                    // Checkbox(
                                    //   checkColor: Colors.white,
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(4)),
                                    //   fillColor:
                                    //       MaterialStateProperty.resolveWith(
                                    //           getColor),
                                    //   value: false,
                                    //   onChanged: (val) {
                                    //     setState(() {
                                    //       model.selected![index] = val!;
                                    //       model.selectedValue = val;
                                    //       //model.groupMap["image"] =
                                    //       print(model.selectedValue);
                                    //       if (model.selectedValue == true) {
                                    //         model.currentIndex = index;
                                    //         model.userForChats[index]
                                    //             .profile_picture;
                                    //         model.userForChats[index].username;
                                    //         //print(groupMap);
                                    //         model.groupList.add({
                                    //           'id':
                                    //               model.userForChats[index].id,
                                    //           "image": model.userForChats[index]
                                    //               .profile_picture,
                                    //           "name": model
                                    //               .userForChats[index].username
                                    //         });
                                    //         print(model.groupList);
                                    //         //containerBorder = ColorUtils.greenColor;
                                    //       }
                                    //     });
                                    //   },
                                    // ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 3.h,
                              );
                            },
                            itemCount: model.matchedUsers.length),
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