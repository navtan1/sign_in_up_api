import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Password extends StatefulWidget {
  const Password({Key? key, this.controller, this.validator}) : super(key: key);

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool a = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.sp),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.lock_outlined,
          color: Colors.black,
        ),
        title: TextFormField(
          validator: widget.validator,
          obscureText: a,
          controller: widget.controller,
          decoration: const InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              a = !a;
            });
          },
          child: Icon(
            a == false
                ? Icons.remove_red_eye_outlined
                : Icons.visibility_off_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }
}
