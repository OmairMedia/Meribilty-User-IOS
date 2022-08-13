// //import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/authentication/signin.dart';

// //import 'package:meribiltyapp/screens/onboarding/onboarding.dart';

// class Language extends StatefulWidget {
//   const Language({Key? key}) : super(key: key);

//   @override
//   _LanguageState createState() => _LanguageState();
// }

// class _LanguageState extends State<Language> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/first.png"), fit: BoxFit.cover)),
//         child: SafeArea(
//           child: Center(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Image.asset("assets/logo.png"),
//                   const SizedBox(
//                     height: 100,
//                   ),
//                   Container(
//                       padding: EdgeInsets.only(left: 20, right: 20),
//                       width: double.infinity,
//                       child: Container(
//                         width: 200,
//                         height: 90,
//                         padding: EdgeInsets.all(10),
//                         child: ElevatedButton(
//                           child: Text(
//                             "English",
//                             style: Constants.regular2
//                                 .copyWith(color: Constants.Black),
//                           ),
//                           style: ButtonStyle(
//                               alignment: Alignment.center,
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.white),
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 const RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(8)),
//                                     side: BorderSide(
//                                       color: Color(0xFF2F4D84),
//                                       width: 2,
//                                     )),
//                               )),
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                          SignIn()));
//                           },
//                         ),
//                       )),
//                   Container(
//                       padding: EdgeInsets.only(left: 20, right: 20),
//                       width: double.infinity,
//                       child: Container(
//                         width: 200,
//                         height: 90,
//                         padding: EdgeInsets.all(10),
//                         child: ElevatedButton(
//                             child: Text(
//                               "اردو".toUpperCase(),
//                               style: Constants.regular2
//                                   .copyWith(color: Constants.Black),
//                             ),
//                             style: ButtonStyle(
//                                 alignment: Alignment.center,
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         Colors.white),
//                                 shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(8)),
//                                       side: BorderSide(
//                                         color: Color(0xFF2F4D84),
//                                         width: 2,
//                                       )),
//                                 )),
//                             onPressed: () {
//                               // final provide = context
//                               //     .read<LocaleProvider>()
//                               //     .setLocale(const Locale('hi'));
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => SignIn()));
//                             }),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
