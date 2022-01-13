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
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class BarDetail extends StatefulWidget {
  const BarDetail({Key? key}) : super(key: key);

  @override
  _BarDetailState createState() => _BarDetailState();
}

class _BarDetailState extends State<BarDetail> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            bottom: false,
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                    //    vertical: Dimensions.verticalPadding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.topMargin),

                        //Add Images
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
                              "Jenny Sandals",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),

                        //Images
                        SizedBox(
                          height: 17.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Image 1
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
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
                                                      size: 8.i,
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
                                      MediaQuery.of(context).size.width / 3.4,
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
                                                      size: 8.i,
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
                                      MediaQuery.of(context).size.width / 3.4,
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
                                                      size: 8.i,
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
                        SizedBox(height: 3.h),

                        //Images
                        SizedBox(
                          height: 17.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Image 4
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[3].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[3]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[3].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(3);
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
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[3].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(3);
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
                              SizedBox(width: 2.5.w),
                              //Image 5
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[4].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[4]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[4].path.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                model.getImage(4);
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
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[4].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(4);
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

                        SizedBox(height: 5.h),
                        Text(
                          "Bar Logo",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.5.t,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Image 1
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[5].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                            image:
                                                FileImage(model.imageFiles[5]),
                                            fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[5].path.isEmpty
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
                                                      size: 8.i,
                                                    ),
                                                  )))
                                          : Container(),
                                      model.imageFiles[5].path.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  model.imageFiles.removeAt(5);
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
                        SizedBox(height: 3.h),
                        Text(
                          "About Me",
                          style: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                              color: ColorUtils.blackText),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          decoration: BoxDecoration(
                            color: ColorUtils.searchFieldColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            // border: Border.all(color: ColorUtils.icon_color)
                          ),
                          child: TextField(
                            onTap: () {},
                            enabled: true,
                            //readOnly: true,
                            //focusNode: model.searchFocus,
                            controller: model.aboutMeController,
                            decoration: InputDecoration(
                              hintText: "About Me",
                              hintStyle: TextStyle(
                                fontFamily: FontUtils.modernistRegular,
                                color: ColorUtils.icon_color,
                                fontSize: SizeConfig.textMultiplier * 1.9,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.heightMultiplier * 1.9),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Bar Name",
                          style: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                              color: ColorUtils.blackText),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              border: Border.all(color: ColorUtils.red_color)),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              color: ColorUtils.red_color,
                              fontSize: SizeConfig.textMultiplier * 1.9,
                            ),
                            onTap: () {},
                            enabled: true,
                            //readOnly: true,
                            //focusNode: model.searchFocus,
                            controller: model.barNameController,
                            decoration: InputDecoration(
                              hintText: "Night Bar",
                              hintStyle: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                color: ColorUtils.red_color,
                                fontSize: SizeConfig.textMultiplier * 1.9,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.heightMultiplier * 1.9),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
