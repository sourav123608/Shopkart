// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/models/cart_model.dart';
import 'package:ecom/models/pincode_model.dart';
import 'package:ecom/pin_remote.dart';
import 'package:ecom/product_model.dart';
import 'package:ecom/shopping_bag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Desc extends StatefulWidget {
  final int index;
  final List<Product>? data;

  const Desc(
    Key? key,
    this.index,
    this.data,
  ) : super(key: key);

  @override
  State<Desc> createState() => _DescState();
}

class _DescState extends State<Desc> {
  TextEditingController pin = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("cart");
  bool validate = false;
  List<Product>? prod;
  List<Cart>? pins;
  String data = '';
  String pincode = '';
  late int ih;
  bool size = false;
  Color _color = Colors.black;

  @override
  void initState() {
    super.initState();
    prod = widget.data;
    ih = widget.index - 1;
    getData();
  }

  getData() {
    print(auth.currentUser!.uid);
    ref
        .child(auth.currentUser!.uid)
        .child("cart values")
        .get()
        .then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        data = snapshot.value.toString();
        print(data);
      }
    });
  }

  update(String val) {
    CartModel cart = CartModel(val);
    ref.child(auth.currentUser!.uid).set(cart.toJson());
  }

  getpincode(pin) async {
    pincode = pin.text;
    try {
      pins = await PinData().getuserdata(pincode);
    } on Exception catch (e) {
      Fluttertoast.showToast(
          textColor: const Color.fromARGB(255, 0, 0, 0),
          gravity: ToastGravity.TOP,
          msg: e.toString(),
          fontSize: 12.0,
          backgroundColor: Colors.grey);
    }
  }

  void showalertdialouge() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 100,
                height: 500,
                child: Column(
                  children: const [
                    DefaultTabController(
                        length: 2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: TabBar(
                            indicatorColor: Colors.pink,
                            tabs: [
                              Icon(
                                Icons.man,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.woman,
                                color: Colors.black,
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 410,
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Image(
                height: 350,
                image: NetworkImage(prod![ih].image),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prod![ih].title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        prod![ih].description,
                        style:
                            const TextStyle(fontSize: 14, letterSpacing: 0.5),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Rs ${prod![ih].price.toString()}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "  (15% OFF)",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 119, 255),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Inclusive of all taxes",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              width: 410,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        " Select Size",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showalertdialouge();
                            });
                          },
                          child: const Text("Size chart",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            size = size == true ? false : true;
                            _color = _color == Colors.white
                                ? Colors.black
                                : Colors.white;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: const Center(
                            child: Text(
                              'XS',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            size = size == true ? false : true;
                            _color = _color == Colors.white
                                ? Colors.black
                                : Colors.white;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: const Center(
                            child: Text(
                              'S',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            size = size == true ? false : true;
                            _color = _color == Colors.white
                                ? Colors.black
                                : Colors.white;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: const Center(
                            child: Text(
                              'M',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            size = size == true ? false : true;
                            _color = _color == Colors.white
                                ? Colors.black
                                : Colors.white;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: const Center(
                            child: Text(
                              'L',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            size = size == true ? false : true;
                            _color = _color == Colors.white
                                ? Colors.black
                                : Colors.white;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: const Center(
                            child: Text(
                              'XL',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            size = size == true ? false : true;
                            _color = _color == Colors.white
                                ? Colors.black
                                : Colors.white;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: const Center(
                            child: Text(
                              'XXL',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.white,
              height: 300,
              width: 410,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        " DELIVERY OPTIONS   ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      ),
                      Icon(
                        Icons.fire_truck,
                        size: 40,
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          controller: pin,
                          style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.0,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0)),
                              prefixIcon: const Icon(
                                Icons.pin_drop,
                                color: Colors.amber,
                              ),
                              hintText: "Pincode",
                              errorText: validate ? 'Cant be empty?' : null,
                              suffixIcon: TextButton(
                                onPressed: () {
                                  setState(() {
                                    pin.text.isEmpty
                                        ? validate = true
                                        : validate = false;
                                    if (validate == false) {
                                      getpincode(pin);
                                    }
                                  });
                                },
                                child: const Text(
                                  "Check",
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )))),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Delivery status: ${pins?[0].postOffice[0].deliveryStatus}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Location: ${pins?[0].postOffice[0].division}, ${pins?[0].postOffice[1].name}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "   100% Original Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "   Pay on delivery might be available",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "   Easy 30 days returns and exchanges",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "   Try & Buy might be available",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Color.fromARGB(255, 247, 207, 220),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Color.fromARGB(255, 243, 32, 103),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                minimumSize: const Size(180, 50),
              ),
              onPressed: () {},
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: Colors.black,
                  ),
                  label: const Text("Wishlist",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Color.fromARGB(255, 39, 152, 244),
                minimumSize: const Size(180, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              onPressed: () {},
              child: TextButton.icon(
                  onPressed: () {
                    if (size == true) {
                      update('$data${ih + 1},');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Bag()));
                    } else {
                      Fluttertoast.showToast(
                          textColor: Colors.white,
                          gravity: ToastGravity.TOP,
                          msg: 'Select a Size',
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 12.0,
                          backgroundColor: Colors.black);
                    }
                  },
                  icon: const Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
