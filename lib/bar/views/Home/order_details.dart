import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Details",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            "Product",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.containerVerticalPadding,
                                horizontal:
                                Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.text_red)),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageUtils.beer, height: 5.h,),
                                SizedBox(width: 2.w,),
                                Text(
                                  'Beer ( 1 Liter)',
                                  style: TextStyle(
                                      color: ColorUtils.black,
                                      fontSize: 2.h,
                                      fontFamily: FontUtils.modernistBold),
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                              bottom: 12,
                              end: 20,
                              child:  Text(
                                'x2',
                                style: TextStyle(
                                    color: ColorUtils.black,
                                    fontSize: 2.h,
                                    fontFamily: FontUtils.modernistBold),
                              ),)
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.containerVerticalPadding,
                                horizontal:
                                Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.text_red)),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageUtils.cocktail, height: 5.h,),
                                SizedBox(width: 2.w,),
                                Text(
                                  'Coctail',
                                  style: TextStyle(
                                      color: ColorUtils.black,
                                      fontSize: 2.h,
                                      fontFamily: FontUtils.modernistBold),
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 12,
                            end: 20,
                            child:  Text(
                              'x2',
                              style: TextStyle(
                                  color: ColorUtils.black,
                                  fontSize: 2.h,
                                  fontFamily: FontUtils.modernistBold),
                            ),)
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.containerVerticalPadding,
                                horizontal:
                                Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.text_red)),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageUtils.longDrink, height: 5.h,),
                                SizedBox(width: 2.w,),
                                Text(
                                  'Long Drink',
                                  style: TextStyle(
                                      color: ColorUtils.black,
                                      fontSize: 2.h,
                                      fontFamily: FontUtils.modernistBold),
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 12,
                            end: 20,
                            child:  Text(
                              'x2',
                              style: TextStyle(
                                  color: ColorUtils.black,
                                  fontSize: 2.h,
                                  fontFamily: FontUtils.modernistBold),
                            ),)
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.containerVerticalPadding,
                                horizontal:
                                Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.text_red)),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageUtils.shorts, height: 5.h,),
                                SizedBox(width: 2.w,),
                                Text(
                                  'Shot',
                                  style: TextStyle(
                                      color: ColorUtils.black,
                                      fontSize: 2.h,
                                      fontFamily: FontUtils.modernistBold),
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 12,
                            end: 20,
                            child:  Text(
                              'x2',
                              style: TextStyle(
                                  color: ColorUtils.black,
                                  fontSize: 2.h,
                                  fontFamily: FontUtils.modernistBold),
                            ),)
                        ],
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
