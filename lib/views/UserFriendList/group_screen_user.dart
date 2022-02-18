import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:stacked/stacked.dart';

class GroupScreenUser extends StatefulWidget {
  const GroupScreenUser({Key? key}) : super(key: key);

  @override
  _GroupScreenUserState createState() => _GroupScreenUserState();
}

class _GroupScreenUserState extends State<GroupScreenUser> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => locator<MainViewModel>(),
        disposeViewModel: false,
        onModelReady: (model) async {
          NewBarModel barUser =
              (await locator<PrefrencesViewModel>().getBarUser())!;
          UserModel user = (await locator<PrefrencesViewModel>().getUser())!;
          var pubnub = PubNub(
              defaultKeyset: Keyset(
                  subscribeKey: 'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4',
                  publishKey: 'pub-c-1f404751-6cfb-44a8-bfea-4ab9102975ac',
                  uuid: UUID("Cosmos")));
          // Subscribe to a channel
          var subscription = pubnub.subscribe(channels: {"Cosmos"});

          var channel = pubnub.channel("Cosmos");
          var chat = await channel.messages();
          var data = await chat.count();
          await chat.fetch().whenComplete(() {
            model.chats.clear();
            print(chat.messages.length);
            for (var data in chat.messages) {
              model.chats.add(data.content);
            }
            model.notifyListeners();
          });

          subscription.messages.listen((message) async {
            model.chats.add(message.content);
            model.notifyListeners();
          });
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
                      body: GestureDetector(
                        onTap: () {
                          model.navigateToGroupScreen();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            //margin: EdgeInsets.only(top: 3.h),
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: 40.h,
                                //   child: ListView.separated(
                                //       itemBuilder: (context, index) {
                                //         return ListTile(
                                //           leading: CircleAvatar(
                                //             backgroundColor: Colors.transparent,
                                //             backgroundImage:
                                //                 AssetImage(ImageUtils.cosmos),
                                //           ),
                                //         );
                                //       },
                                //       separatorBuilder: (context, index) =>
                                //           SizedBox(
                                //             height: 3.h,
                                //           ),
                                //       itemCount: 1),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage:
                                              AssetImage(ImageUtils.cosmos),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cosmos",
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontUtils.modernistBold,
                                                  fontSize: 1.9.t,
                                                  color: ColorUtils.text_dark),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                "Did you see the last episode of cosmos?",
                                                style: TextStyle(
                                                    fontFamily: FontUtils
                                                        .modernistRegular,
                                                    fontSize: 1.8.t,
                                                    color: ColorUtils
                                                        .lightTextColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                            fontFamily:
                                                FontUtils.modernistRegular,
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
                            )),
                      ))));
        });
  }
}
