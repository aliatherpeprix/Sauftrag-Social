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
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    model.navigateToHomeBarScreen();
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
                                "Order Details",
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 3.t,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.w),
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
                      SizedBox(height: 2.h),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return  Stack(
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
                                        Text(
                                          model.barQRcode[index].name!,
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
                                      'x${model.drinksSelected[index][model.barQRcode[index].name]}',
                                      style: TextStyle(
                                          color: ColorUtils.black,
                                          fontSize: 2.h,
                                          fontFamily: FontUtils.modernistBold),
                                    ),)
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return  SizedBox(height: 2.h);
                            },
                            itemCount: model.drinksSelected.length),
                      )



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
