import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:slate/screens/splash_screen.dart';
import 'package:slate/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const SlateApp());
}

class SlateApp extends StatelessWidget {
  const SlateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
