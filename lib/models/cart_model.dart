class CartModel {
  String id = "";
  CartModel(this.id);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{"cart values": id};
  CartModel.fromJson(Map<dynamic, dynamic> json) : id = json["cart values"];
}
