import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final FormFieldValidator<String>? validate;
  final TextInputType textInputType;
  final bool obscureText;
  final bool readOnly;
  final IconButton? suffixIconButton;

  const MyTextFormField({
    Key? key,
    required this.label,
    required this.textController,
    this.readOnly = false,
    this.validate,
    this.suffixIconButton,
    this.textInputType = TextInputType.text,
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
          padding: textInputType == TextInputType.visiblePassword // Has a suffix IconButton
              ? const EdgeInsets.only(left: 10.0)
              : const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            validator: validate,
            readOnly: readOnly,
            textCapitalization: (textInputType == TextInputType.text)
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
            keyboardType: textInputType,
            decoration: InputDecoration(
              suffixIcon: suffixIconButton,
              border: InputBorder.none,
              label: Text(
                label,
                style: const TextStyle(
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
}
