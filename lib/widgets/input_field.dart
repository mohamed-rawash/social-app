import 'package:flutter/material.dart';
import 'package:social_app/uitl/constance.dart';

class InputField extends StatelessWidget {

  String? title;
  String? hint;
  String? Function(String?)? validator;
  Function(String?)? onSaved;
  TextEditingController? controller;
  bool isPassword;
  Widget? suffixIcon;


  InputField({
    required this.title,
    this.hint,
    required this.validator,
    this.onSaved,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.headline2,
          ),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: const  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2
                ),
              ),
              focusedBorder: const  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: accentColor,
                  width: 2
                ),
              ),
              suffixIcon: suffixIcon,
              suffixIconColor: primaryColor,
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.headline4
            ),
            controller: controller,
            cursorColor: Colors.black,
            obscureText: isPassword,
            obscuringCharacter: '*',
            validator: validator,
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
