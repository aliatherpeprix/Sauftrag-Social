import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../utils/color_utils.dart';
import '../utils/dimensions.dart';
import '../viewModels/main_view_model.dart';

class ServerError extends StatefulWidget {
  const ServerError({Key? key}) : super(key: key);

  @override
  _ServerErrorState createState() => _ServerErrorState();
}

class _ServerErrorState extends State<ServerError> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   title: Container(
          //     child: Text(
          //       "Notifications",
          //       style: TextStyle(
          //           color: Colors.black, fontSize: 2.5.t, fontFamily: FontUtils.modernistBold),
          //     ),
          //   ),
          // ),
          backgroundColor: Colors.white,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.topMargin),
                  Container(
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: Dimensions.horizontalPadding,
                    // ),
                    child:  IconButton(
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
                  ),
                  Center(
                    heightFactor: 0.35.h ,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, ),
                        child: Image.asset(ImageUtils.internalServer)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
