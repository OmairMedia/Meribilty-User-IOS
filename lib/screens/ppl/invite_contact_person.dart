import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';

class InviteContactPerson extends StatefulWidget {
  const InviteContactPerson({Key? key}) : super(key: key);

  @override
  _InviteContactPersonState createState() => _InviteContactPersonState();
}

class _InviteContactPersonState extends State<InviteContactPerson> {
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text(
            "Invite A Contact Person",
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                "Send Invitation To Your Contact Person, An SMS will be sent to him.",
                style: Constants.regular2.copyWith(color: Constants.Grey),
                textAlign: TextAlign.center,
              ),
              custominput(
                  hinttxt: "Fullname",
                  ispassword: false,
                  control: fullname,
                  inputType: TextInputType.text),
              custominput(
                  hinttxt: "Phone Number",
                  ispassword: false,
                  control: phone,
                  inputType: TextInputType.phone),
              CustomBtn(
                  text: "Invite",
                  onpreased: () {
                    Navigator.of(context).pop();
                  },
                  outlinebtn: false)
            ],
          ),
        ));
  }
}
