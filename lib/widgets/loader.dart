
import 'package:flutter/material.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';


class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          height: 5.i,width: 5.i,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(.6)),
          ),
        ),
      ),
    );
    return  Container(
      child: Center(
        child: SizedBox(
          height: 5.h,width: 10.w,
          child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorUtils.red_color),
          ),
        ),
      ),
    );
  }
}
