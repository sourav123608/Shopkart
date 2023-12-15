import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        snap: false,
        pinned: true,
        floating: false,
        flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
          "https://source.unsplash.com/random/?Clothes",
          fit: BoxFit.cover,
        ) //Images.network
            ), //FlexibleSpaceBar
        expandedHeight: 230,
      ),
    ]));
  }
}
