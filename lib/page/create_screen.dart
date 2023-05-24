import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/login.dart';
import 'package:beverage_project/src/services/register_services.dart';
import 'package:beverage_project/src/widgets/already_have_an_account_check.dart';
import 'package:beverage_project/src/widgets/info_input.dart';
import 'package:beverage_project/src/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  //RegisterService registerService = Get.put(RegisterService());

  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();

  // กำหนดตัวแปรรับค่า
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();

  Login? register;

  bool _registeringStatus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    _password.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1D6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20, bottom: 10),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.mulish(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, bottom: 50),
                  child: Text(
                    "Create a new account",
                    style: GoogleFonts.mulish(
                      fontSize: 18,
                    ),
                  ),
                ),
                //Info
                Center(
                  child: SizedBox(
                    width: 320,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InfoInput(
                            label: 'E-mail',
                            enable: true,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            textFormat: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            controller: _email,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InfoInput(
                            label: 'Phone number',
                            enable: true,
                            validator: _validateMobile,
                            keyboardType: TextInputType.number,
                            textFormat: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _phone,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InfoInput(
                            label: 'Username',
                            enable: true,
                            validator: _validateUsername,
                            keyboardType: TextInputType.name,
                            textFormat: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            controller: _name,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: PasswordInput(
                              label: "Password",
                              enable: true,
                              validator: _validatePassword,
                              controller: _password,
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                //Button
                Center(
                  child: SizedBox(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) { //หากผ่าน
                            FocusScope.of(context).unfocus(); // ยกเลิดโฟกัส ให้แป้นพิมพ์ซ่อนไป

                            String email = _email.text;
                            String password = _password.text;
                            String name = _name.text;
                            String phone = _phone.text;

                            var result = await RegisterService.register(email, password, name, phone);

                            if(result['access_token']!=null) {// สร้างบัญชีสำเร็จ
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                      'Create new user Successful'
                                    )
                                ),
                              );

                              Get.toNamed(Routes.loginScreen);

                            } else { // สร้างบัญชีไม่ผ่าน อื่นๆ
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error..  try agin!')),
                                );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff609966),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.mulish(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Already ave ana account check
                AlreadyHaveAnAccountCheck(
                    press: () {
                      Get.toNamed(Routes.loginScreen);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    RegExp regex =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(value!.isEmpty) {
      return 'Please enter email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid email';
      } else {
        return null;
      }
    }
  }

  String? _validateMobile(String? value) {
    if(value!.isEmpty) {
      return 'Please enter phone number';
    } else if (value.length != 10){
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  String? _validateUsername(String? value) {
    if(value!.isEmpty) {
      return 'Please enter username';
    } else if(value.length < 3){
      return 'Username is too short';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
}
