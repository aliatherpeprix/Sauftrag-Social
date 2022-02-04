
import 'package:flutter/material.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';

class AllPageLoader extends StatelessWidget {
  const AllPageLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          height: 10.i,width: 10.i,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorUtils.red_color),
          ),
        ),
      ),
    );
  }
}