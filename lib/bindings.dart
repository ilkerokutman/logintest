import 'package:get/get.dart';
import 'package:logintest/app.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() async => AppController(), permanent: true);
  }
}
