import 'package:flutter/material.dart';

class Brand extends StatefulWidget {
  const Brand({Key? key}) : super(key: key);

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BRANDS"),
        centerTitle: true,
        titleTextStyle: const TextStyle(letterSpacing: 5.0, fontSize: 18),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: ListWheelScrollView(
          itemExtent: 250,
          perspective: 0.005,
          diameterRatio: 3.5,
          physics: const FixedExtentScrollPhysics(),
          squeeze: 0.7,
          clipBehavior: Clip.antiAlias,
          children: [
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://img.freepik.com/free-vector/elegant-golden-logo-template_79603-1530.jpg?size=626&ext=jpg&ga=GA1.2.665965149.1660828147")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://i.pinimg.com/originals/e5/23/71/e5237138a5e61a4a61dfe3b15195af45.jpg")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://logos-marcas.com/wp-content/uploads/2020/04/Levi%E2%80%99s-emblema.png")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://www.pngitem.com/pimgs/m/249-2491766_sports-brand-logo-png-transparent-png.png")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "http://www.designhill.com/design-blog/wp-content/uploads/2019/04/10.png")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://www.deadstock.de/wp-content/uploads/2021/12/nike-sportswear-banner.png")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://etimg.etb2bimg.com/photo/70712962.cms")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://logos-world.net/wp-content/uploads/2020/05/Zara-Emblem.jpg")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://seeklogo.com/images/V/van-heusen-logo-3A15A8941D-seeklogo.com.png")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://assets.turbologo.com/blog/en/2020/01/19084716/armani-logo-cover.png")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://i.pinimg.com/originals/88/f5/a6/88f5a66cfb671c13a0ede6e9e33e0000.jpg")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://w0.peakpx.com/wallpaper/840/137/HD-wallpaper-prada-green-logo-green-brickwall-prada-logo-fashion-brands-prada-neon-logo-prada.jpg")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://thumbs.dreamstime.com/b/dolce-gabbana-logo-popular-clothing-brand-famous-luxury-vector-icon-zaporizhzhia-ukraine-may-222305674.jpg")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH6tJJJpBIfNN8KBgDo-khZZU2MFu-Kzgyi_ir5hTu5-ipku774vYCcgOgUGPo3T8_7cQ&usqp=CAU")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://s3.eu-central-1.amazonaws.com/centaur-wp/designweek/prod/content/uploads/2013/04/bibalogo.jpg")),
            GestureDetector(
                onTap: () {},
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2xC40xi8HYpM4RqhXzeTojotAX-hJz3-7xlRvyqYfADhdG2nb2NfAmZOe1-YY4RNnmTU&usqp=CAU")),
          ],
        ),
      ),
    );
  }
}
