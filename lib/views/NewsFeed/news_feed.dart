import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/NewsFeed/events.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:sauftrag/widgets/dialog_event.dart';
import 'package:sauftrag/widgets/my_side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List newsEvents = [
    {
      'image': ImageUtils.person_1,
      'barOwnerName': 'Nellie Mendez',
      'para':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': false,
      'comment': '68',
      'commentIon': ImageUtils.msgIcon,
      'likes': '53.5 k',
      'likesIcon': ImageUtils.matchedIcon,
    },
    {
      'image': ImageUtils.person_2,
      'barOwnerName': 'Ron Wright',
      'para':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': true,
      'commentIon': ImageUtils.msgIcon,
      'comment': '68',
      'likesIcon': ImageUtils.matchedIcon,
      'likes': '53.5 k',
    },
    {
      'image': ImageUtils.person_1,
      'barOwnerName': 'Nellie Mendez',
      'para':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': false,
      'commentIon': ImageUtils.msgIcon,
      'comment': '68',
      'likesIcon': ImageUtils.matchedIcon,
      'likes': '53.5 k',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        model.gettingComments();
        //model.userNewsFeed = true;
        // model.getEvent(context);
      },
      builder: (context, model, child) {
        return SideMenu(
          key: model.sideMenuKey,
          closeIcon: Icon(
            Icons.remove,
            color: Colors.transparent,
          ),
          type: SideMenuType.shrinkNSlide,
          background: ColorUtils.text_red,
          radius: BorderRadius.circular(30),
          menu: MySideMenu(),
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              context.unFocus();
              model.openGroupMenu = false;
              model.notifyListeners();
            },
            child: DefaultTabController(
              length: 2,
              child: SafeArea(
                top: false,
                bottom: false,
                child: GestureDetector(
                  onTap: () {
                    final _state = model.sideMenuKey.currentState;
                    if (_state!.isOpened)
                      _state.closeSideMenu(); // close side menu
                  },
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Container(
                      padding: EdgeInsets.only(
                          //horizontal: Dimensions.horizontalPadding,
                          top: Dimensions.verticalPadding),
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.homeTopMargin),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.horizontalPadding),
                              child: ElevatedButton(
                                onPressed: () {
                                  final _state = model.sideMenuKey.currentState;
                                  if (_state!.isOpened)
                                    _state.closeSideMenu(); // close side menu
                                  else
                                    _state.openSideMenu();
                                },
                                child: SvgPicture.asset(ImageUtils.menuIcon),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorUtils.white,
                                  onPrimary: ColorUtils.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.containerVerticalPadding),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: ColorUtils.divider, width: 1)),
                                  textStyle: TextStyle(
                                    color: ColorUtils.white,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          TabBar(
                            indicatorColor: ColorUtils.text_red,
                            labelColor: ColorUtils.text_red,
                            labelStyle: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 2.2.t,
                            ),
                            unselectedLabelColor: ColorUtils.icon_color,
                            tabs: [
                              Tab(
                                text: "NewsFeed",
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogEvent(
                                            title: "Add New Location",
                                            btnTxt: "Add Location",
                                            icon: ImageUtils.addLocationIcon);
                                      });
                                },
                                child: Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(ImageUtils.greyLock),
                                      SizedBox(
                                        width: 1.5.w,
                                      ),
                                      Text(
                                        "Events",
                                        style: TextStyle(
                                            color: ColorUtils.text_grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            onTap: (value) {
                              if (value == 1) {
                                model.getBarPost();
                                model.rating();
                                model.getEvent(context);
                              }
                            },
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // first tab bar view widget
                                NewsFeedScreen(),
                                Container()

                                // second tab bar viiew widget
                                // Events(),
                                // Container(
                                //   child:   showDialog(
                                //       context: context,
                                //       builder: (BuildContext context){
                                //         return DialogEvent(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                //       }
                                //   )
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) {
        model.getBarPost();
        model.rating();
        //model.getEvent(context);
      },
      builder: (context, model, child) {
        return model.isPost == true
            ? AllPageLoader()
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.5.h),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return UserNewsFeed(index: index);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                // height: SizeConfig.heightMultiplier * 2.5,
                                );
                          },
                          itemCount: model.posts.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
      disposeViewModel: false,
    );
  }
}

class UserNewsFeed extends StatefulWidget {
  int? index;
  int? id;

  UserNewsFeed({Key? key, this.index, this.id}) : super(key: key);

  @override
  _UserNewsFeedState createState() => _UserNewsFeedState();
}

class _UserNewsFeedState extends State<UserNewsFeed> {
  ExpandableController expandableController = ExpandableController();
  List comments = [];
  int comments_count = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) async {
        /*UserModel user =
          (await locator<PrefrencesViewModel>().getUser())!;
          var channel =
          model.pubnub!.channel(model.posts[widget.index!].id.toString());
          var chat = await channel.messages();
          await chat.fetch();
          comments_count = await chat.count();
          model.notifyListeners();*/
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 3.2.h),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.5.w,
                //vertical: 3.h
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtils.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  border:
                      Border.all(color: ColorUtils.text_grey.withOpacity(0.1)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.5.w, vertical: 1.h),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              model.selectedBar = model.listOfAllBars
                                  .where((element) =>
                                      element.id ==
                                      model.posts[widget.index!].user_id!.id)
                                  .first;
                              //print("yo");
                              model.navigateToBarProfile();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    model.posts[widget.index!].user_id!
                                        .profile_picture!,
                                    //newsEvents[index]["image"],
                                    width: 10.i,
                                    height: 10.i,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          model.posts[widget.index!].user_id!
                                              .bar_name!,
                                          //newsEvents[index]["barOwnerName"],
                                          style: TextStyle(
                                              fontFamily:
                                                  FontUtils.modernistBold,
                                              fontSize: 2.2.t,
                                              fontWeight: FontWeight.bold,
                                              color: ColorUtils.black),
                                        ),
                                        // if (model.posts[index].post_type! == '1')
                                        //   {
                                        //     Text("Abc")
                                        //   }
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      model.posts[widget.index!].post_location!,
                                      //newsEvents[index]["barOwnerName"],
                                      style: TextStyle(
                                          fontFamily:
                                              FontUtils.modernistRegular,
                                          fontSize: 1.7.t,
                                          //fontWeight: FontWeight.bold,
                                          color: ColorUtils.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  model.posts[widget.index!].post_content!,
                                  //newsEvents[index]["para"],
                                  style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.8.t,
                                      color: ColorUtils.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          if (model.posts[widget.index!].media != null &&
                              model.posts[widget.index!].media!.length > 0)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return DetailScreen(
                                    imageUrl: model
                                        .posts[widget.index!].media![0].media!,
                                  );
                                }));
                              },
                              child: Container(
                                  child: CachedNetworkImage(
                                imageUrl:
                                    model.posts[widget.index!].media![0].media!,
                                //width: 100.i,
                                height: 40.i,
                                fit: BoxFit.cover,
                              )),
                            ),
                          Divider(),

                          ///LIKE AND COMMENT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ExpandableTheme(
                                  data: ExpandableThemeData(
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.top,
                                      alignment: Alignment.centerLeft,
                                      iconPadding: EdgeInsets.zero,
                                      iconSize: 0,
                                      tapHeaderToExpand: false),
                                  child: ExpandablePanel(
                                      controller: expandableController,
                                      header: Container(
                                        padding: EdgeInsets.only(top: 0.7.h),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if(!model.isLikeNewsFeed)
                                                {
                                                  model.selectedPost = model.posts[widget.index!];
                                                  model.postLikeNewsFeed(widget.index!);
                                                }
                                                //expandableController == false ;
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageUtils.matchedIcon,
                                                    color:
                                                    model.posts[widget.index!].is_like != null ? model.posts[widget.index!].is_like! ? ColorUtils.text_red : ColorUtils.icon_color : ColorUtils.icon_color,
                                                  ),
                                                  SizedBox(
                                                    width: 1.5.w,
                                                  ),
                                                  //if(model.posts[widget.index!].likes != null)
                                                  Text(
                                                    model.posts[widget.index!].likes_count == null
                                                        ? 0.toString()
                                                        : model.posts[widget.index!].likes_count.toString(),
                                                    style: TextStyle(
                                                        fontFamily: FontUtils
                                                            .modernistRegular,
                                                        fontSize: 1.5.t,
                                                        color: model.posts[widget.index!].is_like != null ? model.posts[widget.index!].is_like! ? ColorUtils.text_red : ColorUtils.icon_color : ColorUtils.icon_color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 7.w),
                                            GestureDetector(
                                              onTap: () async {
                                                expandableController.toggle();
                                                model.selectedCommentId = model
                                                    .posts[widget.index!].id!;
                                                model.gettingComments();
                                                model.notifyListeners();
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageUtils.msgIcon,
                                                    color:
                                                        ColorUtils.icon_color,
                                                  ),
                                                  SizedBox(
                                                    width: 1.5.w,
                                                  ),
                                                  Text(
                                                    //model.userComments!.isEmpty ? 0.toString() : model.userComments!.length.toString(),
                                                    model.posts[widget.index!]
                                                        .comments_count
                                                        .toString(),
                                                    //comments_count.toString(),
                                                    style: TextStyle(
                                                        fontFamily: FontUtils
                                                            .modernistRegular,
                                                        fontSize: 1.5.t,
                                                        color: ColorUtils
                                                            .icon_color),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      collapsed: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black),
                                        child: Container(),
                                      ),
                                      expanded:
                                          // expandableController == true ?
                                          Column(
                                        children: [
                                          Divider(),
                                          // GestureDetector(
                                          //   onTap: (){
                                          //     model.navigateToAlCommentsUserScreen();
                                          //   },
                                          //   child: Align(
                                          //     alignment:  Alignment.topRight,
                                          //     child: Padding(
                                          //       padding: EdgeInsets.only(top: 0.0, left: 1.w),
                                          //       child: Text("See All",
                                          //         style: TextStyle(
                                          //           color: ColorUtils.red_color,
                                          //           fontFamily: FontUtils
                                          //               .modernistRegular,
                                          //           fontSize: 1.7.t,
                                          //           decoration: TextDecoration
                                          //               .underline,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Container(
                                            //height: 10.h,
                                            // margin: EdgeInsets.only(top: 1.5.h),
                                            width: double.maxFinite,
                                            //height: 40.h,
                                            child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              controller: model.chatScroll,
                                              itemBuilder: (context, index) {
                                                return Align(
                                                  //alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Image.network(
                                                          model
                                                              .userComments![
                                                                  index]
                                                              .user_id!
                                                              .profile_picture!,
                                                          width: 10.i,
                                                          height: 10.i,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(width: 3.w),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            model
                                                                .userComments![
                                                                    index]
                                                                .user_id!
                                                                .username!,
                                                            //model.userModel!.username!,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontUtils
                                                                        .modernistBold,
                                                                fontSize: 1.8.t,
                                                                color: ColorUtils
                                                                    .text_dark),
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.7,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                                color: ColorUtils
                                                                    .icon_color
                                                                    .withOpacity(
                                                                        0.2)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2.w,
                                                                    vertical:
                                                                        1.h),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 3.w,
                                                                    right: 3.w,
                                                                  ),
                                                                  child: Text(
                                                                    model
                                                                        .userComments![
                                                                            index]
                                                                        .text!,
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
                                                        ],
                                                      ),
                                                      Align(
                                                        //alignment:  Alignment.bottomRight,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 0.0,
                                                                  left: 0.w),
                                                          child: Text(
                                                            model
                                                                .userComments![
                                                                    index]
                                                                .created_at!
                                                                .substring(
                                                                    11, 16),
                                                            //comments[index]["time"].toString().substring(11,16),
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
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                height: 3.h,
                                              ),
                                              itemCount: model.userComments !=
                                                      null
                                                  ? model.userComments!.length
                                                  : 0,
                                              //comments.length>2?2:comments.length
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                  model.userModel!
                                                      .profile_picture!,
                                                  width: 10.i,
                                                  height: 10.i,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3.w),
                                                  // margin: EdgeInsets.only(top: 1.5.h),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: ColorUtils
                                                          .icon_color
                                                          .withOpacity(0.2)),
                                                  // padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),

                                                  width: double.maxFinite,
                                                  //height: 40.h,
                                                  child: TextField(
                                                    onTap: () {},
                                                    onChanged: (value) {
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
                                              model.postCommentController.text
                                                          .length <=
                                                      0
                                                  ? Container(
                                                      //margin: EdgeInsets.only(bottom: 2.2.h),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ColorUtils
                                                            .text_grey,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: SvgPicture.asset(
                                                          ImageUtils.sendIcon1,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        /*NewBarModel barUser =
                                                        (await locator<PrefrencesViewModel>()
                                                            .getBarUser())!;
                                                        UserModel user =
                                                        (await locator<PrefrencesViewModel>().getUser())!;
                                                        // model.chat();
                                                        var comment = {
                                                          "content": model.postCommentController.text,
                                                          "userID": user.id!.toString(),
                                                          "time":DateTime.now().toString()
                                                        };
                                                        await model.pubnub!.publish(model
                                                            .posts[widget.index!]
                                                            .id.toString(), comment);
                                                        comments.add(comment);
                                                        model.postCommentController.clear();
                                                        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                                                          model.scrollDown();
                                                        });
                                                        model.notifyListeners();*/
                                                        await model
                                                            .postingComments();
                                                        model
                                                            .getCommentNewsFeed(
                                                                widget.index!);
                                                        model
                                                            .postCommentController
                                                            .clear();
                                                        expandableController
                                                            .toggle();
                                                        model.gettingComments();
                                                      },
                                                      child: Container(
                                                        //margin: EdgeInsets.only(bottom: 2.2.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorUtils
                                                              .text_red,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            ImageUtils
                                                                .sendIcon1,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ) /*: Container(),*/
                                      ),
                                ),
                              )
                            ],
                          )
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
      disposeViewModel: false,
    );
  }
}

class DetailScreen extends StatefulWidget {
  String? imageUrl;

  DetailScreen({this.imageUrl, Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl!,
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 1,
            fit: BoxFit.fitWidth,
            // placeholder: new CircularProgressIndicator(),
            // errorWidget: new Icon(Icons.error),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
