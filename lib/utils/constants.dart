import 'dart:ui';

import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFDB7FFF);

void goto(BuildContext context, Widget nextScreen){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}