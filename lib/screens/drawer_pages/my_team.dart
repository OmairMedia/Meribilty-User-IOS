import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamServide.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/invitepage.dart';
import 'package:meribiltyapp/screens/ppl/invite_contact_person.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({Key? key}) : super(key: key);

  @override
  _MyTeamState createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  MyTeamService _myTeamService = Get.put(MyTeamService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Team",
          style: Constants.heading3.copyWith(color: Constants.White),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomBtn(text: "Add Team Member", onpreased: (){
              Get.to(InviteFriend_UI());
            }, outlinebtn:false),
            Obx(() {
              if (_myTeamService.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _myTeamService.myTeam[0].data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,

                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: ListTile(
                        
                        title: Text("${_myTeamService.myTeam[0].data![index].fullname}",
                            style: Constants.heading4.copyWith(
                              color: Constants.Black,
                            )),
                        subtitle: Text(
                       "${_myTeamService.myTeam[0].data![index].phone}",
                        style: Constants.regular5.copyWith(color: Constants.Grey)),
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
