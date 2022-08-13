import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/animated_toggle.dart';
import 'package:meribiltyapp/widgets/chat/audio_loading_message.dart';
import 'package:meribiltyapp/widgets/chat/audio_player_message.dart';
import 'package:meribiltyapp/widgets/chat/record_button.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class Channels extends StatefulWidget {
  final StreamChatClient client;
  final List<Channel> channel;
  final orderArr;
  final biltiesArr;
  const Channels({
    Key? key,
    required this.client,
    required this.channel,
    required this.orderArr,
    required this.biltiesArr,
  }) : super(key: key);

  @override
  _ChannelsState createState() => _ChannelsState();
}

class _ChannelsState extends State<Channels> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.channel.isNotEmpty
            ? StreamChat(
                client: widget.client,
                child: StreamChannel(
                  channel: widget.channel.last,
                  child: ChannelListPage(
                      orderArr: widget.orderArr, biltiesArr: widget.biltiesArr),
                ))
            : ChannelListPage(
                orderArr: widget.orderArr, biltiesArr: widget.biltiesArr));
  }
}

class ChannelListPage extends StatefulWidget {
  final orderArr;
  final biltiesArr;
  ChannelListPage({
    Key? key,
    required this.orderArr,
    required this.biltiesArr,
  }) : super(key: key);

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  int _toggleValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          "My Chat",
          style: Constants.regular4.copyWith(color: Constants.White),
        ),
        backgroundColor: Constants.Primary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(FontAwesomeIcons.chevronLeft),
        ),
      ),
      body: Column(
        children: [
          AnimatedToggle(
            values: ['Order', 'Bilty'],
            onToggleCallback: (value) {
              setState(() {
                _toggleValue = value;
              });
              print(_toggleValue);
              // setState(() {
              //   _toggleValue = value;
              // });
            },
            buttonColor: const Color(0xFF0A3157),
            backgroundColor: const Color(0xFFB5C1CC),
            textColor: const Color(0xFFFFFFFF),
          ),
          // _tabSection(context),
          Expanded(
            child: ChannelsBloc(
              child: ChannelListView(
                filter: Filter.and([
                  Filter.in_(
                      'members', [StreamChat.of(context).currentUser!.id]),
                  Filter.in_(
                      'name',
                      (_toggleValue == 0)
                          ? (widget.orderArr.isNotEmpty
                              ? widget.orderArr
                              : ['Empty'])
                          : (widget.biltiesArr.isNotEmpty
                              ? widget.biltiesArr
                              : ['Empty'])),
                ]),
                channelPreviewBuilder: _channelPreviewBuilder,
                sort: [
                  SortOption("last_message_at", direction: SortOption.DESC)
                ],
                limit: 20,
                channelWidget: ChannelPage(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _channelPreviewBuilder(BuildContext context, Channel channel) {
    final lastMessage = channel.state?.messages.reversed.firstWhereOrNull(
      (message) => !message.isDeleted,
    );

    final subtitle = lastMessage == null ? 'nothing yet' : lastMessage.text!;
    final opacity = (channel.state?.unreadCount ?? 0) > 0 ? 1.0 : 0.5;

    final theme = StreamChatTheme.of(context);
    int _toggleValue = 0;

    return Column(
      children: [
        if (channel.name!.contains('BT'))
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StreamChannel(
                    channel: channel,
                    child: ChannelPage(),
                  ),
                ),
              );
            },
            leading: ChannelAvatar(
              channel: channel,
            ),
            title: ChannelName(
              textStyle: theme.channelPreviewTheme.titleStyle!.copyWith(
                color: theme.colorTheme.textHighEmphasis.withOpacity(opacity),
              ),
            ),
            subtitle: Text(subtitle),
            trailing: channel.state!.unreadCount > 0
                ? CircleAvatar(
                    radius: 10,
                    child: Text(channel.state!.unreadCount.toString()),
                  )
                : const SizedBox(),
          ),
        if (channel.name!.contains('Order'))
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StreamChannel(
                    channel: channel,
                    child: ChannelPage(),
                  ),
                ),
              );
            },
            leading: ChannelAvatar(
              channel: channel,
            ),
            title: ChannelName(
              textStyle: theme.channelPreviewTheme.titleStyle!.copyWith(
                color: theme.colorTheme.textHighEmphasis.withOpacity(opacity),
              ),
            ),
            subtitle: Text(subtitle),
            trailing: channel.state!.unreadCount > 0
                ? CircleAvatar(
                    radius: 10,
                    child: Text(channel.state!.unreadCount.toString()),
                  )
                : const SizedBox(),
          )
      ],
    );

    // Column(children: [
    //   // Orders Chat which will go in other tab
    //   // channel.name!.contains('Order')
    //   //     ? ListTile(
    //   //         onTap: () {
    //   //           Navigator.push(
    //   //             context,
    //   //             MaterialPageRoute(
    //   //               builder: (_) => StreamChannel(
    //   //                 channel: channel,
    //   //                 child: ChannelPage(),
    //   //               ),
    //   //             ),
    //   //           );
    //   //         },
    //   //         leading: ChannelAvatar(
    //   //           channel: channel,
    //   //         ),
    //   //         title: ChannelName(
    //   //           textStyle: theme.channelPreviewTheme.titleStyle!.copyWith(
    //   //             color: theme.colorTheme.textHighEmphasis.withOpacity(opacity),
    //   //           ),
    //   //         ),
    //   //         subtitle: Text(subtitle),
    //   //         trailing: channel.state!.unreadCount > 0
    //   //             ? CircleAvatar(
    //   //                 radius: 10,
    //   //                 child: Text(channel.state!.unreadCount.toString()),
    //   //               )
    //   //             : const SizedBox(),
    //   //       )
    //   //     :
    //   //      SizedBox(),

    //   channel.name!.contains('BT')
    //       ? ListTile(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (_) => StreamChannel(
    //                   channel: channel,
    //                   child: ChannelPage(),
    //                 ),
    //               ),
    //             );
    //           },
    //           leading: ChannelAvatar(
    //             channel: channel,
    //           ),
    //           title: ChannelName(
    //             textStyle: theme.channelPreviewTheme.titleStyle!.copyWith(
    //               color: theme.colorTheme.textHighEmphasis.withOpacity(opacity),
    //             ),
    //           ),
    //           subtitle: Text(subtitle),
    //           trailing: channel.state!.unreadCount > 0
    //               ? CircleAvatar(
    //                   radius: 10,
    //                   child: Text(channel.state!.unreadCount.toString()),
    //                 )
    //               : const SizedBox(),
    //         )
    //       : SizedBox()
    // ]);
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
                labelStyle: TextStyle(color: Colors.black),
                labelColor: Colors.amber,
                tabs: [
                  Tab(
                    text: "Home",
                  ),
                  Tab(text: "Articles"),
                  Tab(text: "User"),
                ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height * 0.2,
            child: TabBarView(children: [
              Container(
                  child: Column(
                children: [],
              )),
              Container(
                child: Text("Articles Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  var Context;

  ChannelPage({Key? key, this.Context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Context = context;
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              messageBuilder: (context, details, messages, defaultMessage) {
                return defaultMessage.copyWith(
                  customAttachmentBuilders: {
                    'voicenote': (context, defaultMessage, attachments) {
                      final url = attachments.first.assetUrl;
                      if (url == null) {
                        return const AudioLoadingMessage();
                      }
                      return AudioPlayerMessage(
                        source: AudioSource.uri(Uri.parse(url)),
                        id: defaultMessage.id,
                      );
                    }
                  },
                );
              },
            ),
          ),
          MessageInput(
            actions: [
              RecordButton(
                recordingFinishedCallback: _recordingFinishedCallback,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _recordingFinishedCallback(String path) {
    final uri = Uri.parse(path);
    File file = File(uri.path);
    file.length().then(
      (fileSize) {
        StreamChannel.of(Context).channel.sendMessage(
              Message(
                attachments: [
                  Attachment(
                    type: 'voicenote',
                    file: AttachmentFile(
                      size: fileSize,
                      path: uri.path,
                    ),
                  )
                ],
              ),
            );
      },
    );
  }
}
