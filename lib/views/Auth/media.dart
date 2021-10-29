import 'package:dotted_border/dotted_border.dart';
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

class Media extends StatefulWidget {

  const Media({Key? key}) : super(key: key);

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {

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
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: Dimensions.topMargin),

                        //Add Images
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            IconButton(
                                onPressed: (){
                                  model.navigateBack();
                                },
                                iconSize: 18.0,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.arrow_back_ios, color: ColorUtils.black,)
                            ),
                            SizedBox(width: 2.w),

                            Text(
                              "Add Images",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.5.t,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),

                        Text(
                          "Add up to 6 images to your profile for better match.",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.8.t,
                          ),
                        ),
                        SizedBox(height: 6.h),

                        //Images
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              //Image 1
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  image: model.imageFiles[0].path.isEmpty ? null : DecorationImage(image: FileImage(model.imageFiles[0]), fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [

                                    model.imageFiles[0].path.isEmpty ? InkWell(
                                        onTap: (){
                                          model.getImage(0);
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
                                                color: ColorUtils.text_red,
                                                size: 8.i,
                                              ),
                                            )
                                        )
                                    )  : Container(),

                                    model.imageFiles[0].path.isEmpty ? Container() : Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: (){
                                          model.imageFiles.removeAt(0);
                                          model.notifyListeners();
                                        },
                                        icon: SvgPicture.asset(ImageUtils.cancelIcon),
                                        //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: ColorUtils.white,
                                        highlightColor: ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                )
                              ),

                              //Image 2
                              Container(
                                  width: MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[1].path.isEmpty ? null : DecorationImage(image: FileImage(model.imageFiles[1]), fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [

                                      model.imageFiles[1].path.isEmpty ? InkWell(
                                          onTap: (){
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
                                                  color: ColorUtils.text_red,
                                                  size: 8.i,
                                                ),
                                              )
                                          )
                                      )  : Container(),

                                      model.imageFiles[1].path.isEmpty ? Container() : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: (){
                                            model.imageFiles.removeAt(1);
                                            model.notifyListeners();
                                          },
                                          icon: SvgPicture.asset(ImageUtils.cancelIcon),
                                          //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          color: ColorUtils.white,
                                          highlightColor: ColorUtils.white,
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                              //Image 3
                              Container(
                                  width: MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[2].path.isEmpty ? null : DecorationImage(image: FileImage(model.imageFiles[2]), fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [

                                      model.imageFiles[2].path.isEmpty ? InkWell(
                                          onTap: (){
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
                                                  color: ColorUtils.text_red,
                                                  size: 8.i,
                                                ),
                                              )
                                          )
                                      )  : Container(),

                                      model.imageFiles[2].path.isEmpty ? Container() : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: (){
                                            model.imageFiles.removeAt(0);
                                            model.notifyListeners();
                                          },
                                          icon: SvgPicture.asset(ImageUtils.cancelIcon),
                                          //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          color: ColorUtils.white,
                                          highlightColor: ColorUtils.white,
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),

                        //Images
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              //Image 4
                              Container(
                                  width: MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[3].path.isEmpty ? null : DecorationImage(image: FileImage(model.imageFiles[3]), fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [

                                      model.imageFiles[3].path.isEmpty ? InkWell(
                                          onTap: (){
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
                                                  color: ColorUtils.text_red,
                                                  size: 8.i,
                                                ),
                                              )
                                          )
                                      )  : Container(),

                                      model.imageFiles[3].path.isEmpty ? Container() : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: (){
                                            model.imageFiles.removeAt(3);
                                            model.notifyListeners();
                                          },
                                          icon: SvgPicture.asset(ImageUtils.cancelIcon),
                                          //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          color: ColorUtils.white,
                                          highlightColor: ColorUtils.white,
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                              //Image 5
                              Container(
                                  width: MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[4].path.isEmpty ? null : DecorationImage(image: FileImage(model.imageFiles[4]), fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [

                                      model.imageFiles[4].path.isEmpty ? InkWell(
                                          onTap: (){
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
                                                  color: ColorUtils.text_red,
                                                  size: 8.i,
                                                ),
                                              )
                                          )
                                      )  : Container(),

                                      model.imageFiles[4].path.isEmpty ? Container() : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: (){
                                            model.imageFiles.removeAt(4);
                                            model.notifyListeners();
                                          },
                                          icon: SvgPicture.asset(ImageUtils.cancelIcon),
                                          //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          color: ColorUtils.white,
                                          highlightColor: ColorUtils.white,
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                              //Image 6
                              Container(
                                  width: MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: model.imageFiles[5].path.isEmpty ? null : DecorationImage(image: FileImage(model.imageFiles[5]), fit: BoxFit.cover),
                                  ),
                                  child: Stack(
                                    children: [

                                      model.imageFiles[5].path.isEmpty ? InkWell(
                                          onTap: (){
                                            model.getImage(5);
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
                                                  color: ColorUtils.text_red,
                                                  size: 8.i,
                                                ),
                                              )
                                          )
                                      )  : Container(),

                                      model.imageFiles[5].path.isEmpty ? Container() : Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: (){
                                            model.imageFiles.removeAt(5);
                                            model.notifyListeners();
                                          },
                                          icon: SvgPicture.asset(ImageUtils.cancelIcon),
                                          //icon: Icon(Icons.cancel_outlined, color: ColorUtils.text_red,),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          color: ColorUtils.white,
                                          highlightColor: ColorUtils.white,
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),

                        //Next Button
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.navigateToTermsScreen();
                            },
                            child: const Text("Next"),
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
                )
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
