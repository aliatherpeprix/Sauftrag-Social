import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/utils/extensions.dart';

import 'color_utils.dart';
import 'font_utils.dart';
import 'image_utils.dart';

class CommonFunctions{

  static bool hasOneUpperCase(String password){
    String  pattern = r'^(?=.*?[A-Z]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool hasOneLowerCase(String password){
    String  pattern = r'^(?=.*?[a-z]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool hasOneDigit(String password){
    String  pattern = r'^(?=.*?[0-9]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool  hasOneSpeicalCharacter(String password){
    String  pattern = r'^(?=.*?[_%=?.!@#\$&*~]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool isValidPassword(String password){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool isValidLength(String password){
    return password.length>=8;
  }
  static bool isValidEmail(String email){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return true;
    }else{
      return false;
    }
  }
  static bool isValidUserName(String userName){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userName)){
      return true;
    }else{
      return false;
    }
  }

  static Future showDateOfBirthPicker(BuildContext context,DateTime initialDate) {
    DateTime selectedDateTime;
    initialDate = initialDate==null ? DateTime.now() : initialDate;
    DateTime maxDateTime = DateTime.now();
    selectedDateTime = maxDateTime;
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context){
      return Container(
        //height: ScreenUtil.getInstance().height*.35,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [

           // Image.asset(ImageUtils.hazrin_logo, height: 10.i, width: 10.i),
            Expanded(
              child: Center(
                child: CupertinoTheme(
                  child: CupertinoDatePicker(
                    dateOrder: DatePickerDateOrder.ymd,
                    mode: CupertinoDatePickerMode.date,
                    maximumDate:  maxDateTime,
                    minimumDate: DateTime.now().subtract(Duration(days: 365*100)),
                    initialDateTime: initialDate,
                    onDateTimeChanged: (DateTime dateTime) {
                      selectedDateTime = dateTime;
                    },
                  ),
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                          color: ColorUtils.red_color,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.t
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedDateTime);
              },
              child: Text('Done'),
              style: ElevatedButton.styleFrom(
                primary: ColorUtils.red_color,
                onPrimary: ColorUtils.white,
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                textStyle: TextStyle(
                  color: ColorUtils.white,
                  fontFamily: FontUtils.modernistBold,
                  fontSize: 1.8.t,
                  //height: 0
                ),
              ),
            ),
            //SizedBox(height: 2.h)
          ],
        ),
      );
    },
        isDismissible: true);
  }

  static Future showEventDatePicker(BuildContext context,DateTime initialDate) {
    DateTime selectedDateTime;
    initialDate = initialDate==null ? DateTime.now() : initialDate;
    // DateTime maxDateTime = DateTime.now();
    // selectedDateTime = maxDateTime;
    DateTime minDateTime = DateTime.now();
    selectedDateTime = minDateTime;
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context){
          return Container(
            //height: ScreenUtil.getInstance().height*.35,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: CupertinoTheme(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                      // minimumDate: minDateTime,
                        //maximumDate:  maxDateTime,
                        //minimumDate: DateTime.now().subtract(Duration(days: 365*100)),
                        initialDateTime: initialDate,
                        onDateTimeChanged: (DateTime dateTime) {
                          selectedDateTime = dateTime;
                        },
                      ),
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              color: ColorUtils.red_color,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.t
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedDateTime);
                  },
                  child: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    primary: ColorUtils.red_color,
                    onPrimary: ColorUtils.white,
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    textStyle: TextStyle(
                      color: ColorUtils.white,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 1.8.t,
                      //height: 0
                    ),
                  ),
                ),
                //SizedBox(height: 2.h)
              ],
            ),
          );
        },
        isDismissible: true);
  }

  static Future showExpiryPicker(BuildContext context,DateTime initialDate) {
    DateTime selectedDateTime;
    //initialDate = initialDate==null ? DateTime.now() : initialDate;
    initialDate = DateTime.now();
    DateTime minDateTime = DateTime.now();
    selectedDateTime = minDateTime;
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context){
          return Container(
            //height: ScreenUtil.getInstance().height*.35,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [

               // Image.asset(ImageUtils.hazrin_logo, height: 10.i, width: 10.i),
                Expanded(
                  child: Center(
                    child: CupertinoTheme(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        //maximumDate:  minDateTime,
                        //minimumDate: DateTime.now().subtract(Duration(days: 365*100)),
                        minimumDate: DateTime.now().subtract(Duration(minutes: 1)),
                        initialDateTime: initialDate,
                        onDateTimeChanged: (DateTime dateTime) {
                          selectedDateTime = dateTime;
                        },
                      ),
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              color: ColorUtils.red_color,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.t
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedDateTime);
                  },
                  child: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    primary: ColorUtils.red_color  ,
                    onPrimary: ColorUtils.white,
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    textStyle: TextStyle(
                      color: ColorUtils.white,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 1.8.t,
                      //height: 0
                    ),
                  ),
                ),
                //SizedBox(height: 2.h)
              ],
            ),
          );
        },
        isDismissible: true);
  }

  static bool isAdult(String birthDateString) {
    String datePattern = "MM-dd-yyyy";

    // Current time - at this moment
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isBefore(today);
  }

  static List<int> SubtractFromList(List data) {
    List<int> temp = [];
    for (int number in data) {
      temp.add(number - 1);
    }
    return temp;
  }

  static List<int> AddFromList(List data){
    List<int> temp = [];
    for (int number in data){
      temp.add(number+1);
    }
    return temp;
  }
}



extension contextExtensions on BuildContext {
  void unFocus(){
    FocusScope.of(this).requestFocus(FocusNode());
  }
}