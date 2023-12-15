import 'package:ecom/home.dart';

import 'package:ecom/product_model.dart';
import 'package:ecom/remote_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'models/cart_model.dart';

class Bag extends StatefulWidget {
  const Bag({Key? key}) : super(key: key);

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  final Razorpay _razorpay = Razorpay();

  List<Product>? bag;
  String data = '';
  List<String>? itemid = [];
  TextEditingController coupon = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("cart");
  bool validate = true;
  double total = 0.0;
  double discount = 0;
  String size = "";
  int qty = 1;
  @override
  void initState() {
    super.initState();
    getuserData();
    getdata();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_7DbTqq801cfsrE',
      'amount': total * 100,
      'name': 'Shopify',
      'description': bag![1].title,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9861630150',
        'email': 'beherasibasundar1802@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void delete(val, index) {
    ref.child(auth.currentUser!.uid).child("cart values").remove();
    CartModel cart = CartModel(data.replaceAll(val.toString(), ''));
    ref.child(auth.currentUser!.uid).update({"cart values": cart.id});
    setState(() {
      itemid!.remove(bag![index].id.toString());
      total = total - bag![index].price * qty;
      print(total);
    });
  }

  getuserData() {
    ref
        .child(auth.currentUser!.uid)
        .child("cart values")
        .get()
        .then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        data = snapshot.value.toString();
      }
    });
  }

  getdata() async {
    bag = await RemoteData().getuserdata();

    item();
    price();
  }

  void item() {
    setState(() {
      itemid!.addAll(data.split(','));
      itemid!.removeWhere((el) => el == '');
      itemid = itemid!.toSet().toList();
    });
  }

  void price() {
    print(itemid);
    setState(() {
      for (int i = 0; i < bag!.length; i++) {
        for (int j = 0; j < itemid!.length; j++) {
          if (bag![i].id.toString() == itemid![j]) {
            total = total + bag![j].price * qty;
          }
        }
        print(total);
      }
    });
  }

  bool inArray(needle, haystack) {
    var count = haystack.length;
    for (var i = 0; i < count; i++) {
      if (haystack[i] == needle) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopify"),
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Home()),
                    (Route<dynamic> route) => false);
              });
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    if (inArray(bag?[index].id.toString(), itemid)) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 210,
                          padding: const EdgeInsets.all(8),
                          child: Row(children: [
                            Expanded(
                              flex: 10,
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(bag![index].image),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            Expanded(
                              flex: 20,
                              child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              delete(bag![index].id, index);
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.grey.shade400,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      bag![index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bag![index].category.toString(),
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey.shade300,
                                              minimumSize: const Size(20, 20),
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 170,
                                                    width: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(12, 20,
                                                                  0, 20),
                                                          child: Text(
                                                            "select size",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 390,
                                                          height: 70,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      size =
                                                                          "36";
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "XS",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      size =
                                                                          "38";
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "S",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      size =
                                                                          "40";
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "M",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      size =
                                                                          "42";
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "L",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      size =
                                                                          "44";
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "XL",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      size =
                                                                          "46";
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "XXL",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            label: Text(
                                              "$size :Size",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        const Gap(15),
                                        ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey.shade300,
                                                minimumSize:
                                                    const Size(20, 20)),
                                            onPressed: () {
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 170,
                                                    width: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(12, 20,
                                                                  0, 20),
                                                          child: Text(
                                                            "select Quantity",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 390,
                                                          height: 70,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      qty = 2;
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "2",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      qty = 3;
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "3",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      qty = 4;
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "4",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      qty = 5;
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "5",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      qty = 6;
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "6",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      qty = 7;
                                                                    });
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape: const CircleBorder(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.black)),

                                                                    primary: Colors
                                                                        .white, // <-- Button color
                                                                    onPrimary:
                                                                        Colors
                                                                            .pink, // <-- Splash color
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "7",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            label: Text(
                                              "$qty:Qty",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ ${bag![index].price * qty}  ",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          "₹ 599",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                        const Text(
                                          "  40% OFF",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 10, 92),
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          color: Color.fromARGB(255, 2, 161, 8),
                                        ),
                                        Text(
                                          "Delivery by ",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          "21 Dec 2022",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "  COUPONS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.black,
                                    controller: coupon,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.0,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        prefixIcon: const Icon(
                                          Icons.discount,
                                          color: Colors.black,
                                        ),
                                        hintText: "Enter Coupon Code",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        errorText: validate
                                            ? null
                                            : "No Coupon availiable",
                                        suffixIcon: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              coupon.text.isEmpty
                                                  ? validate = true
                                                  : validate = false;
                                            });
                                          },
                                          child: const Text(
                                            "CHECK",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 0, 85),
                                                fontSize: 16,
                                                letterSpacing: 0.3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )))),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Maximum savings:",
                                          style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "₹ $discount",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color.fromARGB(
                                                255, 255, 0, 85),
                                            minimumSize: const Size(200, 50)),
                                        onPressed: () {},
                                        child: Text("APPLY"))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: const ListTile(
                    leading: Icon(Icons.discount_outlined),
                    iconColor: Colors.black,
                    title: Text(
                      "Apply Coupon",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "PRICE DETAILS ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "(${itemid!.length} items)",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text("Total MRP"), Text("₹ $total")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Discount on MRP"),
                          Text("₹ $discount"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Coupoun Discount"),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Apply Coupon",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 85),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Convenience Fee"),
                          Text(
                            "₹ Free",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 133, 4)),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "${total - discount}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: const Color.fromARGB(255, 244, 213, 224),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${itemid!.length} item selected for order",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 255, 0, 85),
                  onPrimary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  minimumSize: const Size(390, 50),
                ),
                onPressed: openCheckout,
                child: const Text("PLACE ORDER",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 15)))
          ],
        ),
      ),
    );
  }
}
