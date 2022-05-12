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

        // model.notifyListeners();
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: model.isUserProfile == true ? Loader() :
          SafeArea(
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
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.7,
                              crossAxisCount: 3,
                              mainAxisSpacing: 1.5*SizeConfig.widthMultiplier,
                              //childAspectRatio: 1,
                              crossAxisSpacing: 1*SizeConfig.widthMultiplier),
                          itemBuilder: (context, index) {
                            if (model.imageFiles[index] is File)
                              return Container(
                                  padding: EdgeInsets.all(4.0),
                                  //height: 20.h,
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image:
                                    model.imageFiles[index].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[index]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      model.imageFiles[index].path.isEmpty
                                          ? InkWell(
                                          onTap: () {
                                            if (index != 0) {
                                              if (model.imageFiles[index -1] is String ||
                                              (model.imageFiles[index -1] as File)
                                                  .path.isNotEmpty) {
                                                model.getImage(index);
                                                model
                                                    .notifyListeners();
                                              }
                                            }
                                            else {
                                              model.getImage(index);
                                              model
                                                  .notifyListeners();
                                            }
                                          },
                                          child: DottedBorder(
                                              color: index != 0 ?
                                                  model.imageFiles[index -1] is File ?
                                              (model.imageFiles[index -1] as File).path.isNotEmpty
                                                  ? ColorUtils.text_red
                                                     : ColorUtils.text_grey
                                                       :ColorUtils.text_red
                                                          :ColorUtils.text_red,
                                              strokeWidth: 1.5,
                                              borderType: BorderType.RRect,
                                              radius:
                                              const Radius.circular(15),
                                              dashPattern: [8],
                                              child: Center(
                                                child: Icon(
                                                  Icons.add_rounded,
                                                  color: index != 0 ?
                                                     model.imageFiles[index -1] is File ?
                                                  (model.imageFiles[index -1] as File)
                                                      .path.isNotEmpty
                                                      ?ColorUtils.text_red
                                                      :ColorUtils.text_grey
                                                         :ColorUtils.text_red
                                                            : ColorUtils.text_red,
                                                  size: 8.i,
                                                ),
                                              )))
                                          : Container(),
                                      model.imageFiles[index].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(index);
                                            model.imageFiles.add(File(""));
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
                                  ));
                            else {
                              return Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(model.imageFiles[index]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(index);
                                            model.imageFiles.add(File(""));
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
                                  ));
                            }
                          },),
                        // SizedBox(height: 3.h),
                        //
                        // //Images
                        // SizedBox(
                        //   height: 17.h,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //
                        //
                        //       //Image 3
                        //       model.imageFiles[3] is File
                        //           ?
                        //       Container(
                        //           width:
                        //           MediaQuery.of(context).size.width / 3.4,
                        //           decoration: BoxDecoration(
                        //             borderRadius:
                        //             BorderRadius.all(Radius.circular(20)),
                        //             image: (model.imageFiles[3] is String &&
                        //                 (model.imageFiles[3] as String).isEmpty) ||
                        //                 model.imageFiles[3].path.isEmpty
                        //                 ? null
                        //                 : DecorationImage(
                        //                 image:
                        //                 FileImage(model.imageFiles[3]),
                        //                 fit: BoxFit.cover),
                        //           ),
                        //           child: Stack(
                        //             children: [
                        //               (model.imageFiles[3] is String &&
                        //                   (model.imageFiles[3] as String).isEmpty) ||
                        //                   model.imageFiles[3].path.isEmpty
                        //                   ? InkWell(
                        //                   onTap: () {
                        //                     model.getImage(3);
                        //                     model.notifyListeners();
                        //                   },
                        //                   child: DottedBorder(
                        //                       color: ColorUtils.text_red,
                        //                       strokeWidth: 1.5,
                        //                       borderType: BorderType.RRect,
                        //                       radius:
                        //                       const Radius.circular(15),
                        //                       dashPattern: [8],
                        //                       child: Center(
                        //                         child: Icon(
                        //                           Icons.add_rounded,
                        //                           color:
                        //                           ColorUtils.text_red,
                        //                           size: 8.i,
                        //                         ),
                        //                       )))
                        //                   : Container(),
                        //               (model.imageFiles[3] is String &&
                        //                   (model.imageFiles[3] as String).isEmpty) ||
                        //                   model.imageFiles[3].path.isEmpty
                        //                   ? Container()
                        //                   : Align(
                        //                 alignment: Alignment.bottomRight,
                        //                 child: IconButton(
                        //                   onPressed: () {
                        //                     model.imageFiles.removeAt(3);
                        //                     model.imageFiles.insert(3, File(""));
                        //                     model.notifyListeners();
                        //                   },
                        //                   icon: SvgPicture.asset(
                        //                       ImageUtils.cancelIcon),
                        //                   //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                        //                   padding: EdgeInsets.zero,
                        //                   constraints: BoxConstraints(),
                        //                   color: ColorUtils.white,
                        //                   highlightColor:
                        //                   ColorUtils.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ))
                        //           :
                        //       Container(
                        //           width:
                        //           MediaQuery.of(context).size.width / 3.4,
                        //           decoration: BoxDecoration(
                        //             borderRadius:
                        //             BorderRadius.all(Radius.circular(20)),
                        //             image: DecorationImage(
                        //                 image:
                        //                 NetworkImage(model.imageFiles[3]),
                        //                 fit: BoxFit.cover),
                        //           ),
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.bottomRight,
                        //                 child: IconButton(
                        //                   onPressed: () {
                        //                     model.imageFiles.removeAt(3);
                        //                     model.imageFiles.insert(3, File(""));
                        //                     model.notifyListeners();
                        //                   },
                        //                   icon: SvgPicture.asset(
                        //                       ImageUtils.cancelIcon),
                        //                   //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                        //                   padding: EdgeInsets.zero,
                        //                   constraints: BoxConstraints(),
                        //                   color: ColorUtils.white,
                        //                   highlightColor:
                        //                   ColorUtils.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           )),
                        //
                        //       SizedBox(width: 2.w,),
                        //       //Image 4
                        //       model.imageFiles[4] is File
                        //           ?
                        //       Container(
                        //           width:
                        //           MediaQuery.of(context).size.width / 3.4,
                        //           decoration: BoxDecoration(
                        //             borderRadius:
                        //             BorderRadius.all(Radius.circular(20)),
                        //             image: (model.imageFiles[4] is String &&
                        //                 (model.imageFiles[4] as String).isEmpty) ||
                        //                 model.imageFiles[4].path.isEmpty
                        //                 ? null
                        //                 : DecorationImage(
                        //                 image:
                        //                 FileImage(model.imageFiles[4]),
                        //                 fit: BoxFit.cover),
                        //           ),
                        //           child: Stack(
                        //             children: [
                        //               (model.imageFiles[4] is String &&
                        //                   (model.imageFiles[4] as String).isEmpty) ||
                        //                   model.imageFiles[4].path.isEmpty
                        //                   ? InkWell(
                        //                   onTap: () {
                        //                     model.getImage(4);
                        //                     model.notifyListeners();
                        //                   },
                        //                   child: DottedBorder(
                        //                       color: ColorUtils.text_red,
                        //                       strokeWidth: 1.5,
                        //                       borderType: BorderType.RRect,
                        //                       radius:
                        //                       const Radius.circular(15),
                        //                       dashPattern: [8],
                        //                       child: Center(
                        //                         child: Icon(
                        //                           Icons.add_rounded,
                        //                           color:
                        //                           ColorUtils.text_red,
                        //                           size: 8.i,
                        //                         ),
                        //                       )))
                        //                   : Container(),
                        //               (model.imageFiles[4] is String &&
                        //                   (model.imageFiles[4] as String).isEmpty) ||
                        //                   model.imageFiles[4].path.isEmpty
                        //                   ? Container()
                        //                   : Align(
                        //                 alignment: Alignment.bottomRight,
                        //                 child: IconButton(
                        //                   onPressed: () {
                        //                     model.imageFiles.removeAt(4);
                        //                     model.imageFiles.insert(4, File(""));
                        //                     model.notifyListeners();
                        //                   },
                        //                   icon: SvgPicture.asset(
                        //                       ImageUtils.cancelIcon),
                        //                   //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                        //                   padding: EdgeInsets.zero,
                        //                   constraints: BoxConstraints(),
                        //                   color: ColorUtils.white,
                        //                   highlightColor:
                        //                   ColorUtils.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ))
                        //           :
                        //       Container(
                        //           width:
                        //           MediaQuery.of(context).size.width / 3.4,
                        //           decoration: BoxDecoration(
                        //             borderRadius:
                        //             BorderRadius.all(Radius.circular(20)),
                        //             image: DecorationImage(
                        //                 image:
                        //                 NetworkImage(model.imageFiles[4]),
                        //                 fit: BoxFit.cover),
                        //           ),
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.bottomRight,
                        //                 child: IconButton(
                        //                   onPressed: () {
                        //                     model.imageFiles.removeAt(4);
                        //                     model.imageFiles.insert(4, File(""));
                        //                     model.notifyListeners();
                        //                   },
                        //                   icon: SvgPicture.asset(
                        //                       ImageUtils.cancelIcon),
                        //                   //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                        //                   padding: EdgeInsets.zero,
                        //                   constraints: BoxConstraints(),
                        //                   color: ColorUtils.white,
                        //                   highlightColor:
                        //                   ColorUtils.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           )),
                        //
                        //
                        //     ],
                        //   ),
                        // ),

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
                              //Image 5
                              model.imageFiles[0] is File
                                  ?
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    image: (model.imageFiles[0] is String &&
                                        (model.imageFiles[0] as String).isEmpty) ||
                                        model.imageFiles[0].path.isEmpty
                                        ? null
                                        : DecorationImage(
                                        image:
                                        FileImage(model.imageFiles[0]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      (model.imageFiles[0] is String &&
                                          (model.imageFiles[0] as String).isEmpty) ||
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
                                      (model.imageFiles[0] is String &&
                                          (model.imageFiles[0] as String).isEmpty) ||
                                          model.imageFiles[0].path.isEmpty
                                          ? Container()
                                          : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(0);
                                            model.imageFiles.insert(0, File(""));
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
                                        NetworkImage(model.imageFiles[0]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            model.imageFiles.removeAt(0);
                                            model.imageFiles.insert(0, File(""));
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
                        SizedBox(height: 2.h),
                        Text(
                          "About",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.2.t,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          //height: 15.h,
                          constraints: BoxConstraints(maxHeight: 100),
                          padding: EdgeInsets.symmetric(
                              vertical:
                              Dimensions.containerVerticalPadding,
                              horizontal: Dimensions
                                  .containerHorizontalPadding),
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      Dimensions.roundCorner)),
                              border: Border.all(
                                  color: ColorUtils.divider)),
                          child: TextField(
                            //focusNode: model.signUpUserAboutFocus,
                            controller: model.updateBarAbout,
                            //obscureText: !model.signupEmailVisible,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              color: ColorUtils.red_color,
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.9.t,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                            ),
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: 6.h),

                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(

                            onPressed: ()async{
                              await model.saveBarDetails();
                              //model.navigateBack();
                            },
                            child:  model.editProfile == false ? Text("Save") : Loader(),
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
