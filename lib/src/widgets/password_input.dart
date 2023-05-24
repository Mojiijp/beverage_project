import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordInput extends StatefulWidget {
  final String label;
  //final String initialValue;
  final bool enable;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const PasswordInput({
  super.key,
  required this.label,
  required this.enable,
  required this.validator,
  required this.controller,
  //required this.initialValue
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  // final controller = Get.put(CreateAccController());

  //final passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();

  var _isObscured;


  @override
  void initState() {
    _isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      focusNode: passwordFocusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xff609966)),
          borderRadius: BorderRadius.circular(20)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xff609966)),
            borderRadius: BorderRadius.circular(20)
        ),
        // border: OutlineInputBorder(
        //     borderSide: const BorderSide(width: 2, color: Color(0xff609966)),
        //     borderRadius: BorderRadius.circular(20)
        // ),
        prefixIcon: Icon(Icons.lock, color: Colors.black),
        suffixIcon: IconButton(
          icon : _isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          color: Colors.black,
          onPressed: () {
            setState(() {
              _isObscured =! _isObscured;
            });
            },
        ),
        labelText: widget.label,
      ),
    );
  }
}