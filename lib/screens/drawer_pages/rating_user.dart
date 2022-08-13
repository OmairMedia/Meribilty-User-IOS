import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/ratings/RatingsServices.dart';
import 'package:meribiltyapp/config/constants.dart';

class ratings_user extends StatefulWidget {
  ratings_user({
    required this.orderNo,
    required this.vendorName,
    Key? key,
  }) : super(key: key);
  final String orderNo;
  final String vendorName;

  @override
  _ratings_userState createState() => _ratings_userState();
}

class _ratings_userState extends State<ratings_user> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ratingCmnts = TextEditingController();
    double starRating = 1.0;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Rating',
          style: Constants.heading3.copyWith(color: Constants.White),
        ),
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(FontAwesomeIcons.chevronLeft),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Constants.Primary,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 28),
              height: MediaQuery.of(context).size.height * 0.75 ,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Text(
                      "${widget.vendorName}",
                      style: Constants.heading2.copyWith(color: Constants.Black),
                    ),
                    Text(
                      "Order# ${widget.orderNo}",
                      style: Constants.regular3.copyWith(color: Constants.Grey),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'How was your experience ?',
                      style:
                          Constants.heading2.copyWith(color: Constants.Primary),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Your feedback will help us improve your next move.',
                        style: Constants.regular3.copyWith(color: Constants.Grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      maxRating: 6,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                          starRating = rating;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        minLines:
                            6, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(),
                          hintText: 'Additional Comments',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: ratingCmnts,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 44,
                      width: 250.0,
                      child: TextButton(
                        onPressed: () {
                          // if (starRating.text.isEmpty) {
                          //   var snackBar = SnackBar(
                          //       content: Text('Please Give Ratings'));
                          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // } 
                           if (ratingCmnts.text.isEmpty || starRating == null) {
                             print(starRating);
                            Get.snackbar(
                                'Error:',
                                'Please Give Ratings',
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            // var snackBar = SnackBar(
                            //     content: Text('Please Add your comments'));
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                           else {
                            print(starRating);
                            giveRatings(ratingCmnts.text, starRating,widget.orderNo, context);
                          }
                        },
                        child: Text(
                          'Submit Review',
                          style:
                              Constants.regular3.copyWith(color: Constants.White),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Constants.Primary),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)))),
                      ),
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
