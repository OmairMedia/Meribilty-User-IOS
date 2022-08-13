// import 'package:flutter/material.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/home/home.dart';
// import 'package:meribiltyapp/screens/onboarding/ask_location.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:meribiltyapp/screens/authentication/signin.dart';
// import 'package:meribiltyapp/widgets/btns_all.dart';
// import 'package:meribiltyapp/widgets/text_btns.dart';

// class OnBoardingPage extends StatefulWidget {
//   const OnBoardingPage({Key? key}) : super(key: key);

//   @override
//   _OnBoardingPageState createState() => _OnBoardingPageState();
// }

// class _OnBoardingPageState extends State<OnBoardingPage> {
//   final introKey = GlobalKey<IntroductionScreenState>();

//   void _onIntroEnd(context) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => SignIn()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 19.0);

//     const pageDecoration = PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.zero,
//     );

//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       freeze: false,
//       pages: [
//         PageViewModel(
//           useScrollView: false,
//           titleWidget: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (_) => const ask_location()));
//                   },
//                   child: Column(
//                     children: [
//                       // const SizedBox(
//                       //   height: 10,
//                       // ),
//                       Text(
//                         "Skip",
//                         style:
//                             Constants.regular2.copyWith(color: Constants.Black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Image.asset("assets/onbo1.png"),
//               const SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 // AppLocalizations.of(context)!.ride,
//                 "Make an Order",
//                 style: Constants.heading1.copyWith(color: Constants.Primary),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//           // body: "Request a ride get picked up by a \n nearby community driver ",
//           bodyWidget: Text(
//             // AppLocalizations.of(context)!.ridedetail,
//             "Request delivery confirmed by a nearby trusted vendor",
//             style: Constants.regular3.copyWith(color: Constants.Black),
//             textAlign: TextAlign.center,
//           ),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           useScrollView: false,
//           titleWidget: Column(
//             children: [
//               // const SizedBox(
//               //   height: 20,
//               // ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(builder: (_) => const ask_location()),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "Skip",
//                         style:
//                             Constants.regular2.copyWith(color: Constants.Black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Image.asset("assets/tast2.png"),
//               const SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "Confirm Your Driver",
//                 style: Constants.heading1.copyWith(color: Constants.Primary),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//           bodyWidget: Text(
//             "Our Huge fleet network helps you find reliable, safe and cheap deliveries",
//             style: Constants.regular3.copyWith(color: Constants.Black),
//             textAlign: TextAlign.center,
//           ),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           titleWidget: Column(
//             children: [
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(builder: (_) => const ask_location()),
//                     );
//                   },
//                   child: Column(
//                     children: [],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Image.asset("assets/map.png"),
//               const SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 "Track your stuff",
//                 style: Constants.heading1.copyWith(color: Constants.Primary),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//           bodyWidget: Text(
//             "Know your driver in advance and be able to veiw current location in real time on the Map",
//             style: Constants.regular3.copyWith(color: Constants.Black),
//             textAlign: TextAlign.center,
//           ),
//           // image: Image.asset("assets/map.png"),
//           decoration: pageDecoration,
//           footer: Column(
//             children: [
//               CustomBtn(
//                   text: "Get Started !",
//                   onpreased: () {
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const ask_location()));
//                   },
//                   outlinebtn: false)
//             ],
//           ),
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       skipFlex: 0,
//       nextFlex: 0,
//       next: Text(" "),
//       done: Text(
//         "",
//         style: TextStyle(
//           backgroundColor: Colors.orange,
//         ),
//       ),
//       // curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       dotsDecorator: const DotsDecorator(
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(18.0)),
//         ),
//         spacing: EdgeInsets.only(left: 0, right: 0),
//         size: Size(30.0, 10.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(18.0)),
//         ),
//         color: Color(0xFFEFEFF4),
//         activeColor: Color(0xFF2F4D84),
//         activeSize: Size(40.0, 10.0),
//       ),
//       dotsContainerDecorator: const ShapeDecoration(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(18.0)),
//         ),
//       ),
//     );
//   }
// }
