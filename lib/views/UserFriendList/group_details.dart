import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({Key? key}) : super(key: key);

  @override
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding,
                      vertical: Dimensions.verticalPadding),
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
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "Group Name",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.textFieldBg,
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SvgPicture.asset(ImageUtils.photoCamera),
                              ),
                          ),
                          SizedBox(width: 2.5.w,),
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
                                  horizontal: SizeConfig.widthMultiplier * 3,
                                ),
                                child: Row(
                                  children: [
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
                                            hintText: "Group Name",
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
                                    SvgPicture.asset(ImageUtils.smileyIcon),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 25.w,
                            height: 5.5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: ColorUtils.text_red),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageUtils.lockIcon),
                                SizedBox(width: 2.w,),
                                Text("Private",
                                  style: TextStyle(
                                    color: ColorUtils.text_red,
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
