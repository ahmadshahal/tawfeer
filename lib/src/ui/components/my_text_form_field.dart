import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool enabled;
  final Color? textColor;
  final int? maxLength;
  final GestureTapCallback? onTap;
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
    this.enabled = true,
    this.textColor = MyColors.darkGrey,
    this.maxLength,
    this.prefixText,
    this.onTap,
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
            maxLength: maxLength,
            onChanged: onChanged,
            enabled: enabled,
            onTap: onTap,
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
              counterText: "",
              suffixIcon: suffixIconButton,
              hintText: hint,
              errorMaxLines: 2,
              errorStyle: const TextStyle(fontSize: 11),
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
              labelStyle: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
              floatingLabelStyle: TextStyle(
                fontSize: 15,
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DescriptionTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController textController;

  const DescriptionTextFormField({
    Key? key,
    required this.label,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyStyles.radius),
        color: MyColors.lightGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          cursorRadius: const Radius.circular(MyStyles.radius),
          controller: textController,
          style: const TextStyle(
            fontSize: 15.0,
          ),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
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
            labelStyle: const TextStyle(fontSize: 14, color: MyColors.darkGrey),
            floatingLabelStyle: const TextStyle(
              fontSize: 15,
              color: MyColors.darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
