import 'package:diary/employees.dart/employees.dart';
import 'package:flutter/material.dart';

import 'package:diary/Login/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data as User?;
          print(user);
          if (user == null) {
            return const LoginPage();
          } else {
            return const Employees();
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Color(0xFF0F4B7C),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0F4B7C),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
            actionsIconTheme: IconThemeData(color: Colors.white)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF0F4B7C),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: Colors.blue, // Change the primary color of the app
        scaffoldBackgroundColor: const Color.fromARGB(245, 165, 204, 238),
      ),
      home:  Scaffold(body: AuthenticationWrapper()),
    );
  }
}
