import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
            sweetSayings[0],
            style: TextStyle(fontSize: 22),
        ),
    );
  }
}
