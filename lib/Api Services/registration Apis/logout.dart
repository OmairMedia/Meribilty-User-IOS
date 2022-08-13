import 'dart:convert';
import "package:http/http.dart" as http;

logoutApi(String type, phonenum) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'DELETE', Uri.parse('https://staging-api.meribilty.com/auth/logout'));
  request.body = json.encode({"type": "$type", "phone": "$phonenum"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
