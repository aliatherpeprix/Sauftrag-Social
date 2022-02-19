import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class RequestedPeople extends StatefulWidget {
  const RequestedPeople({Key? key}) : super(key: key);

  @override
  _RequestedPeopleState createState() => _RequestedPeopleState();
}

class _RequestedPeopleState extends State<RequestedPeople> {
  List matchedImg = [
    {'image': ImageUtils.matchedImg1, 'title': 'Leona Mathis'},
    {'image': ImageUtils.matchedImg2, 'title': 'Josefina Ward'},
    {'image': ImageUtils.matchedImg3, 'title': 'Andre Patterson'},
    {'image': ImageUtils.matchedImg4, 'title': 'Nick Hoffman'},
    {'image': ImageUtils.matchedImg5, 'title': 'Henrietta Hall'},
    {'image': ImageUtils.matchedImg6, 'title': 'Hazel Ballard'},
  ];
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
              bottom: false,
              child: Scaffold(
                  backgroundColor: ColorUtils.white,
                  body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        margin: EdgeInsets.only(left: 5.w),
                        child: GridView.builder(
                          itemCount: matchedImg.length,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  // childAspectRatio: 2.5,
                                  crossAxisCount: 2,
                                  // crossAxisSpacing: 2,
                                  mainAxisSpacing: 30),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                model.navigateToFollowerList();
                              },
                              child: Stack(
                                children: [
                                  Image.asset(
                                    matchedImg[index]['image'],
                                  ),
                                  PositionedDirectional(
                                      bottom: 0,
                                      child: Container(
                                        width: 34.5.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.7),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.2.h, horizontal: 2.w),
                                        child: Text(
                                          matchedImg[index]['title'],
                                          style: TextStyle(
                                              color: ColorUtils.white),
                                        ),
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      )))),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
