import 'package:ecom/product_model.dart';
import 'package:http/http.dart' as http;

class RemoteData {
  Future<List<Product>?> getuserdata() async {
    var client = http.Client();
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;

      return productFromJson(json);
    }
    return null;
  }
}
