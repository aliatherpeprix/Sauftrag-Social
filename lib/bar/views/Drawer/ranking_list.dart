import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class RatingList extends StatefulWidget {
  const RatingList({Key? key}) : super(key: key);

  @override
  _RatingListState createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                model.navigateBack();
                              },
                              iconSize: 15.0,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorUtils.black,
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "Ranking List",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      ///--------------Event Name--------------------///
                      Center(
                          child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 9.5.w),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Column(
                                    children: [
                                      Text("2", style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.5.t,
                                      ),),
                                      SizedBox(height: 0.8.h,),
                                      Image.asset(ImageUtils.polygon, height: 1.2.h,),
                                      SizedBox(height: 0.8.h,),
                                      Container(
                                          decoration: BoxDecoration(),
                                          child: Image.asset(
                                            ImageUtils.rank2,
                                            fit: BoxFit.cover,
                                            height: 12.h,

                                          )),
                                      Text("Nick", style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.t,
                                      ),),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("290", style: TextStyle(
                                            color: ColorUtils.red_color,
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 1.8.t,
                                          ),),
                                          SizedBox(width: 1.w,),
                                          Image.asset(ImageUtils.coinImg)
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Column(
                                    children: [
                                      Text("3", style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.5.t,
                                      ),),
                                      SizedBox(height: 0.8.h,),
                                      Image.asset(ImageUtils.polygon,height: 1.2.h, ),
                                      SizedBox(height: 0.8.h,),
                                      Container(
                                          decoration: BoxDecoration(),
                                          child: Image.asset(
                                            ImageUtils.rank3,
                                            fit: BoxFit.cover,
                                            height: 12.h,
                                          )),
                                      Text("Leona", style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.t,
                                      ),),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("260 ", style: TextStyle(
                                            color: ColorUtils.red_color,
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 1.8.t,
                                          ),),
                                          SizedBox(width: 1.w,),
                                          Image.asset(ImageUtils.coinImg)
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text("1", style: TextStyle(
                                      color: ColorUtils.black,
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.5.t,
                                    ),),
                                    SizedBox(height: 1.h,),
                                    Image.asset(ImageUtils.bottleRank, height: 4.h,),
                                    Container(
                                        decoration: BoxDecoration(),
                                        child: Image.asset(
                                          ImageUtils.rank1,
                                          fit: BoxFit.cover,
                                          height: 17.h,
                                        )),
                                    Text("Frances", style: TextStyle(
                                      color: ColorUtils.black,
                                      fontFamily: FontUtils.modernistBold,
                                      fontSize: 2.t,
                                    ),),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("300", style: TextStyle(
                                          color: ColorUtils.red_color,
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 1.8.t,
                                        ),),
                                        SizedBox(width: 1.w,),
                                        Image.asset(ImageUtils.coinImg)
                                      ],
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      )),
                      SizedBox(
                        height: 3.h,
                      ),

                      ///--------------Settings Options--------------------///

                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            // decoration: BoxDecoration(
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: ColorUtils.black.withOpacity(0.1),
                            //       spreadRadius: 0,
                            //       blurRadius: 10,
                            //       offset: Offset(0, 5), // changes position of shadow
                            //     ),
                            //   ],
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.all(Radius.circular(18)),
                            //   border: Border.all(color: ColorUtils.red_color),
                            // ),
                            child:  Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(model.ratingList[index]["rank"],
                                  style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 2.t,
                                      color: ColorUtils.red_color),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5.w),
                                    decoration: BoxDecoration(
                                      color: ColorUtils.searchFieldColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child: Image.asset(model.ratingList[index]["image"],
                                                width: 12.i,
                                                height: 12.i,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(model.ratingList[index]["title"],
                                              style: TextStyle(
                                                  fontFamily: FontUtils.modernistBold,
                                                  fontSize: 2.t,
                                                  color: ColorUtils.black),
                                            ),
                                          ],
                                        ),
                                       Row(
                                         children: [
                                           Text(model.ratingList[index]["points"],
                                             style: TextStyle(
                                                 fontFamily: FontUtils.modernistRegular,
                                                 fontSize: 2.t,
                                                 color: ColorUtils.red_color),
                                           ),
                                           SizedBox(width: 1.w,),
                                           Image.asset(model.ratingList[index]['image1'])
                                         ],
                                       )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                        },
                        itemCount: model.ratingList.length,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),



                    ],
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
