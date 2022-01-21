import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/radler_dialog_box.dart';
import 'package:stacked/stacked.dart';

import 'loader.dart';

class FavoriteDrinkList extends StatefulWidget {

  String title;
  String btnTxt;

  FavoriteDrinkList({Key? key, required this.title, required this.btnTxt, }) : super(key: key);

  @override
  _FavoriteDrinkListState createState() => _FavoriteDrinkListState();
}

class _FavoriteDrinkListState extends State<FavoriteDrinkList> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeShareDialog(),
      builder: (context, model, child){
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            backgroundColor: Colors.white,
            child: WillPopScope(
              onWillPop: ()async{
                if (model.favDrink){
                  return false;
                }
                else {
                  return true;
                }
              },
              child: AbsorbPointer(
                absorbing: model.favDrink,
                child: Stack(
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        IconButton(
                          onPressed: (){
                            model.navigateBack();
                          },
                          iconSize: 15.0,
                          //padding: EdgeInsets.all(20),
                          //constraints: BoxConstraints(),
                          icon: SvgPicture.asset(ImageUtils.cancelIcon),
                        ),

                      ],
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: 3.h),

                            Wrap(
                              spacing: 2.5.w,
                              runSpacing: 1.5.h,
                              direction: Axis.horizontal,
                              children: model.drinkList
                                  .map((element) => ElevatedButton(
                                onPressed: () {
                                  if(model.selectedDrinkList.contains(model.drinkList.indexOf(element))){
                                    model.selectedDrinkList.remove(model.drinkList.indexOf(element));
                                  }
                                  else{
                                    if(element == "Radler"){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                            return RadlerDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                          }
                                      );
                                    }
                                    else{
                                      model.selectedDrinkList.add(model.drinkList.indexOf(element));
                                    }
                                  }
                                  model.notifyListeners();
                                },
                                child: Text(model.drinkList[model.drinkList.indexOf(element)]),
                                style: ElevatedButton.styleFrom(
                                  primary: model.selectedDrinkList.contains(model.drinkList.indexOf(element)) ? ColorUtils.text_red : ColorUtils.white,
                                  onPrimary: model.selectedDrinkList.contains(model.drinkList.indexOf(element)) ? ColorUtils.white : ColorUtils.text_dark,
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 9.w),
                                  elevation: model.selectedDrinkList.contains(model.drinkList.indexOf(element)) ? 5 : 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: model.selectedDrinkList.contains(model.drinkList.indexOf(element)) ? ColorUtils.text_red : ColorUtils.divider,
                                          width: 1
                                      )
                                  ),
                                  textStyle: TextStyle(
                                    //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                    fontFamily: model.selectedDrinkList.contains(model.drinkList.indexOf(element)) ? FontUtils.modernistBold : FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              )).toList(),
                            ),

                            SizedBox(height: 5.h,),
                            Stack(
                              children: [
                                Container(
                                  height: 7.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.containerVerticalPadding,
                                      horizontal:
                                      Dimensions.containerHorizontalPadding),
                                  decoration: BoxDecoration(
                                      color: ColorUtils.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.roundCorner)),
                                      border:
                                      Border.all(color: ColorUtils.divider)),
                                  child: TextField(
                                    focusNode: model.addDrinkFocus,
                                    controller: model.addDrinkController,
                                    keyboardType: TextInputType.text,
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
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5.w),
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  color: ColorUtils.white,
                                  child: Text(
                                    "Add Drink",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: ColorUtils.text_grey,
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.5.t,
                                        height: .4),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5.h,),
                            //Submit
                            SizedBox(
                              width: double.infinity,
                              //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                              child: ElevatedButton(
                                onPressed: () async{
                                  List temp = CommonFunctions.AddFromList(model.selectedDrinkList);
                                  await model.favoritesDrinks(temp, "favorite_alcohol_drinks");
                                  model.navigateBack();
                                },
                                child: model.favDrink == false ? Text("Save") : Loader() ,
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



                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}