import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_move/providers/activities_provider.dart';
import 'screens/splash_screen.dart';

// here, you can see that the [ChangeNotifierProvider]
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ActivitiesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
