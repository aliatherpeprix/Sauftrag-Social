import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart' as path;
import 'package:sauftrag/utils/size_config.dart';

extension MakeUiResponse on BuildContext{
  double screenHeight() {
    return MediaQuery.of(this).size.height.toDouble();
  }
  double screenWidth() {
    return MediaQuery.of(this).size.width.toDouble();
  }
  EdgeInsets getPadding(){
    return MediaQuery.of(this).padding;
  }
  void unFocus(){
    FocusScope.of(this).requestFocus(FocusNode());
  }
}
extension MakeUiResponse1 on num {
  double get h {
    return SizeConfig.heightMultiplier* this;
  }
  double get w {
    return SizeConfig.widthMultiplier* this;
  }
  double get t {
    return SizeConfig.textMultiplier* this;
  }
  double get i {
    return SizeConfig.imageSizeMultiplier* this;
  }
}

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  Future<File> get toFile async{
    final byteData = await rootBundle.load('assets/wallpapers/$this');
    final file = File('${(await path.getTemporaryDirectory()).path}/${this}');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
   DateTime get toParsedDate{
    return DateFormat('yyyy-MMM-dd').parse(this.toString());
  }
}
extension DateExtension on DateTime {
  String get toFormattedDate {
    return DateFormat('yyyy-MMM-dd').format(this);
  }
 
}
