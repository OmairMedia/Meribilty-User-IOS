// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:meribiltyapp/config/constants.dart';

// class ratings extends StatefulWidget {
//   const ratings({Key? key}) : super(key: key);

//   @override
//   _ratingsState createState() => _ratingsState();
// }

// class _ratingsState extends State<ratings> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Rating',
//           style: Constants.heading3.copyWith(color: Constants.White),
//         ),
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(child: const Icon(FontAwesomeIcons.chevronLeft),
//         onTap:(){ Navigator.pop(context);},
//         ),
//       ),
//       backgroundColor: Constants.Primery,
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(12, 20, 12, 30),
//         child: Stack(children: [
//           Container(
//             margin: const EdgeInsets.only(top: 48),
//             height: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             child: Center(
//                 child: Padding(
//               padding: const EdgeInsets.only(top: 50.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Shahid Ali',
//                     style: Constants.heading2.copyWith(color: Constants.Black),
//                   ),
//                   Text(
//                     'ABC-123',
//                     style: Constants.regular3.copyWith(color: Constants.grey),
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   Text(
//                     'How was your experience ?',
//                     style:
//                         Constants.heading3.copyWith(color: Constants.Primery),
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                     child: Text(
//                       'Your feedback will help us improve \n                     your next move.',
//                       style: Constants.heading1.copyWith(color: Constants.grey),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   RatingBar.builder(
//                     initialRating: 3,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     itemBuilder: (context, _) => const Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       //print(rating);
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: TextFormField(
//                       minLines:
//                           6, // any number you need (It works as the rows for the textarea)
//                       keyboardType: TextInputType.multiline,
//                       maxLines: null,
//                       decoration: const InputDecoration(
//                         fillColor: Colors.grey,
//                         border: OutlineInputBorder(),
//                         hintText: 'Additional Comments',
//                         hintStyle: TextStyle(color: Colors.grey) ,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10,),
//                   SizedBox(
//                     height: 44,
//                     width: 250.0,
//                     child: TextButton(onPressed: (){
//                     },
//                      child: Text('Submit Review',style: Constants.regular3.copyWith(color: Constants.White),),
//                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Constants.Primery),
//                       shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
//                      ),
//                      ),
//                   )
//                 ],
//               ),
//             )),
//           ),
//           const Align(
//             alignment: Alignment.topCenter,
//             child: SizedBox(
//               child: CircleAvatar(
//                 radius: 45.0,
//                 backgroundImage: AssetImage('assets/images/Avatar.png'),
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }