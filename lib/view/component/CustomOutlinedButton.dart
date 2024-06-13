import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? text;
  final Function? role;
  const CustomOutlinedButton({
    this.text,
    this.role,
  }) ;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.85,
      height: 45,
      child: TextButton(
        onPressed: () {
          role!();
        },
        child: Text(
          "$text",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
