import 'package:flutter/cupertino.dart';
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

class BarEvent extends StatefulWidget {
  const BarEvent({Key? key}) : super(key: key);

  @override
  _BarEventState createState() => _BarEventState();
}

class _BarEventState extends State<BarEvent> {
  List places = [
    {
      'image': ImageUtils.boy,
      'eventName': 'Trivia Nights',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1' : ImageUtils.addClubIcon
    },
    {
      'image': ImageUtils.boy,
      'eventName': 'Bar Crawl Stop',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1' : ImageUtils.addClubIcon
    },
    {
      'image': ImageUtils.boy,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1' : ImageUtils.addClubIcon
    },
    {
      'image': ImageUtils.boy,
      'eventName': 'Bar Olympics',
      'date': '1st  May- Sat -2:00 PM',
      'location': ' Lot 13 • Oakland, CA',
      'image1' : ImageUtils.addClubIcon
    },
  ];

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
              child: Column(
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
                        "Bar Timing",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.5.t,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 3,),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier * 4,),
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
                              border: Border.all(color: ColorUtils.red_color),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(places[index]["image"],
                                          width: 20.i,
                                          height: 20.i,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 3.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(places[index]["date"],
                                            style: TextStyle(
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.7.t,
                                                color: ColorUtils.text_red
                                            ),
                                          ),
                                          SizedBox(height: 1.h,),
                                          Text(places[index]["eventName"],
                                            style: TextStyle(
                                                fontFamily: FontUtils.modernistBold,
                                                fontSize: 2.2.t,
                                                color: ColorUtils.black
                                            ),
                                          ),
                                          SizedBox(height: 1.h,),
                                         Row(
                                           children: [
                                             SvgPicture.asset(places[index]["image1"]),
                                             SizedBox(width: 2.w,),
                                             Text(places[index]["location"],
                                               style: TextStyle(
                                                   fontFamily: FontUtils.modernistRegular,
                                                   fontSize: 1.7.t,
                                                   color: ColorUtils.text_dark
                                               ),
                                             ),
                                           ],
                                         )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                      },
                      itemCount: places.length,
                    ),
                  ),
                  SizedBox(height: 6.h,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

