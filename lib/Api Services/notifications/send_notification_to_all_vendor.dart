import 'package:http/http.dart' as http;
import "dart:convert";


sendNotificationOnJobCreation()async{
  var request = http.Request('POST', Uri.parse('https://staging-api.meribilty.com/fcm/send-to-all-vendors_new-req-created'));


http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}

}