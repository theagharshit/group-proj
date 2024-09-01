import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/quotes.dart';
import 'package:women_safety_app/widgets/safewebview.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});

  void navigateToRoute(BuildContext context, Widget route){
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: List.generate(
          imageSliders.length,
          (index) => Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: (){
                if(index == 0) {
                  navigateToRoute(context, Safewebview(
                    url: 'http://www.sewa.org/',
                  ));
                } else if(index == 1){
                  navigateToRoute(context, Safewebview(
                    url: 'https://azadfoundation.com/',
                  ));
                } else if(index == 2){
                  navigateToRoute(context, Safewebview(
                    url: 'https://inbreakthrough.org/',
                  ));
                } else if(index == 3){
                  navigateToRoute(context, Safewebview(
                    url: 'https://www.womensweb.in/',
                  ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageSliders[index]))
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                    LinearGradient(colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ]),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                      child: Text(
                        articleTitle[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width*0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}
