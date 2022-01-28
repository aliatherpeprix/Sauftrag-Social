import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/add_dialog_box_clubs.dart';
import 'package:sauftrag/widgets/add_dialog_box_drinks.dart';
import 'package:sauftrag/widgets/add_dialog_box_partyLocations.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/radler_dialog_box.dart';
import 'package:stacked/stacked.dart';

class Favorite extends StatefulWidget {

  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<RegistrationViewModel>.reactive(
      onModelReady: (model) async{
        model.drinkList = await  Addfavorites().GetFavoritesDrink();
        model.clubList = await  Addfavorites().GetFavoritesClub();
        model.vacationList = await  Addfavorites().GetFavoritesPartyVacation();
        model.notifyListeners();
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        SizedBox(height: Dimensions.topMargin),

                        //Favorite Alcoholic Drink
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

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
                                  "Favorite Alcoholic Drink",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 3.t,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),

                            Text(
                              "Favorite alcoholic drink makes it easier to find who shares your interests. Add up to 5 drinks to your profile to make better connections. ",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                            ),
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
                                child: Text((model.drinkList[model.drinkList.indexOf(element)] as FavoritesModel).name ?? ""),
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
                            SizedBox(height: 2.h),
                            // Wrap(
                            //   spacing: 2.5.w,
                            //   runSpacing: 1.5.h,
                            //   direction: Axis.horizontal,
                            //   children: model.addDrinkList
                            //       .map((element) => ElevatedButton(
                            //     onPressed: () {
                            //       if(model.addDrinkList.contains(model.addDrinkList.indexOf(element))){
                            //         model.addDrinkList.remove(model.addDrinkList.indexOf(element));
                            //       }
                            //       else{
                            //           model.addDrinkList.add(FavoritesModel[]);
                            //       }
                            //       model.notifyListeners();
                            //     },
                            //     child: Text(model.addDrinkList.toString()),
                            //     style: ElevatedButton.styleFrom(
                            //       primary: model.addDrinkList.contains(model.addDrinkList.indexOf(element)) ? ColorUtils.text_red : ColorUtils.white,
                            //       onPrimary: model.addDrinkList.contains(model.addDrinkList.indexOf(element)) ? ColorUtils.white : ColorUtils.text_dark,
                            //       padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 9.w),
                            //       elevation: model.addDrinkList.contains(model.addDrinkList.indexOf(element)) ? 5 : 0,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                            //           side: BorderSide(
                            //               color: model.addDrinkList.contains(model.addDrinkList.indexOf(element)) ? ColorUtils.text_red : ColorUtils.divider,
                            //               width: 1
                            //           )
                            //       ),
                            //       textStyle: TextStyle(
                            //         //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                            //         fontFamily: model.addDrinkList.contains(model.addDrinkList.indexOf(element)) ? FontUtils.modernistBold : FontUtils.modernistRegular,
                            //         fontSize: 1.8.t,
                            //         //height: 0
                            //       ),
                            //     ),
                            //   )).toList(),
                            // ),

                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AddDialogBox(title: "Add New Drink", btnTxt: "Add Drink", icon: ImageUtils.addDrinkIcon);
                                    }
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  SvgPicture.asset(ImageUtils.addDrinkIcon),

                                  SizedBox(width: 10),

                                  Text("Add Drink")
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),

                        //Favorite Night Clubs
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Favorite Night Clubs",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                            SizedBox(height: 2.h),

                            Text(
                              "What are your favorite night clubs & bars. Add location to your profile to make better connections.",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                            ),
                            SizedBox(height: 3.h),

                            MediaQuery.removePadding(
                              removeTop: true,
                              removeBottom: true,
                              context: context,
                              child: GridView.builder(
                                itemCount: model.clubList.length,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.5,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15
                                ),
                                itemBuilder: (BuildContext context, int index){
                                  return ElevatedButton(
                                    onPressed: () {
                                      if(model.selectedClubList.contains(index)){
                                        model.selectedClubList.remove(index);
                                      }
                                      else{
                                        model.selectedClubList.add(index);
                                      }
                                      model.notifyListeners();
                                    },
                                    child:  Text((model.clubList[index] as FavoritesModel).name ?? ""),
                                    //Text(model.clubList[index]),
                                    style: ElevatedButton.styleFrom(
                                      primary: model.selectedClubList.contains(index) ? ColorUtils.text_red : ColorUtils.white,
                                      onPrimary: model.selectedClubList.contains(index) ? ColorUtils.white : ColorUtils.text_dark,
                                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                                      elevation: model.selectedClubList.contains(index) ? 5 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                          side: BorderSide(
                                              color: model.selectedClubList.contains(index) ? ColorUtils.text_red : ColorUtils.divider,
                                              width: 1
                                          )
                                      ),
                                      textStyle: TextStyle(
                                        //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                        fontFamily: model.selectedClubList.contains(index) ? FontUtils.modernistBold : FontUtils.modernistRegular,
                                        fontSize: 1.8.t,
                                        //height: 0
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 2.h),

                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AddDialogBoxClubs(title: "Add New Club", btnTxt: "Add Club", icon: ImageUtils.addClubIcon);
                                    }
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  SvgPicture.asset(ImageUtils.addClubIcon),

                                  SizedBox(width: 10),

                                  Text("Add Club")
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),

                        //Favorite Party Vacation
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Favorite Party Vacation",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                            SizedBox(height: 2.h),

                            Text(
                              "Where do you like to do party vacation. Add location to your profile to make better connections.",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                            ),
                            SizedBox(height: 3.h),

                            Wrap(
                              spacing: 2.5.w,
                              runSpacing: 1.5.h,
                              direction: Axis.horizontal,
                              children: model.vacationList
                                  .map((element) => ElevatedButton(
                                onPressed: () {
                                  if(model.selectedVacationList.contains(model.vacationList.indexOf(element))){
                                    model.selectedVacationList.remove(model.vacationList.indexOf(element));
                                  }
                                  else{
                                    model.selectedVacationList.add(model.vacationList.indexOf(element));
                                  }
                                  model.notifyListeners();
                                },
                                child: Text((model.vacationList[model.vacationList.indexOf(element)] as FavoritesModel).name ?? ""),
                                //Text(model.vacationList[model.vacationList.indexOf(element)]),
                                style: ElevatedButton.styleFrom(
                                  primary: model.selectedVacationList.contains(model.vacationList.indexOf(element)) ? ColorUtils.text_red : ColorUtils.white,
                                  onPrimary: model.selectedVacationList.contains(model.vacationList.indexOf(element)) ? ColorUtils.white : ColorUtils.text_dark,
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 9.w),
                                  elevation: model.selectedVacationList.contains(model.vacationList.indexOf(element)) ? 5 : 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: model.selectedVacationList.contains(model.vacationList.indexOf(element)) ? ColorUtils.text_red : ColorUtils.divider,
                                          width: 1
                                      )
                                  ),
                                  textStyle: TextStyle(
                                    //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                    fontFamily: model.selectedVacationList.contains(model.vacationList.indexOf(element)) ? FontUtils.modernistBold : FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              )).toList(),
                            ),
                            SizedBox(height: 2.h),

                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AddDialogBoxPartyLocation(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                    }
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  SvgPicture.asset(ImageUtils.addLocationIcon),

                                  SizedBox(width: 10),

                                  Text("Add Location")
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),

                        //Next Button
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              model.favorites();
                              //model.navigateToMediaScreen();
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
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
    );
  }
}
