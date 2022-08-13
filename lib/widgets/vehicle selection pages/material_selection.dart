import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';

class MaterialSelection extends StatefulWidget {
  const MaterialSelection({Key? key, required this.type}) : super(key: key);
  final type;

  @override
  State<MaterialSelection> createState() => _MaterialSelectionState();
}

class _MaterialSelectionState extends State<MaterialSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Constants.Primary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
