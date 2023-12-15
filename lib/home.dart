import 'package:ecom/brand.dart';
import 'package:ecom/brand1.dart';

import 'package:ecom/favourite.dart';
import 'package:ecom/language.dart';

import 'package:ecom/profile.dart';
import 'package:ecom/search.dart';
import 'package:ecom/shopping_bag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  static String id = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String userid = "";
  String mailid = "";

  getCurrentUser() {
    user = auth.currentUser!;

    final uid = user?.uid;
    final email = user?.email;
    setState(() {
      print(uid);
      print(email);
      userid = uid!;
      mailid = email!;
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Language()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.notifications_active_outlined,
              color: Colors.blue,
            ),
          )
        ],
        backgroundColor: Colors.black,
        title: const Text("Shopify"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.jpg"),
                      fit: BoxFit.cover)),
              accountName: Text(
                userid.toString(),
                style: const TextStyle(
                    fontSize: 23.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                mailid.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: const CircleAvatar(
                  maxRadius: 30.0,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.category,
                  color: Color.fromARGB(255, 255, 0, 85),
                ),
                title: Text(
                  'Shop by Categories',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.shopping_bag_outlined,
                  color: Color.fromARGB(255, 255, 0, 85),
                ),
                title: Text(
                  'Orders',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.contact_mail,
                  color: Color.fromARGB(255, 255, 0, 85),
                ),
                title: Text(
                  'contact',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.help_center,
                  color: Color.fromARGB(255, 255, 0, 85),
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 255, 0, 85),
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: (() {
                setState(() {
                  logout();
                });
              }),
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 255, 0, 85),
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.pink.shade100,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 250,
                color: Colors.white,
                child: CarouselSlider(
                  items: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 30.0, left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://img.freepik.com/free-photo/pretty-young-stylish-sexy-woman-pink-luxury-dress-summer-fashion-trend-chic-style-sunglasses-blue-studio-background-shopping-holding-paper-bags-talking-mobile-phone-shopaholic_285396-2957.jpg?w=1060&t=st=1660828150~exp=1660828750~hmac=9fce38685f2c91259598e974842fef52020161c36a2bad50c4ecaea3462e9390"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 30.0, left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/free-psd/horizontal-banner-template-big-sale-with-woman-shopping-bags_23-2148786755.jpg?w=1060&t=st=1660828267~exp=1660828867~hmac=81a946fd01d777c3d77a2ae130a740c1cc8672e30aa7eb7c4fc3f4b9718c0b3b"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 30.0, left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/free-vector/gradient-horizontal-sale-banner-template_23-2149011568.jpg?w=996&t=st=1660828350~exp=1660828950~hmac=d78e220cb29ad7a8273fbea5e18bd763b38a607d0232c98c3cc5ecc9335d7982"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 30.0, left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/free-photo/beautiful-smiling-young-blonde-woman-pointing-sunglasses-holding-shopping-bags-credit-card-pink-wall_496169-1506.jpg?w=996&t=st=1660828393~exp=1660828993~hmac=97fb9145718d28dbb16d3f7442f82e871bcd37f7182672dec39188869021a82a"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 30.0, left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/free-vector/black-friday-banner-with-realistic-red-bows-ribbon_1361-2897.jpg?w=1380&t=st=1660828582~exp=1660829182~hmac=76894e1fd99e5b86d0899784813d765031b84114e0b07ea360dc159f3abab5f8"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    enlargeCenterPage: false,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 600),
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const Text(
                  "-Brand-",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0),
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/5-5.jpg"))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 4.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/20-min-4.jpg"))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 4.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/14-1.jpg"))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 4.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/9-3.jpg"))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 4.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/11-1.jpg"))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 4.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/20-min-4.jpg"))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, left: 4.0, top: 8.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 160.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_750/https://www.designhill.com/design-blog/wp-content/uploads/2019/04/22-min-2.jpg"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Brand())));
                    }),
                    child: const Text(
                      "View all",
                      style: TextStyle(color: Color.fromARGB(255, 0, 16, 135)),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BrandEx()));
            },
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://img.paisawapas.com/ovz3vew9pw/2022/07/28113242/myntra-deal-pw-1.jpg"))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const Text(
                  "-Categories-",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0),
                ),
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8), // Border radius
                                child: ClipOval(
                                    child: Image.network(
                                        'https://indiater.com/wp-content/uploads/2019/05/1.jpg')),
                              ),
                            ),
                          ),
                          const Text(
                            "Men",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8), // Border radius
                                child: ClipOval(
                                    child: Image.network(
                                        'https://image.dhgate.com/0x0s/f2-albu-g8-M00-69-01-rBVaV1xqK5WAZIGHAAIvi_XA4og505.jpg/2019-new-european-and-american-women-039.jpg')),
                              ),
                            ),
                          ),
                          const Text(
                            "Women",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8), // Border radius
                                child: ClipOval(
                                    child: Image.network(
                                        'https://img.freepik.com/premium-psd/sneakers-shoes-exclusive-social-media-instagram-post-web-banner-template_484627-99.jpg')),
                              ),
                            ),
                          ),
                          const Text(
                            "Sneakers",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8), // Border radius
                                child: ClipOval(
                                    child: Image.network(
                                        'https://s3.envato.com/files/255019306/2018_MG_0235%205.jpg')),
                              ),
                            ),
                          ),
                          const Text(
                            "Cosmetics",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8), // Border radius
                                child: ClipOval(
                                    child: Image.network(
                                        'https://stock.intellemo.com/6284d1566ef771903deda4bf/6284d15641f91ee3eb700dc4-v941/sportswear_for_women_m.jpg')),
                              ),
                            ),
                          ),
                          const Text(
                            "Sports",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BrandEx()));
            },
            child: Container(
              height: 275,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://img.freepik.com/free-vector/grand-opening-soon-promo-background_52683-61195.jpg?w=996&t=st=1663774590~exp=1663775190~hmac=3888b7052422d614fd2cd294c40428ec9b53ac863c61bf60fa5aa4804f05afe3"))),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Search()));
            }),
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.search_outlined,
              color: Color.fromARGB(255, 255, 0, 85),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black54,
          notchMargin: 5.0,
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                    padding: const EdgeInsets.only(left: 28),
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.home_filled,
                      color: Colors.black,
                      size: 30,
                    )),
                IconButton(
                    padding: const EdgeInsets.only(right: 28),
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Favourite()));
                    }),
                    icon: const Icon(
                      Icons.favorite_sharp,
                      size: 30,
                      color: Color.fromARGB(255, 255, 0, 0),
                    )),
                IconButton(
                    padding: const EdgeInsets.only(left: 28),
                    onPressed: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Bag()));
                    }),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 30,
                    )),
                IconButton(
                    padding: const EdgeInsets.only(right: 28),
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    }),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 30,
                    )),
              ],
            ),
          )),
    );
  }
}
