import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logintest/service.dart';

class Test {
  String name;
  List<String> names;
}

class AppController extends GetxController {
  //

  final Rxn<Test> _test = Rxn();
  Test? get test => _test.value;

  Test a = test;
  a.names.first = "asdf";

  _test.value = a;
  

  @override
  void onReady() {
    final box = GetStorage();
    _token.value = box.read('token');
    update();
    super.onReady();
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void setLoading(bool b) {
    _isLoading.value = b;
    update();
  }

  final RxnString _token = RxnString();
  String? get token => _token.value;

  void setToken(String? t) async {
    _token.value = t;
    update();
    final box = GetStorage();
    await box.write('token', t);
  }

  Future<bool> login(LoginRequest request) async {
    var result = await NetworkProvider.login(request: request);

    return result;
  }
}

class LoginRequest {
  String username;
  String password;
  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));
}
