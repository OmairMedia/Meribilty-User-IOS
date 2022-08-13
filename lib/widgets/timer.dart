// import 'package:flutter/material.dart';
// import 'package:flutter_countdown_timer/index.dart';
// import 'package:meribiltyapp/config/constants.dart';

// class Timer extends StatefulWidget {
//   Timer({Key? key, required this.onEnd,required  this.endTime, required this.remainingMinutes, required this.remainingSeconds}) : super(key: key);
//   void Function() onEnd;
//   int endTime;
//   int remainingMinutes;
//   int remainingSeconds;
//   @override
//   State<Timer> createState() => _TimerState();
// }

// class _TimerState extends State<Timer> {
//   int _minutes = 0;
//     int _seconds = 0;

//   @override
// void initState() {
//   setState(() {
// _minutes = widget.remainingMinutes;
// _seconds = widget.remainingSeconds;

    
//   });
// }
//   int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * _minutes * 10;
  
//   @override
//   void dispose() {
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:  CountdownTimer(
//               endTime: widget.onEnd,
//               onEnd: widget.onEnd,
//               textStyle: Constants.heading1.copyWith(color: Constants.Primary),
//               endWidget: Center(
//                   child: Text(
//                 "You will get a quote on your request shortly",
//                 style: const TextStyle(
//                     fontSize: 15,
//                     color: Color(0xFF2F4D84),
//                     fontWeight: FontWeight.bold),
//               )),
//             ),,
//     );
//   }
// }
