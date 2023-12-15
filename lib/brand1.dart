import 'package:ecom/desc.dart';
import 'package:ecom/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecom/remote_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BrandEx extends StatefulWidget {
  const BrandEx({Key? key}) : super(key: key);

  @override
  State<BrandEx> createState() => _BrandExState();
}

class _BrandExState extends State<BrandEx> {
  List<Product>? data;

  bool isFavorite = false;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    data = await RemoteData().getuserdata();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shopekart",
            style: TextStyle(letterSpacing: 1.5),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 226, 237, 243),
        body: isLoaded
            ? Padding(
                padding: const EdgeInsets.all(7.0),
                child: GridView.builder(
                  itemCount: data?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                      mainAxisExtent: 365),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: Colors.pink.shade100,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            color: Colors.white,
                            height: 150,
                            width: 170,
                            child: GestureDetector(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Desc(data![index].id as Key?, data as int,Key as List<Product>?)));
                              }),
                              child: Image(
                                  image: NetworkImage(data![index].image)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30, left: 5),
                            height: 80,
                            child: Text(
                              data![index].title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "  Rs ${data![index].price.toString()}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (isFavorite == true) {
                                      isFavorite = false;
                                    } else {
                                      isFavorite = true;
                                    }
                                  });
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline_sharp,
                                  color: const Color.fromARGB(255, 255, 17, 0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarIndicator(
                                rating: double.parse(
                                    data![index].rating.rate.toString()),
                                itemBuilder: (context, index) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                              ),
                              Text("${data![index].rating.count}   ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "  ${data![index].rating.rate} R",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}



