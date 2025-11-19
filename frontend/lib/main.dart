import 'package:flutter/material.dart';
import 'package:frontend/widgets/login_widget.dart';
import 'widgets/main_home_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'widgets/login_widget.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PawsHurtToRead',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
  home: LoginWidget(),
    );
  }
}

