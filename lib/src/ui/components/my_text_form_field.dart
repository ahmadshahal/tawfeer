import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/themes/styles/styles.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final FormFieldValidator<String>? validate;
  final TextInputType textInputType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool readOnly;
  final String? hint;
  final String? prefixText;
  final IconButton? suffixIconButton;

  const MyTextFormField({
    Key? key,
    required this.label,
    required this.textController,
    this.readOnly = false,
    this.onChanged,
    this.hint,
    this.prefixText,
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
            borderRadius: BorderRadius.circular(MyStyles.radius),
            color: MyColors.lightGrey,
          ),
        ),
        Padding(
          padding: textInputType ==
                  TextInputType.visiblePassword // Has a suffix IconButton
              ? const EdgeInsets.only(left: 10.0)
              : const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            onChanged: onChanged,
            validator: validate,
            readOnly: readOnly,
            textCapitalization: (textInputType == TextInputType.text)
                ? TextCapitalization.sentences
                : TextCapitalization.none,
            cursorRadius: const Radius.circular(MyStyles.radius),
            controller: textController,
            style: const TextStyle(
              fontSize: 15.0,
            ),
            obscureText: obscureText,
            keyboardType: textInputType,
            decoration: InputDecoration(
              suffixIcon: suffixIconButton,
              hintText: hint,
              prefixText: prefixText,
              prefixStyle: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
              border: InputBorder.none,
              label: Text(
                label,
              ),
              labelStyle:
                  const TextStyle(fontSize: 14, color: MyColors.darkGrey),
              floatingLabelStyle: const TextStyle(
                fontSize: 15,
                color: MyColors.darkGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
