import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future chatClient() async {
  final client = chatstorage.getItem('chat_client');

  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('POST', Uri.parse('https://staging-api.meribilty.com/chat/join'));
  request.body = json.encode({"token": box.read('token')});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    // print('responseMap === $responseMap');
    print(responseMap);
    final user_id = (responseMap['user_type'] + '_' + responseMap['user_id']);
// await before client.connect user is connected to solve error
     client.connectUser(
      User(id: user_id),
      responseMap['token'],
    );

    // first let’s create a filter to make messaging channels that include a specific user
    final filter = Filter.and([
      Filter.equal('type', 'livestream'),
      Filter.in_('members', [user_id])
    ]);

    // finally, we can query for those channels, automatically watching them for the
    // currently connected user
    final channels = await client.queryChannels(
      filter: filter,
      watch: true,
      state: true,
    );

    var channel;

    await channels.forEach((List<Channel> c) {
      // c.forEach((element) {
      //   channel = element;
      // });
      channel = c;
      print("CHANNELS === ${c}");
    });

    final List<String>? orderArr = List.from(responseMap['orderArr']);
    // for (var orderNo in orderArr!) {
    //   channel = client.channel(
    //     'livestream',
    //     id: 'Order$orderNo',
    //     extraData: {"name": "Order$orderNo"},
    //   );

    //   await channel.watch();
    //   // await channel.addMembers(['${responseMap['user_type']}_${responseMap['user_id']}']);
    // }

    final List<String>? biltyArr = List.from(responseMap['biltyArr']);
    // for (var biltyNo in biltyArr!) {
    //   channel = client.channel(
    //     'livestream',
    //     id: biltyNo,
    //     extraData: {"name": biltyNo},
    //   );

    //   await channel.watch();
    //   // await channel.addMembers(['${responseMap['user_type']}_${responseMap['user_id']}']);
    // }
    return [channel, orderArr, biltyArr];
  } else {
    print(response.reasonPhrase);
  }

  // await channel.update(
  //   {"name": "flutterdevs"},
  // );
}
