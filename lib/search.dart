import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Color bgcolor = Colors.blue;

  var url = "";
  var txt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          animationDuration: const Duration(milliseconds: 300),
          color: Colors.black26,
          backgroundColor: bgcolor,
          buttonBackgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                bgcolor = Colors.blueAccent;
                txt = "MEN";
                url =
                    "https://img.freepik.com/free-psd/man-fashion-sale-banner-template_23-2148961822.jpg?w=1060&t=st=1661273655~exp=1661274255~hmac=0d0bcd569992fd91b569678a283235a40f1095211f6c162a92d01c3f646141a8%22";
              } else if (index == 1) {
                bgcolor = Colors.pinkAccent;
                txt = "WOMEN";
                url =
                    "https://img.freepik.com/free-psd/clothing-store-concept-banner-template_23-2148722603.jpg?w=1060&t=st=1661275453~exp=1661276053~hmac=c5bd5f2f2b20f0fc44768a31293ad851d032df74af16a4fc4f93d52bddb2aebf";
              } else if (index == 2) {
                bgcolor = Colors.purpleAccent;
                txt = "CHILD";
                url =
                    "https://img.freepik.com/free-psd/girls-playing-cardboard-box_23-2148608462.jpg?w=1060&t=st=1661274258~exp=1661274858~hmac=7d3f8864b4ecee864e910920cb865387243129fd8c786d5fd7c4e741c672b41a";
              }
            });
          },
          letIndexChange: (index) => true,
          items: const <Widget>[
            Icon(
              Icons.man,
              size: 30,
            ),
            Icon(Icons.woman, size: 30),
            Icon(Icons.child_care_outlined, size: 30),
          ]),
      backgroundColor: bgcolor,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 235,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(url),
              )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              width: double.maxFinite,
              height: 30,
              decoration: const BoxDecoration(color: Colors.black),
              child: const Center(
                child: Text(
                  "-New Arrivals-",
                  style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8.0,
                      shadows: [
                        Shadow(color: Colors.yellowAccent, blurRadius: 10.0)
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
