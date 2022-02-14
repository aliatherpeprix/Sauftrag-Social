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
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 26.5,
                                        backgroundImage: NetworkImage(model
                                            .userForChats[index].profile_picture
                                            .toString()),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        model.userForChats[index].username
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.text_dark),
                                      ),
                                    ],
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
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
                                              .userForChats[index]
                                              .profile_picture;
                                          model.groupMap["name"] = model
                                              .userForChats[index].username;
                                          //print(groupMap);
                                          model.groupList.add({
                                            "image": model.groupMap["image"],
                                            "name": model.groupMap["name"]
                                          });
                                          print(model.groupList);
                                          //containerBorder = ColorUtils.greenColor;
                                        }
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 3.h,
                              );
                            },
                            itemCount: model.userForChats.length),
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
