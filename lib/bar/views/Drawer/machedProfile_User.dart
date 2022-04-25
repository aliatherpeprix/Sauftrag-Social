import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:stacked/stacked.dart';

class MatchedProfileUser extends StatefulWidget {

  MatchedProfileUser({Key? key,})
      : super(key: key);

  @override
  _MatchedProfileUserState createState() => _MatchedProfileUserState();
}

class _MatchedProfileUserState extends State<MatchedProfileUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // List followerImg = [
  //   {'image': ImageUtils.followerImg1},
  //   {'image': ImageUtils.followerImg2},
  //   {'image': ImageUtils.followerImg3},
  //   {'image': ImageUtils.followerImg4},
  //   {'image': ImageUtils.followerImg5},
  // ];
  //
  // List friendsList = [
  //   {'image': ImageUtils.friends1, 'title': 'Dominic Gray'},
  //   {'image': ImageUtils.friends2, 'title': 'Glen Romero'},
  //   {'image': ImageUtils.friends3, 'title': 'Raul Pope'},
  //   {'image': ImageUtils.friends4, 'title': 'Lance Hernandez'},
  // ];

  List mutualFriendList = [
    {'image': ImageUtils.mutualfrnd1, 'title': 'Tony Walton'},
    {'image': ImageUtils.mutualfrnd2, 'title': 'Mario Reyes'},
    {'image': ImageUtils.mutualfrnd3, 'title': 'Jana Romero'},
    {'image': ImageUtils.mutualfrnd4, 'title': 'Patrick Oliver'},
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) async {

        model.acceptMatched(context);
        model.drinkList =
        await Addfavorites().GetFavoritesDrink();
        model.clubList =
        await Addfavorites().GetFavoritesClub();
        model.vacationList =
        await Addfavorites().GetFavoritesPartyVacation();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        var getMatchedUserData = model.acceptMatchedtModel;
        return model.isLoading == true ? AllPageLoader() :
          SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                key: _scaffoldKey,
                body: Container(
                  padding: EdgeInsets.only(top: Dimensions.homeTopMargin),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        leading: GestureDetector(
                          onTap: () {
                            model.navigateBack();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 1.7.w, vertical: 1.1.h),
                            padding: EdgeInsets.all(13),
                            //height: 10.h,
                            decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: SvgPicture.asset(ImageUtils.backArrow),
                            height: 5.i,
                          ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: ColorUtils.transparent,
                              ))
                        ],
                        floating: true,
                        pinned: false,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        expandedHeight: 280,
                        flexibleSpace: FlexibleSpaceBar(
                          background:
                          Image.network(
                            model.matchedUser!.profile_picture!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.verticalPadding,
                                horizontal: Dimensions.horizontalPadding),
                            decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  //color of shadow
                                  spreadRadius: 5,
                                  //spread radius
                                  blurRadius: 5,
                                  // blur radius
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.matchedUser!.username!,
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.5.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  // SizedBox(height: 1.h),
                                  // Text(
                                  //   "Professional Dancer",
                                  //   style: TextStyle(
                                  //     fontFamily: FontUtils.modernistRegular,
                                  //     fontSize: 1.8.t,
                                  //     color: ColorUtils.black,
                                  //   ),
                                  // ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(ImageUtils.location_icon),
                                      SizedBox(width: 2.w),
                                      Flexible(
                                        child: Text(
                                          model.matchedUser!.address!,
                                          style: TextStyle(
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    "About",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.3.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna. Donec bibendum velit vitae lacus rutrum mollis tempus vitae leo. Ut commodo, elit sit amet pretium dapibus, arcu orci tempor massa, nec condimentum turpis nisi eu urna. Morbi non gravida ipsum, quis cursus turpis. Suspendisse sit amet est nunc. ",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.8.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),

                                  //Interest
                                  Text(
                                    "Interest",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.3.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),

                                  //Favorite Drink
                                  Text(
                                    "Favorite Alcoholic Drink",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Wrap(
                                    spacing: 2.5.w,
                                    runSpacing: 1.5.h,
                                    direction: Axis.horizontal,
                                    children: model.matchedUser!.favorite_alcohol_drinks!
                                        .map((element) => ElevatedButton(
                                      onPressed: () {
                                        // if (model.selectedInterestList
                                        //     .contains(model.interestList
                                        //         .indexOf(element))) {
                                        //   model.selectedInterestList.remove(
                                        //       model.interestList
                                        //           .indexOf(element));
                                        // } else {
                                        //   //model.selectedInterestList.add(model.interestList.indexOf(element));
                                        // }
                                        // model.notifyListeners();
                                      },
                                      child: Text( "${(model.drinkList.where((drink)
                                      => element==drink.id).first as FavoritesModel).name}"),
                                      style: ElevatedButton.styleFrom(
                                        primary:  ColorUtils.white,
                                        onPrimary: ColorUtils.red_color,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.8.h,
                                            horizontal: 9.w),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                Dimensions.roundCorner),
                                            side: BorderSide(
                                                color: ColorUtils.text_red,
                                                width: 1)),
                                        textStyle: TextStyle(
                                          //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                          fontFamily:
                                          FontUtils.modernistBold,

                                          fontSize: 1.5.t,
                                          //height: 0
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 3.h),

                                  //Favorite Night Club
                                  Text(
                                    "Favorite Night Club",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Wrap(
                                    spacing: 2.5.w,
                                    runSpacing: 1.5.h,
                                    direction: Axis.horizontal,
                                    children: model.matchedUser!.favorite_musics!
                                        .map((element) => ElevatedButton(
                                      onPressed: () {
                                        // if (model.selectedInterestList
                                        //     .contains(model.interestList
                                        //         .indexOf(element))) {
                                        //   model.selectedInterestList.remove(
                                        //       model.interestList
                                        //           .indexOf(element));
                                        // } else {
                                        //   //model.selectedInterestList.add(model.interestList.indexOf(element));
                                        // }
                                        // model.notifyListeners();
                                      },
                                      child: Text( "${(model.clubList.where((drink)
                                      => element==drink.id).first as FavoritesModel).name}"),
                                      style: ElevatedButton.styleFrom(
                                        primary:  ColorUtils.white,
                                        onPrimary: ColorUtils.red_color,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.8.h,
                                            horizontal: 9.w),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                Dimensions.roundCorner),
                                            side: BorderSide(
                                                color: ColorUtils.text_red,
                                                width: 1)),
                                        textStyle: TextStyle(
                                          //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                          fontFamily:
                                          FontUtils.modernistBold,

                                          fontSize: 1.5.t,
                                          //height: 0
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 3.h),

                                  //Favorite Party Vacation
                                  Text(
                                    "Favorite Party Vacation",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.t,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Wrap(
                                    spacing: 2.5.w,
                                    runSpacing: 1.5.h,
                                    direction: Axis.horizontal,
                                    children: model.matchedUser!.favorite_party_vacation!
                                        .map((element) => ElevatedButton(
                                      onPressed: () {
                                        // if (model.selectedInterestList
                                        //     .contains(model.interestList
                                        //         .indexOf(element))) {
                                        //   model.selectedInterestList.remove(
                                        //       model.interestList
                                        //           .indexOf(element));
                                        // } else {
                                        //   //model.selectedInterestList.add(model.interestList.indexOf(element));
                                        // }
                                        // model.notifyListeners();
                                      },
                                      child: Text( "${(model.vacationList.where((drink)
                                      => element==drink.id).first as FavoritesModel).name}"),
                                      style: ElevatedButton.styleFrom(
                                        primary:  ColorUtils.white,
                                        onPrimary: ColorUtils.red_color,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.8.h,
                                            horizontal: 9.w),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                Dimensions.roundCorner),
                                            side: BorderSide(
                                                color: ColorUtils.text_red,
                                                width: 1)),
                                        textStyle: TextStyle(
                                          //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                          fontFamily:
                                          FontUtils.modernistBold,

                                          fontSize: 1.5.t,
                                          //height: 0
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 3.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Image",
                                        style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.3.t,
                                          color: ColorUtils.black,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      // Text(
                                      //   "See all",
                                      //   style: TextStyle(
                                      //       fontFamily: FontUtils.modernistRegular,
                                      //       fontSize: 1.8.t,
                                      //       color: ColorUtils.red_color,
                                      //       decoration: TextDecoration.underline),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),

                                  //Images
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //Image_1 Profile Picture
                                      Container(
                                          height: MediaQuery.of(context).size.width / 3.4,
                                          width:
                                          MediaQuery.of(context).size.width / 3.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(model.matchedUser!.profile_picture!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: IconButton(
                                              //     onPressed: () {
                                              //       // model.imageFiles.removeAt(0);
                                              //       // model.imageFiles.insert(0, File(""));
                                              //       // model.notifyListeners();
                                              //     },
                                              //     icon: SvgPicture.asset(
                                              //         ImageUtils.cancelIcon),
                                              //     //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                              //     padding: EdgeInsets.zero,
                                              //     constraints: BoxConstraints(),
                                              //     color: ColorUtils.white,
                                              //     highlightColor:
                                              //     ColorUtils.white,
                                              //   ),
                                              // ),
                                            ],
                                          )),

                                      //Image_1 Catagory Image_1
                                      if(model.matchedUser!.catalogue_image1 != null)
                                      Container(
                                          height: MediaQuery.of(context).size.width / 3.4,
                                          width:
                                          MediaQuery.of(context).size.width / 3.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(model.matchedUser!.catalogue_image1!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: IconButton(
                                              //     onPressed: () {
                                              //       // model.imageFiles.removeAt(0);
                                              //       // model.imageFiles.insert(0, File(""));
                                              //       // model.notifyListeners();
                                              //     },
                                              //     icon: SvgPicture.asset(
                                              //         ImageUtils.cancelIcon),
                                              //     //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                              //     padding: EdgeInsets.zero,
                                              //     constraints: BoxConstraints(),
                                              //     color: ColorUtils.white,
                                              //     highlightColor:
                                              //     ColorUtils.white,
                                              //   ),
                                              // ),
                                            ],
                                          )),

                                      //Image_1 Catagory Image_2
                                      if(model.matchedUser!.catalogue_image2 != null)
                                      Container(
                                          height: MediaQuery.of(context).size.width / 3.4,
                                          width:
                                          MediaQuery.of(context).size.width / 3.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(model.matchedUser!.catalogue_image2!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: IconButton(
                                              //     onPressed: () {
                                              //       // model.imageFiles.removeAt(0);
                                              //       // model.imageFiles.insert(0, File(""));
                                              //       // model.notifyListeners();
                                              //     },
                                              //     icon: SvgPicture.asset(
                                              //         ImageUtils.cancelIcon),
                                              //     //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                              //     padding: EdgeInsets.zero,
                                              //     constraints: BoxConstraints(),
                                              //     color: ColorUtils.white,
                                              //     highlightColor:
                                              //     ColorUtils.white,
                                              //   ),
                                              // ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //Image_1 Catagory Image_3
                                      if(model.matchedUser!.catalogue_image3 != null)
                                      Container(
                                          height: MediaQuery.of(context).size.width / 3.4,
                                          width:
                                          MediaQuery.of(context).size.width / 3.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(model.matchedUser!.catalogue_image3!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: IconButton(
                                              //     onPressed: () {
                                              //       // model.imageFiles.removeAt(0);
                                              //       // model.imageFiles.insert(0, File(""));
                                              //       // model.notifyListeners();
                                              //     },
                                              //     icon: SvgPicture.asset(
                                              //         ImageUtils.cancelIcon),
                                              //     //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                              //     padding: EdgeInsets.zero,
                                              //     constraints: BoxConstraints(),
                                              //     color: ColorUtils.white,
                                              //     highlightColor:
                                              //     ColorUtils.white,
                                              //   ),
                                              // ),
                                            ],
                                          )),

                                      //Image_1 Catagory Image_4
                                      if(model.matchedUser!.catalogue_image4 != null)
                                      Container(
                                          height: MediaQuery.of(context).size.width / 3.4,
                                          width:
                                          MediaQuery.of(context).size.width / 3.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(model.matchedUser!.catalogue_image4!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: IconButton(
                                              //     onPressed: () {
                                              //       // model.imageFiles.removeAt(0);
                                              //       // model.imageFiles.insert(0, File(""));
                                              //       // model.notifyListeners();
                                              //     },
                                              //     icon: SvgPicture.asset(
                                              //         ImageUtils.cancelIcon),
                                              //     //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                              //     padding: EdgeInsets.zero,
                                              //     constraints: BoxConstraints(),
                                              //     color: ColorUtils.white,
                                              //     highlightColor:
                                              //     ColorUtils.white,
                                              //   ),
                                              // ),
                                            ],
                                          )),

                                      // Image_1 Catagory Image_5
                                      if(model.matchedUser!.catalogue_image5 != null)
                                      Container(
                                          height: MediaQuery.of(context).size.width / 3.4,
                                          width:
                                          MediaQuery.of(context).size.width / 3.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(model.matchedUser!.catalogue_image5!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: IconButton(
                                              //     onPressed: () {
                                              //       // model.imageFiles.removeAt(0);
                                              //       // model.imageFiles.insert(0, File(""));
                                              //       // model.notifyListeners();
                                              //     },
                                              //     icon: SvgPicture.asset(
                                              //         ImageUtils.cancelIcon),
                                              //     //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                              //     padding: EdgeInsets.zero,
                                              //     constraints: BoxConstraints(),
                                              //     color: ColorUtils.white,
                                              //     highlightColor:
                                              //     ColorUtils.white,
                                              //   ),
                                              // ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 3.h),

                                  SizedBox(height: 3.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Friends",
                                        style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.3.t,
                                          color: ColorUtils.black,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "See all",
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.red_color,
                                            decoration: TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Container(
                                    child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: model.matchedUser!.friends!.length,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 25,
                                          crossAxisSpacing: 15),
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.network(model.matchedUser!.friends![index].user!.profilePicture!,
                                                  width: 15.i,
                                                  height: 15.i,
                                                  fit: BoxFit.cover,

                                                ),
                                              ),
                                              // Image.network(
                                              //   model.matchedUser!.friends![index].user!.profilePicture!,
                                              //   height: 15.i,
                                              // ),
                                              Expanded(
                                                  child: Text(
                                                    (model.matchedUser!.friends![index].user!.username),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily:
                                                        FontUtils.modernistBold,
                                                        fontSize: 1.7.t),
                                                    textAlign: TextAlign.center,
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Mutual Friends",
                                        style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.3.t,
                                          color: ColorUtils.black,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "See all",
                                        style: TextStyle(
                                            fontFamily: FontUtils.modernistRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.red_color,
                                            decoration: TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Container(
                                    child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: model.matchedUser!.friends!.length,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 25,
                                          crossAxisSpacing: 15),
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.network(model.matchedUser!.friends![index].user!.profilePicture!,
                                                  width: 15.i,
                                                  height: 15.i,
                                                  fit: BoxFit.cover,

                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    (model.matchedUser!.friends![index].user!.username),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily:
                                                        FontUtils.modernistBold,
                                                        fontSize: 1.7.t),
                                                    textAlign: TextAlign.center,
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 0.h),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                )),
          ),
        );

      },
    );
  }
}
