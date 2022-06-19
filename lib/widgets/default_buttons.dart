import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../uitl/constance.dart';

class AuthButton extends StatelessWidget {
  String title;
  void Function() onPressed;

  AuthButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shape: const StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 1.h),
          elevation: 8,
          minimumSize: Size(85.w, 40),
      ),
      onPressed: onPressed,
    );
  }
}


