import 'package:flutter/material.dart';
import 'package:women_safety_app/user/button_screens/chat_screen.dart';
import 'package:women_safety_app/user/button_screens/contact_screen.dart';
import 'package:women_safety_app/user/button_screens/home_screen.dart';
import 'package:women_safety_app/user/button_screens/profile_screen.dart';
import 'package:women_safety_app/user/button_screens/review_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex=0;
  List<Widget> pages = [
    HomeScreen(),
    ContactScreen(),
    ChatScreen(),
    ProfileScreen(),
    ReviewScreen()
  ];
  onTapped(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: primaryColor,
        selectedFontSize: 15,// Highlight the selected item
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home,)),
            BottomNavigationBarItem(
                label: 'Contacts',
                icon: Icon(Icons.contacts)),
            BottomNavigationBarItem(
                label: 'Chat',
                icon: Icon(Icons.chat)),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person)),
            BottomNavigationBarItem(
                label: 'Review',
                icon: Icon(Icons.rate_review)),
          ],
      ),
    );
  }
}
