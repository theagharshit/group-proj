import 'package:flutter/material.dart';
import 'package:women_safety_app/guardian_register_screen.dart';
import 'package:women_safety_app/user_register_screen.dart';
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
  onSubmit(){
    _formKey.currentState!.save();
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                              if(_formKey.currentState!.validate())
                              onSubmit();
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
        ),
      ),
    );
  }
}
