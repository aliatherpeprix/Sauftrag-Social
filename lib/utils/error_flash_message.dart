

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/utils/size_config.dart';

import 'font_utils.dart';
import 'image_utils.dart';


errorFlashMessage(String message, BuildContext context) {
  showFlash(
    context: context,
    duration: Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        margin:
        EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier),
        position: FlashPosition.top,
        backgroundColor: Colors.red,
        behavior: FlashBehavior.floating,
        borderRadius: BorderRadius.circular(20),
        borderColor: Colors.redAccent,
        //boxShadows: [BoxShadow(color: Colors.yellowAccent)],
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(13),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SvgPicture.asset(ImageUtils.raisedFlash),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 2,
                  ),
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontUtils.modernistRegular,
                        fontSize: 2 * SizeConfig.textMultiplier,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}