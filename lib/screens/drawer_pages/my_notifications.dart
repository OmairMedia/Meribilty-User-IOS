import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/Api%20Services/notifications/get_notifications.dart';
import 'package:meribiltyapp/config/constants.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  _MyNotificationsState createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: Constants.regular3.copyWith(color: Constants.White),
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
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                  child: FutureBuilder(
                future: getNotifications(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                setState(() {
                                   getNotificationsRead(context,
                                  snapshot.data['data'][index]['id']);
                                });
                              },
                              leading:
                               snapshot.data['data'][index]['read'] == false ?
                               Stack(
                                 children: [
                                  Icon(
                                  Icons.notifications,
                                  size: 30,
                                  color: Constants.Primary,),
                                   Positioned( child: Icon(Icons.circle,size: 12,color: Colors.red,),top: 0,right: 0,),
                                  ]
                               ):
                              Icon(
                                Icons.notifications_outlined,
                                size: 30,
                                color: Constants.Primary,
                              ),
                              title:
                                 snapshot.data['data'][index]['read'] == false ?
                               Text("${snapshot.data['data'][index]['title']}",
                                  style: Constants.heading4
                                      .copyWith(color: Constants.Black)):
                                      Text("${snapshot.data['data'][index]['title']}",
                                  style: Constants.heading4
                                      .copyWith(color: Constants.Black)),
                              subtitle: 
                                     snapshot.data['data'][index]['read'] == false ?
                              Text(
                                  "${snapshot.data['data'][index]['body']}",
                                  style: Constants.regular2
                                      .copyWith(color: Constants.Primary, fontSize: 13,fontWeight: FontWeight.bold)):
                                      Text(
                                  "${snapshot.data['data'][index]['body']}",
                                  style: Constants.regular2
                                      .copyWith(color: Constants.Primary, fontSize: 13,)),
                            ),
                            Divider()
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ),
            
          ],
        ),
      ),
    );
  }
}