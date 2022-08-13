
import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';

import 'package:countdown_flutter_ns/countdown_flutter_ns.dart';

class Foo extends StatelessWidget {
  const Foo({required this.seconds});
  final int seconds;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CountdownFormatted(
        duration: Duration(seconds: seconds),
        builder: (BuildContext ctx, String remaining) {
          return Text(remaining, style: Constants.heading1.copyWith(color: Constants.Primary),); // 01:00:00
        },
      ),
    );
  }
}
