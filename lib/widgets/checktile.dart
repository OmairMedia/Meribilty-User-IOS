import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';

class CheckTile extends StatefulWidget {
  final String Txt;
  final Function OnChange;
  final bool ischecked;
  const CheckTile(
      {Key? key,
      required this.Txt,
      required this.OnChange,
      required this.ischecked})
      : super(key: key);

  @override
  State<CheckTile> createState() => _CheckTileState();
}

class _CheckTileState extends State<CheckTile> {
  bool isselected = false;
  @override
  void initState() {
    super.initState();
    isselected = widget.ischecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isselected = !isselected;
          widget.OnChange(isselected);
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(left: 20, top: 10),
        duration: Duration(seconds: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: (isselected) ? Constants.Primary : Constants.Grey),
              child: Icon(
                FontAwesomeIcons.check,
                size: 16,
                color: Constants.White,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.Txt.toString(),
              style: Constants.regular4,
            ),
          ],
        ),
      ),
    );
  }
}
