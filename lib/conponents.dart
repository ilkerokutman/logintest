import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logintest/app.dart';

class ScaffoldComponent extends StatelessWidget {
  const ScaffoldComponent({
    super.key,
    this.appBar,
    this.body,
    this.fab,
    this.bnb,
  });
  final AppBar? appBar;
  final Widget? body;
  final FloatingActionButton? fab;
  final BottomNavigationBar? bnb;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (ac) {
      return Scaffold(
        appBar: appBar,
        body: ac.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : body,
        floatingActionButton: fab,
        bottomNavigationBar: bnb,
      );
    });
  }
}
