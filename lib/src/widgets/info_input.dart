import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InfoInput extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter> textFormat;
  //final String initialValue;
  final bool enable;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const InfoInput({
  super.key,
  required this.label,
  required this.enable,
  required this.validator,
  required this.keyboardType,
  required this.textFormat,
  required this.controller,
  //required this.initialValue
  });

  @override
  State<InfoInput> createState() => _InfoInputState();
}

class _InfoInputState extends State<InfoInput> {

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
      enabled: widget.enable,
      // obscureText: _isObscured,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.textFormat,
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
        labelText: widget.label,
      ),
    );
  }
}