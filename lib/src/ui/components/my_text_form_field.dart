import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final FormFieldValidator<String>? validate;
  final bool isPassword;
  final bool isEmail;
  final bool isPhoneNumber;
  final bool obscureText;
  final bool readOnly;
  final IconButton? suffixIconButton;

  const MyTextFormField({
    Key? key,
    required this.label,
    required this.textController,
    this.isPassword = false,
    this.readOnly = false,
    this.validate,
    this.suffixIconButton,
    this.isEmail = false,
    this.isPhoneNumber = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              7,
            ),
            color: MyColors.lightGrey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: TextFormField(
            validator: validate,
            readOnly: readOnly,
            textCapitalization: (determineInputType() == TextInputType.text)
                ? TextCapitalization.words
                : TextCapitalization.none,
            cursorRadius: const Radius.circular(
              7.0,
            ),
            controller: textController,
            style: const TextStyle(
              fontSize: 15.0,
            ),
            obscureText: obscureText,
            keyboardType: determineInputType(),
            decoration: InputDecoration(
              suffixIcon: suffixIconButton,
              border: InputBorder.none,
              label: Text(
                label,
                style: TextStyle(
                  color: MyColors.darkGrey,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  TextInputType determineInputType() {
    if (isEmail) {
      return TextInputType.emailAddress;
    }
    if (isPassword) {
      return TextInputType.visiblePassword;
    }
    if (isPhoneNumber) {
      return TextInputType.phone;
    }
    return TextInputType.text;
  }
}