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
import 'package:sauftrag/views/UserFriendList/chat_input.dart';
import 'package:sauftrag/views/UserFriendList/chat_list_widget.dart';
import 'package:stacked/stacked.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalPadding,
                  vertical: Dimensions.verticalPadding),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.topMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageUtils.backArrow),
                          SizedBox(width: 5.w,),
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                    AssetImage(ImageUtils.messagePerson1),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ],
                              ),
                              SizedBox(width: 3.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Athalia Putri",
                                    style: TextStyle(
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 1.9.t,
                                        color: ColorUtils.text_dark
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text("Active",
                                    style: TextStyle(
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 1.5.t,
                                        color: ColorUtils.activeColor
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SvgPicture.asset(ImageUtils.chatMenuIcon),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Expanded(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        ChatListWidget(),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        ChatInputField(),
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
