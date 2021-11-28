import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class CreateBarEvent extends StatefulWidget {
  const CreateBarEvent({Key? key}) : super(key: key);

  @override
  _CreateBarEventState createState() => _CreateBarEventState();
}

class _CreateBarEventState extends State<CreateBarEvent> {

  DateTime _dateTime = DateTime.now();
  String? openingTimeFrom;
  String? openingTimeTo;
  String? breakTimeFrom;
  String? breakTimeTo;

  @override
  void didChangeDependencies() {
    openingTimeFrom = TimeOfDay.now().format(context);
    openingTimeTo = TimeOfDay.now().format(context);
    breakTimeFrom = TimeOfDay.now().format(context);
    breakTimeTo = TimeOfDay.now().format(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
                    mainAxisSize: MainAxisSize.max,
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
                            "Create Event",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      ///--------------Event Name--------------------///
                      Stack(
                        children: [

                          Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.text_red)
                            ),
                            child: TextField(
                              //focusNode: model.logInEmailFocus,
                              //controller: model.logInEmailController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                color: ColorUtils.text_red,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                              decoration:  InputDecoration(
                                hintText: "Title",
                                hintStyle: TextStyle(
                                  color: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 1.8.t,
                                ),
                                border: InputBorder.none,

                                isDense:true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              ),
                            ),
                          ),

                          Container(
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
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      ///--------------Event Description--------------------///
                      Stack(
                        children: [

                          Container(
                            //height: 20.h,
                              padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                              decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                  border: Border.all(color: ColorUtils.text_red)
                              ),
                              child: TextField(
                                maxLines: 4,
                                maxLength: 120,
                                //focusNode: model.logInEmailFocus,
                                //controller: model.logInEmailController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                ),
                                decoration:  InputDecoration(
                                  hintText: "Add Description",
                                  hintStyle: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                  ),
                                  border: InputBorder.none,

                                  isDense:true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                ),
                              )
                          ),


                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "About Event",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1 * SizeConfig.heightMultiplier),
                            child: Text(
                              "120 characters only",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily:
                                FontUtils.modernistRegular,
                                fontSize:  1.5.t,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 1.h),


                      ///----------------Add Events Pictures---------------------------///
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "Add Photos",
                           style: TextStyle(
                             color: ColorUtils.black,
                             fontFamily: FontUtils.modernistBold,
                             fontSize: 2.5.t,
                           ),
                         ),
                       ],
                     ),
                      SizedBox(height: 3.h),
                      //Images
                      SizedBox(
                        height: 10.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Image 1
                            Container(
                                width:
                                MediaQuery.of(context).size.width / 5.5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  image: model.imageFiles[0].path.isEmpty
                                      ? null
                                      : DecorationImage(
                                      image:
                                      FileImage(model.imageFiles[0]),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [
                                    model.imageFiles[0].path.isEmpty
                                        ? InkWell(
                                        onTap: () {
                                          model.getImage(0);
                                          model.notifyListeners();
                                        },
                                        child: DottedBorder(
                                            color: ColorUtils.text_red,
                                            strokeWidth: 1.5,
                                            borderType: BorderType.RRect,
                                            radius:
                                            const Radius.circular(15),
                                            dashPattern: [8],
                                            child: Center(
                                              child: Icon(
                                                Icons.add_rounded,
                                                color:
                                                ColorUtils.text_red,
                                                size: 6.i,
                                              ),
                                            )))
                                        : Container(),
                                    model.imageFiles[0].path.isEmpty
                                        ? Container()
                                        : Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          model.imageFiles.removeAt(0);
                                          model.notifyListeners();
                                        },
                                        icon: SvgPicture.asset(
                                            ImageUtils.cancelIcon),
                                        //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: ColorUtils.white,
                                        highlightColor:
                                        ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                )),

                            //Image 2
                            Container(
                                width:
                                MediaQuery.of(context).size.width / 5.5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  image: model.imageFiles[1].path.isEmpty
                                      ? null
                                      : DecorationImage(
                                      image:
                                      FileImage(model.imageFiles[1]),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [
                                    model.imageFiles[1].path.isEmpty
                                        ? InkWell(
                                        onTap: () {
                                          model.getImage(1);
                                          model.notifyListeners();
                                        },
                                        child: DottedBorder(
                                            color: ColorUtils.text_red,
                                            strokeWidth: 1.5,
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(15),
                                            dashPattern: [8],
                                            child: Center(
                                              child: Icon(
                                                Icons.add_rounded,
                                                color:
                                                ColorUtils.text_red,
                                                size: 6.i,
                                              ),
                                            )))
                                        : Container(),
                                    model.imageFiles[1].path.isEmpty
                                        ? Container()
                                        : Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          model.imageFiles.removeAt(1);
                                          model.notifyListeners();
                                        },
                                        icon: SvgPicture.asset(
                                            ImageUtils.cancelIcon),
                                        //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: ColorUtils.white,
                                        highlightColor:
                                        ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                )),

                            //Image 3
                            Container(
                                width:
                                MediaQuery.of(context).size.width / 5.5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  image: model.imageFiles[2].path.isEmpty
                                      ? null
                                      : DecorationImage(
                                      image:
                                      FileImage(model.imageFiles[2]),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [
                                    model.imageFiles[2].path.isEmpty
                                        ? InkWell(
                                        onTap: () {
                                          model.getImage(2);
                                          model.notifyListeners();
                                        },
                                        child: DottedBorder(
                                            color: ColorUtils.text_red,
                                            strokeWidth: 1.5,
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(15),
                                            dashPattern: [8],
                                            child: Center(
                                              child: Icon(
                                                Icons.add_rounded,
                                                color:
                                                ColorUtils.text_red,
                                                size: 6.i,
                                              ),
                                            )))
                                        : Container(),
                                    model.imageFiles[2].path.isEmpty
                                        ? Container()
                                        : Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          model.imageFiles.removeAt(0);
                                          model.notifyListeners();
                                        },
                                        icon: SvgPicture.asset(
                                            ImageUtils.cancelIcon),
                                        //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: ColorUtils.white,
                                        highlightColor:
                                        ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                )),

                            //Image 4
                            Container(
                                width:
                                MediaQuery.of(context).size.width / 5.5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  image: model.imageFiles[2].path.isEmpty
                                      ? null
                                      : DecorationImage(
                                      image:
                                      FileImage(model.imageFiles[2]),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [
                                    model.imageFiles[2].path.isEmpty
                                        ? InkWell(
                                        onTap: () {
                                          model.getImage(2);
                                          model.notifyListeners();
                                        },
                                        child: DottedBorder(
                                            color: ColorUtils.text_red,
                                            strokeWidth: 1.5,
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(15),
                                            dashPattern: [8],
                                            child: Center(
                                              child: Icon(
                                                Icons.add_rounded,
                                                color:
                                                ColorUtils.text_red,
                                                size: 6.i,
                                              ),
                                            )))
                                        : Container(),
                                    model.imageFiles[2].path.isEmpty
                                        ? Container()
                                        : Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          model.imageFiles.removeAt(0);
                                          model.notifyListeners();
                                        },
                                        icon: SvgPicture.asset(
                                            ImageUtils.cancelIcon),
                                        //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: ColorUtils.white,
                                        highlightColor:
                                        ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),

                      ///------------------Event Location ------------------///
                      Stack(
                        children: [

                          Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.divider)
                            ),
                            child: Row(
                              children: [

                                SvgPicture.asset(ImageUtils.locationIcon),

                                SizedBox(width: 4.w),

                                Expanded(
                                  child: TextField(
                                    //focusNode: model.logInEmailFocus,
                                    //controller: model.logInEmailController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      color: ColorUtils.black,
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.8.t,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense:true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Event Location",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_grey,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      ///-----------------Event Date ---------------------///
                      Stack(
                        children: [

                          Container(
                            height: 7.h,
                            padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                            decoration: BoxDecoration(
                                color: ColorUtils.white,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.roundCorner)),
                                border: Border.all(color: ColorUtils.divider)
                            ),
                            child: Row(
                              children: [

                                SvgPicture.asset(ImageUtils.calendarIcon),

                                SizedBox(width: 4.w),

                                Expanded(
                                  child: TextField(
                                    //focusNode: model.logInEmailFocus,
                                    //controller: model.logInEmailController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      color: ColorUtils.black,
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 2.t,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense:true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            color: ColorUtils.white,
                            child: Text(
                              "Event Date",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtils.text_grey,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.5.t,
                                  height: .4
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      ///-----------------Event Date(From, To) ---------------------///
                      Container(
                        //margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [

                            //From
                            Expanded(
                              child: Stack(
                                children: [

                                  GestureDetector(
                                    onTap: (){
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          initialEntryMode: TimePickerEntryMode.dial,
                                          confirmText: "CONFIRM",
                                          cancelText: "NOT NOW",
                                          helpText: "BOOKING TIME"
                                      ).then((value){
                                        openingTimeFrom = value!.format(context);
                                        model.notifyListeners();
                                      });
                                    },
                                    child:  Container(
                                      height: 6.h,
                                      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                                      decoration: BoxDecoration(
                                          color: ColorUtils.white,
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          border: Border.all(color: ColorUtils.divider)
                                      ),
                                      child: Row(
                                        children: [

                                          Expanded(
                                            child: Text(
                                              openingTimeFrom!,
                                              style: TextStyle(
                                                color: ColorUtils.text_dark,
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.6.t,
                                                //height: .4
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 4.w),

                                          SvgPicture.asset(ImageUtils.upDownArrow),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 3.w),
                                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    color: ColorUtils.white,
                                    child: Text(
                                      "From",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.5.t,
                                          height: .4
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 20),

                            //To
                            Expanded(
                              child: Stack(
                                children: [

                                  GestureDetector(
                                    onTap: (){
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          initialEntryMode: TimePickerEntryMode.dial,
                                          confirmText: "CONFIRM",
                                          cancelText: "NOT NOW",
                                          helpText: "BOOKING TIME"
                                      ).then((value){
                                        openingTimeTo = value!.format(context);
                                        model.notifyListeners();
                                      });
                                    },
                                    child: Container(
                                      height: 6.h,
                                      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                                      decoration: BoxDecoration(
                                          color: ColorUtils.white,
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          border: Border.all(color: ColorUtils.divider)
                                      ),
                                      child: Row(
                                        children: [

                                          Expanded(
                                            child: Text(
                                              openingTimeTo!,
                                              style: TextStyle(
                                                color: ColorUtils.text_dark,
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.6.t,
                                                //height: .4
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 4.w),

                                          SvgPicture.asset(ImageUtils.upDownArrow),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 3.w),
                                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    color: ColorUtils.white,
                                    child: Text(
                                      "To",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.5.t,
                                          height: .4
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///-------------Create Event Button-------------------////
                      SizedBox(height: 5.h),

                      //Next Button
                      SizedBox(
                        width: double.infinity,
                        //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                        child: ElevatedButton(
                          onPressed: () {
                            //model.navigateToMediaScreen();
                          },
                          child: const Text("Create Event"),
                          style: ElevatedButton.styleFrom(
                            primary: ColorUtils.text_red  ,
                            onPrimary: ColorUtils.white,
                            padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Dimensions.roundCorner)
                            ),
                            textStyle: TextStyle(
                              color: ColorUtils.white,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 1.8.t,
                              //height: 0
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),

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
