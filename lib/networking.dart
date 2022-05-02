import 'dart:convert';
import 'package:http/http.dart' as http;

class Networking {
  Networking(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      return json.decode(data);
    } else {
      print(response.statusCode);
    }
  }
}
