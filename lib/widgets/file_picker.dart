import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';


class FilePickerWidget extends StatefulWidget {
  final String Txt;
  final Function OnChange;
  final Function ontap;
  final bool ispicked;
  const FilePickerWidget({
    Key? key,
    required this.Txt,
    required this.OnChange,
    required this.ontap,
    required this.ispicked
  }) : super(key: key);

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  bool isselected = false;
  
  @override
  void initState() {
    super.initState();
    isselected = widget.ispicked;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.ontap();
        // setState(() {
        //   isselected = !isselected;
        //   widget.OnChange(isselected);
        // });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(left: 20, top: 10),
        duration: Duration(seconds: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                Text(
                  widget.Txt.toString(),
                  style: Constants.regular3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none,
                top: BorderSide.none,
              )),
              child: Text(widget.ispicked?"Selected" : "Upload",
                  style:Constants.heading3.copyWith(color: Constants.Grey),),
            ),
            Icon(FontAwesomeIcons.chevronRight,size: 18,color: Constants.Grey,),
                  ],
                ),
              ],
            ),
            Divider(thickness: 1,)
          ],
        ),
      ),
    );
  }
}