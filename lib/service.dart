import 'package:get/get.dart';
import 'package:logintest/app.dart';
import 'package:logintest/base.dart';

class NetworkProvider {
  static Future<dynamic> login({required LoginRequest request}) async {
    try {
      final response = await BaseNetworkProvider.post('token', request.toMap());
      if (response.statusCode == 200) {
        final token = response.data['access'];
        final AppController app = Get.find();
        app.setToken(token);
        return true;
      }
      return false;
    } catch (ex) {
      //
      return false;
    }
  }
}
