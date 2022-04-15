import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:stacked/stacked.dart';

class AllCommentsUsers extends StatefulWidget {
  const AllCommentsUsers({Key? key}) : super(key: key);

  @override
  _AllCommentsUsersState createState() => _AllCommentsUsersState();
}

class _AllCommentsUsersState extends State<AllCommentsUsers> {

  List comments = [];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: ()=>locator<MainViewModel>(),
      onModelReady: (model) async {
        // NewBarModel barUser =
        // (await locator<PrefrencesViewModel>().getBarUser())!;
        // var channel =
        // model.pubnub!.channel(model.posts.id.toString());
        // var chat = await channel.messages();
        // var   data = await chat.count();
      },
      builder: (context, model, child) {
        return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: Column(
                  children: [
                    Container(
                      //height: 10.h,
                      // margin: EdgeInsets.only(top: 1.5.h),

                      width: double.maxFinite,
                      //height: 40.h,
                      child: ListView.separated(
                        //padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          controller: model.chatScroll,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  ClipRRect
                                    (
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(model.barModel!.profile_picture!,
                                      width: 10.i,
                                      height: 10.i,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.7,
                                    decoration: BoxDecoration(
                                        shape: BoxShape
                                            .rectangle,
                                        borderRadius:
                                        BorderRadius
                                            .all(Radius
                                            .circular(
                                            10)),
                                        color:
                                        ColorUtils.icon_color.withOpacity(0.2)),
                                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 3.w,
                                        //       vertical: 1.5.h),
                                        //   child: Image.asset(
                                        //     ImageUtils.drinkImage,
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 3.w, right: 3.w,),
                                          child: Text(
                                            comments[index]["content"]
                                                .toString(),
                                            style: TextStyle(
                                              //fontFamily: FontUtils.avertaDemoRegular,
                                                fontSize: 1.8.t,
                                                color: ColorUtils.text_dark),
                                          ),
                                        ),
                                        //SizedBox(height: 1.h,),

                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment:  Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15.0, left: 1.w),
                                      child: Text(
                                        comments[index]["time"].toString().substring(11,16),
                                        style: TextStyle(
                                          //fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.5.t,
                                            color: ColorUtils
                                                .icon_color),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 1.h,
                          ),
                          itemCount: comments.length),
                    ),
                    SizedBox(height: 1.5.h,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect
                          (
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(model.barModel!.profile_picture!,
                            width: 10.i,
                            height: 10.i,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            // margin: EdgeInsets.only(top: 1.5.h),
                            decoration:
                            BoxDecoration(
                                shape: BoxShape
                                    .rectangle,
                                borderRadius:
                                BorderRadius
                                    .all(Radius
                                    .circular(
                                    10)),
                                color:
                                ColorUtils.icon_color.withOpacity(0.2)),
                            // padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),

                            width: double.maxFinite,
                            //height: 40.h,
                            child: TextField(
                              onTap: () {},
                              onChanged: (value){
                                model.notifyListeners();
                              },
                              // enabled: true,
                              //readOnly: true,
                              //focusNode: model.searchFocus,
                              controller: model
                                  .postCommentController,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText:
                                "Type your message...",
                                hintStyle: TextStyle(
                                  //fontFamily: FontUtils.proximaNovaRegular,
                                  //color: ColorUtils.silverColor,
                                  fontSize: SizeConfig
                                      .textMultiplier *
                                      1.8,
                                ),
                                border: InputBorder.none,
                                // isDense: true,
                                contentPadding:
                                EdgeInsets.symmetric(
                                    vertical: SizeConfig
                                        .heightMultiplier *
                                        2),
                              ),
                              keyboardType:
                              TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        model.postCommentController.text.length <=0 ?
                        Container(
                          //margin: EdgeInsets.only(bottom: 2.2.h),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtils.text_grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              ImageUtils.sendIcon1,
                              color: Colors.white,
                            ),
                          ),
                        ) :
                        InkWell(
                          onTap: () async {
                            // NewBarModel barUser =
                            // (await locator<PrefrencesViewModel>()
                            //     .getBarUser())!;
                            // UserModel user =
                            // (await locator<PrefrencesViewModel>().getUser())!;
                            // // model.chat();
                            // var comment = {
                            //   "content": model.postCommentController.text,
                            //   "userID": barUser.id!.toString(),
                            //   "time":DateTime.now().toString()
                            // };
                            // await model.pubnub!.publish(model
                            //     .posts[widget.]
                            //     .id.toString(), comment);
                            // comments.add(comment);
                            // model.postCommentController.clear();
                            // SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                            //   model.scrollDown();
                            // });
                            // model.notifyListeners();
                          },
                          child: Container(
                            //margin: EdgeInsets.only(bottom: 2.2.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.text_red,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                ImageUtils.sendIcon1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
        );

      },
      disposeViewModel: false,);
  }
}
