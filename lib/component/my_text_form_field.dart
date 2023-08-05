import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';

class MyTextFormField extends StatelessWidget {
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool absorbing;
  final void Function()? onTap;

  const MyTextFormField({
    Key? key,
    this.label,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.hintText,
    this.absorbing = false,
    this.onTap,
  }) : super(key: key);

  OutlineInputBorder border({Color color = primary, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "$label",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        InkWell(
          onTap: absorbing ? onTap : null,
          child: AbsorbPointer(
            absorbing: absorbing,
            child: TextFormField(
              controller: controller,
              cursorColor: primary,
              validator: validator,
              maxLength: maxLength,
              maxLines: maxLines,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: primary,
              ),
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                hintText: hintText,
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700,
                ),
                border: border(
                  width: 0.75,
                ),
                focusedBorder: border(
                  color: primary,
                  width: 1.2,
                ),
                disabledBorder: border(
                  width: 0.75,
                ),
                enabledBorder: border(
                  width: 0.75,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
