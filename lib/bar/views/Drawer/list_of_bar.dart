import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/services/listOfBars.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class ListOfBar extends StatefulWidget {
  const ListOfBar({Key? key}) : super(key: key);

  @override
  _ListOfBarState createState() => _ListOfBarState();
}

class _ListOfBarState extends State<ListOfBar> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        model.getListOfbars();
      },

      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(height: Dimensions.topMargin),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),

                  child: Row(
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
                        "Bars",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 3.t,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h,),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier * 4,),
                        child: GestureDetector(
                          onTap: (){
                            model.navigateToBarProfile();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric( horizontal: 2.5.w, vertical: 1.5.h),
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
                              border: Border.all(color: ColorUtils.text_red),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(model.listOfBar[index].profile_picture!,
                                    width: 15.i,
                                    height: 15.i,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(model.listOfBar[index].bar_name!,
                                          style: TextStyle(
                                              fontFamily: FontUtils.modernistBold,
                                              fontSize: 1.9.t,
                                              color: ColorUtils.black
                                          ),
                                        ),
                                        SizedBox(width: 1.w,),
                                        Text(model.ListOfBar[index]['type']!,
                                          style: TextStyle(
                                              fontFamily: FontUtils.modernistRegular,
                                              fontSize: 1.6.t,
                                              color: ColorUtils.red_color
                                          ),
                                        )
                                      ],
                                    ),
                                      SizedBox(height: 0.8.h,),
                                      Row(
                                        children: [
                                          SvgPicture.asset(model.ListOfBar[index]["locationIcon"],),
                                          SizedBox(width: 1.5.w,),
                                          Text(model.listOfBar[index].address!,
                                            style: TextStyle(
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.6.t,
                                                color: ColorUtils.text_grey
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.8.h,),
                                      RatingBar.builder(
                                        // initialRating: 3,
                                        // minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 4.5.i,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_rounded,
                                          color: ColorUtils.red_color,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                    },
                    itemCount: model.listOfBar.length,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
