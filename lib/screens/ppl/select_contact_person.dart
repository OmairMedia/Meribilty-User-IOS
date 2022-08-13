import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/clearing%20agent/clearingAgentSlef.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/clearing%20agent/clearing_agent_ftom_team.dart';
import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamServide.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/invitepage.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/ppl/invite_contact_person.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';

import '../../InviteNewAgent/InviteUI.dart';

class SelectContactPerson extends StatefulWidget {
  SelectContactPerson(
      {Key? key, required this.OrderNo, required this.functionToRun})
      : super(key: key);
  final OrderNo;
  final Function functionToRun;
  @override
  _SelectContactPersonState createState() => _SelectContactPersonState();
}

class _SelectContactPersonState extends State<SelectContactPerson> {
  MyTeamService _myTeam = Get.put(MyTeamService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Payment Method",
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              elevation: 10,
              // clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                // side: BorderSide(color: Constants.Primary, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Select Contact Person Or \n Clearing Agents",
                        style:
                            Constants.heading4.copyWith(color: Constants.Black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      color: Constants.Grey,
                    ),
                    ListTile(
                      onTap: () => {
                        _myTeam.fetchMyTeamService(),
                        invitedUsersListModel123(context)
                      },
                      title: Text(
                        'Select From Existing List',
                        style: Constants.heading3
                            .copyWith(color: Constants.Primary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      color: Constants.Grey,
                    ),
                    ListTile(
                      onTap: () => {


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InviteNewAgent_UI(functionToRun: widget.functionToRun, orderNo: widget.OrderNo,)))
                      },
                      title: Text(
                        'Invite New',
                        style: Constants.heading3
                            .copyWith(color: Constants.Primary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      color: Constants.Grey,
                    ),
                    ListTile(
                      onTap: () async {
                        await widget.functionToRun();
                        ManageBySelf(orderNo: widget.OrderNo, context: context);
                      },
                      title: Text(
                        'I Will Manage Myself',
                        style: Constants.heading3
                            .copyWith(color: Constants.Primary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  var name = [
    "Rayyan jamil",
    "Rayyan jamil",
    "Rayyan jamil",
    "Rayyan jamil",
    "Rayyan jamil",
    "Rayyan jamil",
    "Rayyan jamil",
  ];
  var image = [
    'assets/images/Avatar.png',
    'assets/images/Avatar.png',
    'assets/images/Avatar.png',
    'assets/images/Avatar.png',
    'assets/images/Avatar.png',
    'assets/images/Avatar.png',
    'assets/images/Avatar.png',
  ];

  void invitedUsersListModel123(
    context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Text(
                          "Team Members",
                          style: Constants.heading3
                              .copyWith(color: Constants.Primary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (_myTeam.isLoading == true) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _myTeam.myTeam[0].data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(
                                    "${_myTeam.myTeam[0].data![index].fullname}"),
                                tileColor: selectedIndexMember == index
                                    ? Constants.Primary
                                    : null,
                                trailing: Text(
                                  "${_myTeam.myTeam[0].data![index].phone}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedIndexMember = index;
                                    selectedMemberPhone =
                                        _myTeam.myTeam[0].data![index].phone;
                                    selectedMemberName =
                                        _myTeam.myTeam[0].data![index].fullname;
                                  });
                                  print(selectedMemberName);
                                },
                              );
                            },
                          ),
                          CustomBtn(
                              text: "Proceed",
                              onpreased: selectedIndexMember != null
                                  ? () async {
                                      await widget.functionToRun();
                                      ManageByTeamMember(
                                          functionToRun: widget.functionToRun,
                                          orderNo: widget.OrderNo,
                                          phone: selectedMemberPhone,
                                          context: context,
                                          name: selectedMemberName);
                                    }
                                  : () {},
                              outlinebtn: false)
                        ],
                      );
                    }
                  })
                ],
              ),
            );
          });
        });
  }

  int? selectedIndexMember;
  var selectedMemberPhone;
  var selectedMemberName;
}

// Invited Users List

