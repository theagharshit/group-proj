import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/db/shared_preferences.dart';
import 'package:women_safety_app/guardian/guardian_home_screen.dart';
import 'package:women_safety_app/user/bottom_page.dart';
import 'package:women_safety_app/user/button_screens/home_screen.dart';
import 'package:women_safety_app/login_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharePref.init();
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
      home: FutureBuilder(
          future: SharePref.getUserType(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==""){
              return LoginScreen();
            } else if(snapshot.data=="user"){
              return BottomPage();
            } else if(snapshot.data=="guardian"){
              return GuardianHomeScreen();
            }
            return progressIndicator(context);
          },
      ),
    );
  }
}
