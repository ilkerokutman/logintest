import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:logintest/app.dart';

class HomeMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  @override
  RouteSettings? redirect(String? route) {
    AppController app = Get.find();

    if (app.token == null || app.token!.isEmpty) {
      return RouteSettings(name: '/login');
    }

    //

    return null;
  }
}
