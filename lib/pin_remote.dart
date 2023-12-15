import 'package:ecom/models/pincode_model.dart';

import 'package:http/http.dart' as http;

class PinData {
  Future<List<Cart>?> getuserdata(String pincode) async {
    var client = http.Client();
    var url = Uri.parse('https://api.postalpincode.in/pincode/$pincode');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;
      print(json);

      return cartFromJson(json);
    }
    return null;
  }
}
