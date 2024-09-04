import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/home_screen.dart';
import 'package:women_safety_app/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyB4KUa1kJuiZVDjOzpwOG2-MeeNIB00oFU',
          appId: '1:139830980256:android:6ea2093fe37d486f5a63c5',
          messagingSenderId: '139830980256',
          projectId: 'women-safety-app-d6fd9')
    ); // Initialize Firebase
  } catch (e) {
    print('Error initializing Firebase: $e');  // Print any initialization errors
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen());
  }
}
