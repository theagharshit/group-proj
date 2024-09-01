import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_app/widgets/home_widgets/live_save/bus_card.dart';
import 'package:women_safety_app/widgets/home_widgets/live_save/hospital_card.dart';
import 'package:women_safety_app/widgets/home_widgets/live_save/pharmacy_card.dart';
import 'package:women_safety_app/widgets/home_widgets/live_save/police_station_card.dart';

class LiveSave extends StatelessWidget {
  const LiveSave({super.key});

  static Future<void> openMap(String location) async{
    String googleUrl= 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e){
      Fluttertoast.showToast(
          msg: 'something went wrong! call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}
