import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'package:frontend/services/book_service.dart';
import 'package:frontend/services/registration_service.dart';
import 'package:frontend/services/session_service.dart';

import 'package:frontend/viewmodels/book_details_view_model.dart';
import 'package:frontend/viewmodels/explore_view_model.dart';
import 'package:frontend/viewmodels/session_view_model.dart';
import 'package:frontend/viewmodels/registration_view_model.dart';

import 'package:frontend/views/login_view.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<SessionService>(SessionService());
  getIt.registerSingleton<RegistrationService>(RegistrationService());
  getIt.registerSingleton<BookService>(BookService());
  getIt.registerSingleton<SessionViewModel>(
    SessionViewModel(getIt<SessionService>()),
  );
  getIt.registerSingleton<RegistrationViewModel>(
    RegistrationViewModel(getIt<RegistrationService>()),
  );

  getIt.registerFactory<BookDetailsViewModel>(
    () => BookDetailsViewModel(getIt<BookService>()),
  );

  getIt.registerFactory<ExploreViewModel>(
    () => ExploreViewModel(getIt<BookService>()),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  setup();
  runApp(MyApp());
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
      home: const LoginView(),
    );
  }
}
