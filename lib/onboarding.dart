import 'package:book_house/login.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatelessWidget {
  final list=[
    PageModel(
      widget: Container(
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/genre.jpg"),
              height: 290,
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Explore Different Genres",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23
              ),textAlign: TextAlign.center),
              margin: EdgeInsets.only(bottom: 15),
              width: double.infinity,
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Have a look at variety of different genres.",
              style: TextStyle(
                fontSize: 20
              ),textAlign: TextAlign.center),
              width: double.infinity,
            ),
          ],
        ),
      )
    ),
    PageModel(
        widget: Column(
          children: [
            Container(
              child:Image.asset("assets/library.png"),
              height: 250,
              width: 300,
              margin: EdgeInsets.only(top:20,bottom: 20),
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Library and Favourite Books",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23
              ),textAlign: TextAlign.center),
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 15),
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Create your own Library and set your Favourite books with a single tap.",
                style: TextStyle(
                    fontSize: 20
                ),textAlign: TextAlign.center),
              width: double.infinity,
            ),
          ],
        )
    ),
    PageModel(
        widget: Column(
          children: [
            Container(
              child: Image.asset("assets/download.png"),
              height: 250,
              width: 300,
              margin: EdgeInsets.only(top:20,bottom: 20),
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Download And Read",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23
              ),textAlign: TextAlign.center),
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 15),
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Download books and start your reading journey",
                style: TextStyle(
                    fontSize: 20
                ),textAlign: TextAlign.center,),
              width: double.infinity,
            ),
          ],
        )
    ),

    PageModel(
        widget: Column(
          children: [
            Container(
              child: Image.asset("assets/personalised.jpg"),
              height: 270,
              width: 270,
              margin: EdgeInsets.only(bottom: 20),
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Personalised Book",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23
              ),),
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 15),
            ),
            Container(
              alignment:Alignment.center,
              child: Text("Mark highlights and bookmarks, set font size and family and many more.",
  style: TextStyle(
  fontSize: 20
  ),),
  width: double.infinity,
            ),
          ],
        )
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding(
        skipButtonStyle: SkipButtonStyle(
          skipButtonColor: Colors.deepPurple.shade400,
          skipButtonPadding: EdgeInsets.all(10),
          skipButtonText: Text("Skip",
            style: TextStyle(
                color: Colors.white,
                fontSize: 21
            ),),
        ),
        footerPadding: EdgeInsets.only(bottom: 50,left: 40,right: 25),
        background: Colors.white,
        proceedButtonStyle: ProceedButtonStyle(
          proceedButtonColor: Colors.blue.shade900,
          proceedButtonPadding: EdgeInsets.all(10),
          proceedpButtonText: Text("Start",
            style: TextStyle(
              color: Colors.white,
              fontSize: 21
            ),),
          proceedButtonRoute: (context){
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
    }),
    pages: list,
    indicator: Indicator(
      closedIndicator: ClosedIndicator(color: Colors.blue),
      activeIndicator: ActiveIndicator(color: Colors.black,borderWidth: 1.5),
    indicatorDesign: IndicatorDesign.polygon(
    polygonDesign: PolygonDesign(
    polygon: DesignType.polygon_diamond
    ))
    ),
        ),
    );
  }
}
