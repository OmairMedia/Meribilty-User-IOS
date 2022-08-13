import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meribiltyapp/Api%20Services/upload/upload_upcountry_documents.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/add_address_info.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/file_picker.dart';

import '../Api Services/province/provinceList.dart';
import '../Api Services/province/staticData.dart';

class UploadDocumnetsUpcountry extends StatefulWidget {
  UploadDocumnetsUpcountry(
      {Key? key,
      required this.orderNo,
      required this.functionToRun,
      required this.vendorName,
      required this.vendorPhone})
      : super(key: key);
  final orderNo;
  Function functionToRun;
  final String vendorPhone;
  final vendorName;
  @override
  State<UploadDocumnetsUpcountry> createState() =>
      _UploadDocumnetsUpcountryState();
}

class _UploadDocumnetsUpcountryState extends State<UploadDocumnetsUpcountry> {
  var detailsPackingList;
  var billOfLanding;
  FilePickerResult? detailsPackingListFile;
  FilePickerResult? billOfLandingFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Center(
                child: Text(
              "Upload Documents",
              style: Constants.heading3,
              textAlign: TextAlign.center,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FilePickerWidget(
                Txt: "Bill of Lading",
                OnChange: () {},
                ontap: () async {
                  cameraGalleryModalBottomSheet(context,
                      // Function For Picking Camera Image
                      () async {
                    ImagePicker.platform
                        .getImage(source: ImageSource.camera)
                        .then((value) {
                      setState(() {
                        billOfLanding = value!.path;
                      });
                    });
                  },
                      // Function For PIcking Files From Gallery
                      () async {
                    billOfLandingFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
                    );
                    setState(() {
                      billOfLanding = billOfLandingFile!.files.first.path;
                    });
                    print(billOfLanding);
                  });
                  
                },
                ispicked: billOfLanding == null ? false : true),
          ),
          FilePickerWidget(
              Txt: "Detail Packing List",
              OnChange: () {},
              ontap: () async {
                cameraGalleryModalBottomSheet(context,
                      // Function For Picking Camera Image
                      () async {
                    ImagePicker.platform
                        .getImage(source: ImageSource.camera)
                        .then((value) {
                      setState(() {
                        detailsPackingList = value!.path;
                      });
                    });
                  },
                      // Function For PIcking Files From Gallery
                      () async {
                    detailsPackingListFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
                    );
                    setState(() {
                      detailsPackingList = detailsPackingListFile!.files.first.path;
                    });
                    print(detailsPackingList);
                  });
              },
              ispicked:detailsPackingList == null ? false : true),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomBtn(
                text: "Proceed",
                onpreased: () {
                  if (billOfLanding == null && detailsPackingList == null) {
                    Fluttertoast.showToast(
                        msg: "Please Upload atleast one document");
                  } else {
                    uploadUpcountryDocuments(
                        detailsPackingList == null ? null : detailsPackingList,
                        billOfLanding == null ? null : billOfLanding,
                        widget.orderNo,
                        context,
                        false,
                        functionToRun: widget.functionToRun);
                  }
                },
                outlinebtn: false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomBtn(
                text: "Upload Later",
                onpreased: () async{


                  ApiResponseService apiResponseService = ApiResponseService();
                  ProvinceListmodel provinceListmodel = await  apiResponseService.getResponse();
                  print("\n\n\nMera model data ${provinceListmodel.data}\n\n\n");
                  Selectedvalue.selectedvalue.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddAddressInfo(
                            provinceListmodel: provinceListmodel,

                              orderNo: widget.orderNo,
                              functionToRun: widget.functionToRun)));
                  //          Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //     builder: (context) => SelectPaymentMethod(orderNo: widget.orderNo, functionToRun: widget.functionToRun,)));
                },
                outlinebtn: true),
          )
        ],
      ),
    );
  }
}
