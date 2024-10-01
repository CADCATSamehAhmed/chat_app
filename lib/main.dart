import 'package:chat_app/features/auth/presentation/views/screens/login.dart';
import 'package:chat_app/features/auth/presentation/views/screens/signup.dart';
import 'package:chat_app/features/splash/presentation/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'core/constants/variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/':(context)=>const SplashScreen(),
        'login':(context)=>const LoginScreen(),
        'signup':(context)=>const SignUpScreen(),
      },
    );
  }
}

