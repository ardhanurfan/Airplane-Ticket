import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class FormInput extends StatefulWidget {
  const FormInput(
      {Key? key,
      required this.title,
      required this.hintText,
      this.obscureForm = false,
      required this.controller})
      : super(key: key);

  final String title;
  final String hintText;
  final bool obscureForm;
  final TextEditingController controller;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  var isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style:
                  blackTextStyle.copyWith(fontSize: 14, fontWeight: regular)),
          const SizedBox(height: 6),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureForm ? isObscurePassword : false,
            cursorColor: kBlackColor,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: const BorderSide(color: kPrimaryColor)),
              suffixIcon: widget.obscureForm
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscurePassword = !isObscurePassword;
                        });
                      },
                      child: Icon(
                        isObscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: kGreyColor,
                      ),
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
