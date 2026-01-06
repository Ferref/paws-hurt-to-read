import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:frontend/services/book_service.dart';
import 'package:frontend/services/registration_service.dart';
import 'package:frontend/services/auth_service.dart';

import 'package:frontend/viewmodels/book_details_view_model.dart';
import 'package:frontend/viewmodels/explore_view_model.dart';
import 'package:frontend/viewmodels/auth_view_model.dart';
import 'package:frontend/viewmodels/registration_view_model.dart';

import 'package:frontend/views/login_view.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<RegistrationService>(RegistrationService());
  getIt.registerSingleton<BookService>(BookService());
  getIt.registerSingleton<AuthViewModel>(
    AuthViewModel(getIt<AuthService>()),
  );
  getIt.registerSingleton<RegistrationViewModel>(
    RegistrationViewModel(getIt<RegistrationService>()),
  );
  
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  getIt.registerFactory<BookDetailsViewModel>(
    () => BookDetailsViewModel(getIt<BookService>(), getIt<AuthService>()),
  );

  getIt.registerFactory<ExploreViewModel>(
    () => ExploreViewModel(getIt<BookService>()),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  setup();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.white70,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.black,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PawsHurtToRead',
        theme: theme,
        darkTheme: darkTheme,
        home: const LoginView(),
      ),
      debugShowFloatingThemeButton: false,
    );
  }
}