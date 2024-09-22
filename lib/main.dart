import 'package:flutter/material.dart';
import 'package:travel_app_getx/controllers/place_controller.dart';
import 'package:get/get.dart';
import 'package:travel_app_getx/pages/welcome_screen.dart';
import 'pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Udupi Insights',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      //
      initialBinding: BindingsBuilder(() {
        Get.put(PlaceController());
      }),
      home: const WelcomeScreen(),
    );
  }
}
