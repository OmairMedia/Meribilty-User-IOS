import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meribiltyapp/Api%20Services/upload/upload_transit_documents.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/add_address_info.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/file_picker.dart';

import '../Api Services/province/provinceList.dart';
import '../Api Services/province/staticData.dart';

class UploadDocumnetsTransit extends StatefulWidget {
  const UploadDocumnetsTransit(
      {Key? key,
      required this.orderNo,
      required this.vendorPhone,
      required this.vendorName,
      required this.functionToRun})
      : super(key: key);
  final String orderNo;
  final String vendorPhone;
  final vendorName;
  final Function functionToRun;
  @override
  State<UploadDocumnetsTransit> createState() => _UploadDocumnetsTransitState();
}

class _UploadDocumnetsTransitState extends State<UploadDocumnetsTransit> {
  var billOfLanding;
  var invoice;
  var gd;
  var demandLetter;
  var packagingList;
  FilePickerResult? billOfLandingFile;
  FilePickerResult? invoiceFile;
  FilePickerResult? gdFile;
  FilePickerResult? demandLetterFile;
  FilePickerResult? packagingListFile;
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
    padding:
        const EdgeInsets
                .only(
            top: 20),
    child:
        FilePickerWidget(
            Txt:
                "Bill Of Lading",
            OnChange:
                () {},
            ontap:
                () async {
                    cameraGalleryModalBottomSheet(
            context,
            // Function For Picking Camera Image
            () async {
          ImagePicker
              .platform
              .getImage(
                  source: ImageSource
                      .camera)
              .then(
                  (value) {
            setState(
                () {
              billOfLanding =
                  value!.path;
            });
          });
        },
            // Function For PIcking Files From Gallery
            () async {
          billOfLandingFile =
              await FilePicker
                  .platform
                  .pickFiles(
            type: FileType
                .custom,
            allowedExtensions: [
              'jpg',
              'pdf',
              'jpeg',
              'png'
            ],
          );
          setState(() {
          billOfLanding = billOfLandingFile!
              .files
              .first
              .path;
        });
        print(
            billOfLanding);
        });
            //   billOfLandingFile = await FilePicker
            //       .platform
            //       .pickFiles(
            //     type:
            //         FileType.custom,
            //     allowedExtensions: [
            //       'jpg',
            //       'pdf',
            //       'jpeg',
            //       'png'
            //     ],
            //   );
            //   setState(
            //       () {
            //     billOfLanding = billOfLandingFile!
            //         .files
            //         .first
            //         .path;
            //   });
            },
            ispicked: billOfLanding ==
                    null
                ? false
                : true),
  ),
  FilePickerWidget(
      Txt: "Invoice",
      OnChange: () {},
      ontap:
          () async {
        cameraGalleryModalBottomSheet(
            context,
            // Function For Picking Camera Image
            () async {
          ImagePicker
              .platform
              .getImage(
                  source: ImageSource
                      .camera)
              .then(
                  (value) {
            setState(
                () {
              invoice =
                  value!.path;
            });
          });
        },
            // Function For PIcking Files From Gallery
            () async {
          invoiceFile =
              await FilePicker
                  .platform
                  .pickFiles(
            type: FileType
                .custom,
            allowedExtensions: [
              'jpg',
              'pdf',
              'jpeg',
              'png'
            ],
          );
          setState(() {
          invoice = invoiceFile!
              .files
              .first
              .path;
        });
        print(
            invoice);
        });

        
      },
      ispicked:
          invoice ==
                  null
              ? false
              : true),
  FilePickerWidget(
      Txt: "GD",
      OnChange: () {},
      ontap:
          () async {
        cameraGalleryModalBottomSheet(
            context,
            // Function For Picking Camera Image
            () async {
          ImagePicker
              .platform
              .getImage(
                  source: ImageSource
                      .camera)
              .then(
                  (value) {
            setState(
                () {
              gd =
                  value!.path;
            });
          });
        },
            // Function For PIcking Files From Gallery
            () async {
          gdFile =
              await FilePicker
                  .platform
                  .pickFiles(
            type: FileType
                .custom,
            allowedExtensions: [
              'jpg',
              'pdf',
              'jpeg',
              'png'
            ],
          );
          setState(() {
          gd = gdFile!
              .files
              .first
              .path;
        });
        print(
            gd);
        });
      },
      ispicked:
          gd == null
              ? false
              : true),
  FilePickerWidget(
      Txt:
          "Demand Letter",
      OnChange: () {},
      ontap:
          () async {
          cameraGalleryModalBottomSheet(
            context,
            // Function For Picking Camera Image
            () async {
          ImagePicker
              .platform
              .getImage(
                  source: ImageSource
                      .camera)
              .then(
                  (value) {
            setState(
                () {
              demandLetter =
                  value!.path;
            });
          });
        },
            // Function For PIcking Files From Gallery
            () async {
          demandLetterFile =
              await FilePicker
                  .platform
                  .pickFiles(
            type: FileType
                .custom,
            allowedExtensions: [
              'jpg',
              'pdf',
              'jpeg',
              'png'
            ],
          );
          setState(() {
          demandLetter = demandLetterFile!
              .files
              .first
              .path;
        });
        print(
            invoice);
        });
      },
      ispicked:
          demandLetter ==
                  null
              ? false
              : true),
  FilePickerWidget(
      Txt:
          "Packing List",
      OnChange: () {},
      ontap:
          () async {
          cameraGalleryModalBottomSheet(
            context,
            // Function For Picking Camera Image
            () async {
          ImagePicker
              .platform
              .getImage(
                  source: ImageSource
                      .camera)
              .then(
                  (value) {
            setState(
                () {
              packagingList =
                  value!.path;
            });
          });
        },
            // Function For PIcking Files From Gallery
            () async {
          packagingListFile =
              await FilePicker
                  .platform
                  .pickFiles(
            type: FileType
                .custom,
            allowedExtensions: [
              'jpg',
              'pdf',
              'jpeg',
              'png'
            ],
          );
          setState(() {
          packagingList = packagingListFile!
              .files
              .first
              .path;
        });
        print(
            packagingList);
        });
      },
      ispicked:
          packagingList ==
                  null
              ? false
              : true),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomBtn(
                text: "Proceed",
                onpreased: () {
                  if (billOfLanding == null &&
                      invoice == null &&
                      gd == null &&
                      demandLetter == null &&
                      packagingList == null) {
                    Fluttertoast.showToast(
                        msg: "Please upload atleast one document");
                  } else {
                    uploadTransitDocuments(
                        billOfLanding == null ? null : billOfLanding,
                        invoice == null ? null : invoice,
                        gd == null ? null : gd,
                        demandLetter == null ? null : demandLetter,
                        packagingList == null ? null : packagingList,
                        widget.orderNo,
                        context,
                        widget.vendorPhone,
                        widget.vendorName,
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

                  Navigator.push(context, MaterialPageRoute(builder: (_)=>AddAddressInfo(provinceListmodel:provinceListmodel,orderNo:widget.orderNo,
                  functionToRun: widget.functionToRun)));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SelectPaymentMethod(
                  //               orderNo: widget.orderNo,
                  //               functionToRun: widget.functionToRun,
                  //             )));
                },
                outlinebtn: true),
          )
        ],
      ),
    );
  }
}
