import 'package:flutter/material.dart';

showloadingDialog(message,context){
  showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
       return ProgressDialog(message: "$message",);
     });
  
}

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({required this.message});
  // const ProgressDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(width: 4,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(width: 20,),
              Text(message,
              style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'Montserrat-Regular'),)
            ],

          ),
        ),
      ),
      
    );
  }
}