import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class EmailWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailWidget({Key? key, required this.controller}) : super(key: key);

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
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              validator: ValidationBuilder().email("Wrong email format!").build(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 12),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
          ),
        )
      ],
    );
  }
}
