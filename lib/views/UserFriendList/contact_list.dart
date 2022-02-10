import 'package:flutter/cupertino.dart';
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
import 'package:stacked/stacked.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
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
        model.getContacts();
        model.groupList.clear();
        model.selected = List<bool>.filled(model.contactChecked.length, false);
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
                    //model.navigateToGroupDetails();
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
                            "Invite Friends",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // CircleAvatar(
                                  //   radius: 26.5,
                                  //   backgroundImage: AssetImage(
                                  //       model.contactChecked[index]["image"]),
                                  //   backgroundColor: Colors.transparent,
                                  // ),
                                  Text(
                                    model.contactBook[index].username!,
                                    style: TextStyle(
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 1.8.t,
                                        color: ColorUtils.text_dark),
                                  ),
                                  if (model.contactBook[index].exist!)
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                          ImageUtils.cancelIcon),
                                      //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      color: ColorUtils.white,
                                      highlightColor: ColorUtils.white,
                                    ),
                                  if (!model.contactBook[index].exist!)
                                    Text("Invite",
                                      style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 1.6.t,
                                          color: ColorUtils.red_color
                                      ),
                                    )
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: SvgPicture.asset(
                                    //       ImageUtils.logo),
                                    //   //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                    //   padding: EdgeInsets.zero,
                                    //   constraints: BoxConstraints(),
                                    //   color: ColorUtils.white,
                                    //   highlightColor: ColorUtils.white,
                                    // ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 3.h,
                              );
                            },
                            itemCount: model.contactBook.length),
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
