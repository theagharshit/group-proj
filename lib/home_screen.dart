
import 'package:flutter/material.dart';
import 'package:women_safety_app/widgets/custom_appBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppbar(),
            ],
          ),
        ),
      ),
    );
  }
}
