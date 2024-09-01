
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:women_safety_app/widgets/home_widgets/CustomCarousel.dart';
import 'package:women_safety_app/widgets/home_widgets/custom_appBar.dart';
import 'package:women_safety_app/widgets/home_widgets/emergency.dart';
import 'package:women_safety_app/widgets/home_widgets/live_save.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({super.key});
  int qIndex = 0;

  getRandomQuote(){
    Random random = Random();
    setState(() {
    qIndex = random.nextInt(6);
    });
  }
  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppbar(
                quoteIndex: qIndex,
                onTap: getRandomQuote,
              ),
              Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomCarousel(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Emergency",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Emergency(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Explore LiveSafe",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      LiveSave(),
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
