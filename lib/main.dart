import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecom/presentation/screens/product_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom/widgets/bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        home: BottomNav(),
      ),
    );
  }
}
