import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class PasswordWidget extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;

  const PasswordWidget(
      {Key? key, required this.controller, required this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: ValidationBuilder().minLength(5,"Please enter valid password!").build(),
              controller: controller,
              obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 12),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                hintText: placeholder,
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
        )
      ],
    );
  }
}
