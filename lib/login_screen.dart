import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/db/shared_preferences.dart';
import 'package:women_safety_app/guardian/guardian_home_screen.dart';
import 'package:women_safety_app/guardian/guardian_register_screen.dart';
import 'package:women_safety_app/user/button_screens/home_screen.dart';
import 'package:women_safety_app/user/user_register_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

import 'components/custom_text_field.dart';
import 'components/primary_button.dart';
import 'components/secondary_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit() async{
    _formKey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _formData['email'].toString(),
          password: _formData['password'].toString()
      );
      if(userCredential.user!=null){
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value){
              if(value['type']=='guardian'){
                print(value['type']);
                SharePref.saveUserType('guardian');
                goto(context, GuardianHomeScreen());
              } else if(value['type']=='user'){
                SharePref.saveUserType('user');
                goto(context, HomeScreen());
              }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        dialoguebox(context, 'No user found for that email');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialoguebox(context, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
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
                            Image.asset(
                              'assets/logo.png',
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                hintText: 'Enter email',
                                isPassword: false,
                                textInputAction: TextInputAction.next,
                                keyboardtype: TextInputType.emailAddress,
                                prefix: Icon(Icons.person),
                                onsave: (email){
                                  _formData['email'] = email ?? "";
                                },
                                validate: (email){
                                  if(email!.isEmpty ||
                                      email.length<3 ||
                                      !email.contains("@")){
                                    return 'enter correct email';
                                  }
                                  return null;
                                },
                              ),
                              CustomTextField(
                                hintText: 'Enter password',
                                isPassword: showPassword,
                                prefix: Icon(Icons.vpn_key_rounded),
                                onsave: (password){
                                  _formData['password'] = password ?? "";
                                },
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: showPassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                validate: (password){
                                  if(password!.isEmpty || password.length<8){
                                    return 'enter correct password';
                                  }
                                  return null;
                                },
                              ),
                              PrimaryButton(
                                  title: 'Log In',
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      _onSubmit();
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forget password?",
                              style: TextStyle(fontSize: 18),
                            ),
                            SecondaryButton(title: 'Click here', onPressed: () {}),
                          ],
                        ),
                      ),
                      SecondaryButton(title: 'Register new user', onPressed: () {
                        goto(context, RegisterUserScreen());
                      }),
                      SecondaryButton(title: 'Register as Guardian', onPressed: () {
                        goto(context, RegisterGuardianScreen());
                      }),
                    ],

                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
