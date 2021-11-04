
import 'package:flutter/material.dart';
import 'package:sauftrag/utils/color_utils.dart';

class RoundImage extends StatelessWidget {

  final String image;
  final double height, width;

  const RoundImage({Key? key, required this.image, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorUtils.yellow_color)
      ),
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(image)),
            shape: BoxShape.circle
        ),
      ),
    );
  }
}
