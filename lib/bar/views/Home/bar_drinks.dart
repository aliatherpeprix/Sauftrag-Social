import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/services/drinksOrder.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:stacked/stacked.dart';

class BarDrinks extends StatefulWidget {
  const BarDrinks({Key? key}) : super(key: key);

  @override
  _BarDrinksState createState() => _BarDrinksState();
}

class _BarDrinksState extends State<BarDrinks> {
  String dropdownvalue = 'Beer 0.33 L';
  var items = [
    'Beer 0.33 L',
    'Beer 0.60 L',
    'Beer 0.75 L',
  ];

  String dropdownvalue1 = 'Shot (40% Alc)';
  var items1 = [
    'Shot (40% Alc)',
    'Shot (60% Alc)',
    'Shot (80% Alc)',
  ];

  int index = 0;
  int index1 = 0;
  int index2 = 0;
  int index3 = 0;

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
                                size: 4.5.i,
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "Choose your drink",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 3.h),

                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.barQRcode.length,
                          itemBuilder: (context, index) {
                            return DrinkItem(index: index,);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 3.h);
                          },
                        ),
                      ),

                      SizedBox(height: 3.h),

                      Stack(
                        children: [
                          Container(
                            height: 7.h,
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
                            child: Center(
                              child: Text(
                                '2 Free Drinks',
                                style: TextStyle(
                                    color: ColorUtils.text_red,
                                    fontSize: 2.h,
                                    fontFamily: FontUtils.modernistBold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      //Next Button
                      SizedBox(
                        width: double.infinity,
                        //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                        child: ElevatedButton(
                          onPressed: () {
                            print(model.drinksSelected);
                            model.orderDrinks();
                            //model.navigateToOrderDetailsScreen();
                          },
                          child: const Text("Confirm"),
                          style: ElevatedButton.styleFrom(
                            primary: ColorUtils.text_red,
                            onPrimary: ColorUtils.white,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.containerVerticalPadding),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.roundCorner)),
                            textStyle: TextStyle(
                              color: ColorUtils.white,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 1.8.t,
                              //height: 0
                            ),
                          ),
                        ),
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

class DrinkItem extends StatefulWidget {
  final int? index;
  const DrinkItem({Key? key,this.index}) : super(key: key);

  @override
  _DrinkItemState createState() => _DrinkItemState();
}

class _DrinkItemState extends State<DrinkItem> {

  int index = 0;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => locator<MainViewModel>(),
        builder: (context, model, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 6.h,
                width: 48.w,
                padding: EdgeInsets.symmetric(
                    vertical: 0.h, horizontal: 2.w),
                decoration: BoxDecoration(
                    color: ColorUtils.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.roundCorner)),
                    border: Border.all(color: ColorUtils.text_red)),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(model.barQRcode[widget.index!].name!,style: TextStyle(
                        fontFamily:
                        FontUtils.modernistRegular,
                        fontSize: 2.t,
                        color: ColorUtils.text_red)
                    ),
                  ],
                ),
              ),
              Container(
                height: 6.h,
                width: 40.w,
                padding: EdgeInsets.symmetric(
                    vertical: 0.h, horizontal: 2.w),
                decoration: BoxDecoration(
                    color: ColorUtils.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.roundCorner)),
                    border: Border.all(color: ColorUtils.text_red)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if((model.drinksSelected[widget.index!][model.barQRcode[widget.index!].name!] as int) != 0){
                            model.drinksSelected[widget.index!][model.barQRcode[widget.index!].name!] = model.drinksSelected[widget.index!][model.barQRcode[widget.index!].name!] - 1;
                          }
                          setState(() {});
                        },
                        child: Center(
                          child: Container(
                            //padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)),
                                border: Border.all(
                                    color: ColorUtils.text_red)),
                            child: Icon(
                              Icons.remove,
                              size: 5.i,
                              color: ColorUtils.text_red,
                            ),
                          ),
                        )),
                    Text(
                      model.drinksSelected[widget.index!][model.barQRcode[widget.index!].name!].toString(),
                      style: TextStyle(
                          color: ColorUtils.text_red,
                          fontSize: 2.h),
                    ),

                    GestureDetector(
                        onTap: () {
                          model.drinksSelected[widget.index!][model.barQRcode[widget.index!].name!] = model.drinksSelected[widget.index!][model.barQRcode[widget.index!].name!] + 1;
                          setState(() {});
                        },
                        child: Center(
                          child: Container(
                            //padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)),
                                border: Border.all(
                                    color: ColorUtils.text_red)),
                            child: Icon(
                              Icons.add,
                              size: 5.i,
                              color: ColorUtils.text_red,
                            ),
                          ),
                        )),
                  ],
                ),
              ),

              /* Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Event Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),*/
            ],
          );
        },
      disposeViewModel: false,
    );
  }
}

