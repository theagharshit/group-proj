import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';

import '../components/custom_text_field.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';
import '../login_screen.dart';
import '../model/user_model.dart';

class RegisterGuardianScreen extends StatefulWidget {
  @override
  State<RegisterGuardianScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterGuardianScreen> {
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit(){
    _formKey.currentState!.save();
    if(_formData['password']!= _formData['rpassword']){
      dialoguebox(context, 'password and retype password should be same');
    }else{
      setState(() {
        isLoading = true;
      });
      try{
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.createUserWithEmailAndPassword(
            email: _formData['gemail'].toString(),
            password: _formData['password'].toString())
            .then((v) async{
          DocumentReference<Map<String, dynamic>> db =
          FirebaseFirestore.instance.collection('users').doc(v.user!.uid);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            userEmail: _formData['uemail'].toString(),
            guardianEmail: _formData['gemail'].toString(),
            id: v.user!.uid,
            type: 'guardian',
          );
          try {
            final jsonData = user.toJson();
            await db.set(jsonData).whenComplete((){
              goto(context, LoginScreen());
              setState(() {
                isLoading = false;
              });
            });
          } catch (e) {
            print('Error: $e');
          }
        });
      } on FirebaseAuthException catch(e){
        dialoguebox(context, e.toString());
      } catch(e){
        dialoguebox(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              isLoading
              ?progressIndicator(context)
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "REGISTER AS GUARDIAN",
                            textAlign: TextAlign.center,
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
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                              hintText: 'Enter name',
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.name,
                              prefix: Icon(Icons.person),
                              onsave: (name){
                                _formData['name'] = name ?? "";
                              },
                              validate: (name){
                                if(name!.isEmpty ||
                                    name.length<3){
                                  return 'enter correct name';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: 'Enter phone',
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.phone,
                              prefix: Icon(Icons.phone),
                              onsave: (phone){
                                _formData['phone'] = phone ?? "";
                              },
                              validate: (phone){
                                if(phone!.isEmpty ||
                                    phone.length<10 ){
                                  return 'enter correct phone';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: 'Enter your email',
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (gemail){
                                _formData['gemail'] = gemail ?? "";
                              },
                              validate: (gemail){
                                if(gemail!.isEmpty ||
                                    gemail.length<3 ||
                                    !gemail.contains("@")){
                                  return 'enter correct email';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: 'Enter user\'s email',
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (uemail){
                                _formData['uemail'] = uemail ?? "";
                              },
                              validate: (uemail){
                                if(uemail!.isEmpty ||
                                    uemail.length<3 ||
                                    !uemail.contains("@")){
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
                            CustomTextField(
                              hintText: 'Re-enter password',
                              isPassword: showPassword,
                              prefix: Icon(Icons.vpn_key_rounded),
                              onsave: (password){
                                _formData['rpassword'] = password ?? "";
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
                                title: 'Register',
                                onPressed: () {
                                  if(_formKey.currentState!.validate())
                                    _onSubmit();
                                }),
                          ],
                        ),
                      ),
                    ),


                    SecondaryButton(title: 'Log In', onPressed: () {
                      goto(context, LoginScreen());
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
