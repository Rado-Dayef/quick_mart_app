import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_pages.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/utils/binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (builder, child) {
        return GetMaterialApp(
          initialBinding: Binding(),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontFamily: AppStrings.timesFont,
              ),
              elevation: 0,
              backgroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15.sp),
                ),
              ),
            ),
            fontFamily: AppStrings.timesFont,
            canvasColor: AppColors.white,
            primarySwatch: AppColors.defaultColor,
            highlightColor: AppColors.transparent,
            splashColor: AppColors.transparent,
          ),
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          initialRoute: FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified ? AppStrings.splashRout : AppStrings.loginRout,
          getPages: AppPages.appPages(),
        );
      },
    );
  }
}
