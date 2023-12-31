import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashController extends GetxController {
  RxBool animate = RxBool(true);

  @override
  void onInit() {
    splash();
    super.onInit();
  }

  void splash() {
    Future.delayed(
      const Duration(seconds: 6),
      () {
        checkConnectionAndNavigate();
      },
    );
  }

  void checkConnectionAndNavigate() async {
    if (await checkConnection()) {
      Get.offAllNamed(AppStrings.navBarRout);
    } else {
      Future.delayed(
        const Duration(seconds: 6),
        () {
          checkConnectionAndNavigate();
          AppDefaults.defaultToast(AppStrings.connectionErrorToast);
        },
      );
    }
  }

  Future<bool> checkConnection() async {
    var connection = await InternetConnectionChecker().hasConnection;
    bool isConnected = false;
    connection ? isConnected = true : isConnected = false;
    return isConnected;
  }
}
