import 'package:flutter/material.dart';

import '../../Api Services/AdminApproval/Waiting_for_admin.dart';
import '../transit/Waiting_for_admin.dart';

class TransitWaitingAdminApproval extends StatefulWidget {
  const TransitWaitingAdminApproval({ Key? key }) : super(key: key);

  @override
  State<TransitWaitingAdminApproval> createState() => _TransitWaitingAdminApprovalState();
}

class _TransitWaitingAdminApprovalState extends State<TransitWaitingAdminApproval> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
            future: getWaitingforAdminApi(),
            builder: ( context,AsyncSnapshot snapshot){
             if (snapshot.connectionState == ConnectionState.none ||
                !snapshot.hasData ) {
              return Center(child: SizedBox());
            } else if (snapshot.hasError) {
              return Center(child: Text(' '));
            } else if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount:  snapshot.data == null ? 0 : snapshot.data.length,
                itemBuilder: (context,int i){
                return(
                  WaitingForAdminApproval(
                    colored: Colors.indigo,
                    status: "Waiting for Admin Approval",
                    data: snapshot.data[i],
                ));
              }
              );
            }
            else{
              return(
                SizedBox()
              );
            }
          }),
    );
  }
}