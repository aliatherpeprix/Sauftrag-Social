
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationService {

  navigateTo({required Widget to}){
    StackedService.navigatorKey!.currentState!
        .push(CupertinoPageRoute(builder: (context)=> to));
  }
  back(){
    StackedService.navigatorKey!.currentState!
        .pop();
  }
  navigateToUntil({required Widget to}){
    StackedService.navigatorKey!.currentState!
        .pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=> to),
            (route) => false);
  }
}