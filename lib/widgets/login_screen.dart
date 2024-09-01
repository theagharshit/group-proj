import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';

import '../components/custom_text_field.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "USER LOGIN",
                  style: TextStyle(
                    fontSize: 40,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset('assets/logo.png',
                height: 100,
                width: 100,
                ),
                CustomTextField(
                  hintText: 'enter name',
                  prefix: Icon(Icons.person),
                ),
                CustomTextField(
                  hintText: 'enter name',
                  prefix: Icon(Icons.person),
                ),
                PrimaryButton(title: 'Log In', onPressed: (){}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forget password?",
                      style: TextStyle(fontSize: 18),
                    ),
                    SecondaryButton(title: 'click here', onPressed: (){}),
                  ],
                ),
                SecondaryButton(title: 'Register new user', onPressed: (){}),
              ],
            ),
          )),
    );
  }
}
