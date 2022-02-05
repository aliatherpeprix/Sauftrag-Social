import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/widgets/deactivate_account_dialog_box.dart';
import 'package:sauftrag/bar/widgets/delete_account_dialog_box.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class FaqAnswer extends StatefulWidget {
  final FaqsModel? faq;
  const FaqAnswer({Key? key,this.faq}) : super(key: key);

  @override
  _FaqAnswerState createState() => _FaqAnswerState();
}

class _FaqAnswerState extends State<FaqAnswer> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
       // model.getFaqsList();
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

                  child:  Row(
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
                      // Text(
                      //   "FAQ",
                      //   style: TextStyle(
                      //     color: ColorUtils.black,
                      //     fontFamily: FontUtils.modernistBold,
                      //     fontSize: 3.t,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 5,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric( horizontal: 2.w, vertical: 2.h),
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
                    //border: Border.all(color: ColorUtils.text_red),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.selectedFaq!.question!,
                        style: TextStyle(
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.t,
                            color: ColorUtils.red_color
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Text(model.selectedFaq!.answer!,
                        style: TextStyle(
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                            color: ColorUtils.black
                        ),
                      ),
                    ],
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
