import 'package:flutter/material.dart';
import 'core/di/injection.dart' as di;
import 'feature/user_profile/presentation/architecture_showcase_page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLID in Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ArchitectureShowcasePage(),
    );
  }
}
