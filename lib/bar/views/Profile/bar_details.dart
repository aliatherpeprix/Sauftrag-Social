import 'dart:io';

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
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class BarDetail extends StatefulWidget {
  const BarDetail({Key? key}) : super(key: key);

  @override
  _BarDetailState createState() => _BarDetailState();
}

class _BarDetailState extends State<BarDetail> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model){
        model.barNameController.text = model.barModel!.bar_name!;
        model.notifyListeners();
      },
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
                              model.barModel!.bar_name!,
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
                              model.imageFiles[1] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[1] is String &&
                                        (model.imageFiles[1] as String).isEmpty) ||
                                        model.imageFiles[1].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[1]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[1] is String &&
                                          (model.imageFiles[1] as String).isEmpty) ||
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
                                      (model.imageFiles[1] is String &&
                                          (model.imageFiles[1] as String).isEmpty) ||
                                          model.imageFiles[1].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(1);
                                            model.imageFiles.insert(1,File(""));
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
                                  ))
                                  :
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.barModel!.profile_picture!),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(1);
                                            model.imageFiles.insert(1, File(""));
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
                              model.imageFiles[2] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[2] is String &&
                                        (model.imageFiles[2] as String).isEmpty) ||
                                        model.imageFiles[2].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[2]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[2] is String &&
                                          (model.imageFiles[2] as String).isEmpty) ||
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
                                      (model.imageFiles[2] is String &&
                                          (model.imageFiles[2] as String).isEmpty) ||
                                          model.imageFiles[2].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(2);
                                            model.imageFiles.insert(2,File(""));
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
                                  ))
                                  :
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.barModel!.profile_picture!),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(2);
                                            model.imageFiles.insert(2, File(""));
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
                              model.imageFiles[3] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[3] is String &&
                                        (model.imageFiles[3] as String).isEmpty) ||
                                        model.imageFiles[3].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[3]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[3] is String &&
                                          (model.imageFiles[3] as String).isEmpty) ||
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
                                      (model.imageFiles[3] is String &&
                                          (model.imageFiles[3] as String).isEmpty) ||
                                          model.imageFiles[3].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(3);
                                            model.imageFiles.insert(3,File(""));
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
                                  ))
                                  :
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.barModel!.profile_picture!),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(3);
                                            model.imageFiles.insert(3, File(""));
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
                              model.imageFiles[4] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[4] is String &&
                                        (model.imageFiles[4] as String).isEmpty) ||
                                        model.imageFiles[4].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[4]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[4] is String &&
                                          (model.imageFiles[4] as String).isEmpty) ||
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
                                      (model.imageFiles[4] is String &&
                                          (model.imageFiles[4] as String).isEmpty) ||
                                          model.imageFiles[4].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(4);
                                            model.imageFiles.insert(4,File(""));
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
                                  ))
                                  :
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.barModel!.profile_picture!),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(4);
                                            model.imageFiles.insert(4, File(""));
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
                              model.imageFiles[5] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[5] is String &&
                                        (model.imageFiles[5] as String).isEmpty) ||
                                        model.imageFiles[5].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[5]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[5] is String &&
                                          (model.imageFiles[5] as String).isEmpty) ||
                                          model.imageFiles[5].path.isEmpty
                                          ? InkWell(
                                          onTap: () {
                                            model.getImage(5);
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
                                      (model.imageFiles[5] is String &&
                                          (model.imageFiles[5] as String).isEmpty) ||
                                          model.imageFiles[5].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(5);
                                            model.imageFiles.insert(5,File(""));
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
                                  ))
                                  :
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.barModel!.profile_picture!),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(5);
                                            model.imageFiles.insert(5, File(""));
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
                              model.imageFiles[1] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[1] is String &&
                                        (model.imageFiles[1] as String).isEmpty) ||
                                        model.imageFiles[1].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[1]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[1] is String &&
                                          (model.imageFiles[1] as String).isEmpty) ||
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
                                      (model.imageFiles[1] is String &&
                                          (model.imageFiles[1] as String).isEmpty) ||
                                          model.imageFiles[1].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(1);
                                            model.imageFiles.insert(1,File(""));
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
                                  ))
                                  :
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.barModel!.profile_picture!),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(1);
                                            model.imageFiles.insert(1, File(""));
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
                              //hintText: "Night Bar",
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
                        SizedBox(height: 4.h),
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(

                            onPressed: ()async{
                              await model.saveBarDetails();
                              model.navigateBack();
                            },
                            child:  model.editProfile == false ? Text("Save") : Loader(),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red,
                              onPrimary: ColorUtils.white,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  Dimensions.containerVerticalPadding),
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
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
