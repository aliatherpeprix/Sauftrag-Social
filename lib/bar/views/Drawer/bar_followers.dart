import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:stacked/stacked.dart';

class BarFollowers extends StatefulWidget {
  const BarFollowers({Key? key}) : super(key: key);

  @override
  _BarFollowersState createState() => _BarFollowersState();
}

class _BarFollowersState extends State<BarFollowers> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) {
        //model.followers();
        model.barModel;
        model.getBarsFollowers();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return model.isFaqs == true ? AllPageLoader() : SafeArea(
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
                        "Bar Followers",
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
                              // model.barId = model.listOfBar[index].id;
                              // model.selectedBar = (model.listOfAllBars[index]);
                              // model.navigateToBarProfile();
                              model.getbarFollowersDet = (model.getbarfollowers[index]);
                              model.navigateToBarFollowerDet();
                            },
                            child:
                            // model.listOfAllBars[index].is_follow == true ?
                            Container(
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
                                    child: Image.network(model.getbarfollowers[index].follow_by![index]!.profile_picture!,
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
                                            Text(model.getbarfollowers[index].follow_by![index]!.username!,
                                              style: TextStyle(
                                                  fontFamily: FontUtils.modernistBold,
                                                  fontSize: 1.9.t,
                                                  color: ColorUtils.black
                                              ),
                                            ),
                                            SizedBox(width: 1.w,),

                                          ],
                                        ),
                                        SizedBox(height: 1.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(ImageUtils.locationPin,),
                                            SizedBox(width: 1.5.w,),
                                            Container(
                                              width: 50.w,
                                              child: Text(model.getbarfollowers[index].follow_by![index]!.address!,
                                                style: TextStyle(
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.6.t,
                                                  color: ColorUtils.text_grey,
                                                ),

                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.8.h,),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                          // : Container()
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                    },
                    itemCount: model.getbarfollowers.length,
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
