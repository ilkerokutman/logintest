import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logintest/app.dart';
import 'package:logintest/bindings.dart';
import 'package:logintest/conponents.dart';
import 'package:logintest/middleware.dart';

void main() async {
  await GetStorage.init();
  await AwaitBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: AwaitBindings(),
        initialRoute: '/home',
        getPages: [
          GetPage(
            name: '/home',
            page: () => MyHomeScreen(),
            middlewares: [HomeMiddleware()],
          ),
          GetPage(
            name: '/login',
            page: () => LoginScreen(),
          ),
        ]);
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (ac) {
      return ScaffoldComponent(
        body: Text("Token: ${ac.token}"),
      );
    });
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppController appController = Get.find();
  late TextEditingController userController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldComponent(
      body: Column(children: [
        TextField(
          controller: userController,
        ),
        TextField(
          controller: passController,
        ),
        ElevatedButton(onPressed: submit, child: Text("Login")),
      ]),
    );
  }

  Future<void> submit() async {
    //
    LoginRequest request = LoginRequest(
      username: userController.text,
      password: passController.text,
    );
//validate

    appController.setLoading(true);
    bool result = await appController.login(request);
    await Future.delayed(Duration(seconds: 4));
    appController.setLoading(false);
    if (result) {
      Get.offAllNamed('/home');
    } else {
      //hata
      print("hata var");
    }
  }
}
