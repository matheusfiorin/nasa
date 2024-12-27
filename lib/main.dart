import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/presentation/common/theme/app_theme.dart';
import 'package:nasa/src/presentation/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ApodHiveModelAdapter());

  // Initialize dependencies
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA APOD',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
