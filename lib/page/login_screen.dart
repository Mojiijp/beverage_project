import 'package:beverage_project/src/model/login.dart';
import 'package:beverage_project/src/services/login_service.dart';
import 'package:beverage_project/src/services/register_services.dart';
import 'package:beverage_project/src/widgets/info_input.dart';
import 'package:beverage_project/src/widgets/password_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';

import '../src/config/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final loginService = Get.put(LoginService());
  // RegisterService registerService = Get.put(RegisterService());

  //LoginService loginService = Get.put(LoginService());

  //var isLogin = false.obs;

  // final LoginServices _login = LoginServices();

  final _formKey = GlobalKey<FormState>();

  /// ตัวแปรรับค่า
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _authenticatingStatus = false;


  @override
  void dispose() {
    _email.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1D6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 350,
                color: const Color(0xffEDF1D6),
                child: Stack(
                  children: [
                    Positioned(
                        child: Image.asset("assets/bg1.png" , fit: BoxFit.cover, width: 300, height: 400,)
                    ),
                    Positioned(
                      left: 180,
                      top: 70,
                      child: Wrap(
                        runSpacing: 30,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        children: "Thang".split("").map(
                                (string) => Text(
                                    string,
                                    style: GoogleFonts.mulish(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff81A422)
                                    ))).toList(),
                      ),
                    ),
                    Positioned(
                      left: 220,
                      top: 150,
                      child: Wrap(
                        runSpacing: 30,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        children: "Cha".split("").map(
                                (string) => Text(
                                    string,
                                    style: GoogleFonts.mulish(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff81A422)
                                    ))).toList(),
                      ),
                    ),
                    Positioned(
                      left: 100,
                        top: 70,
                        child: Image.asset("assets/bg2.png" , fit: BoxFit.cover, width: 300, height: 300,)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 20),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.mulish(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
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
                                label: 'Username or E-mail',
                                enable: true,
                                validator: _validateEmail,
                                keyboardType: TextInputType.text,
                                textFormat: <TextInputFormatter>[
                                  FilteringTextInputFormatter.singleLineFormatter
                                ],
                                controller: _email,
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
                              if (_formKey.currentState!.validate()) {
                                String email = _email.text;
                                String password = _password.text;

                                var result = await LoginService.authen(email, password);

                                if(result['access_token']!=null){ // ล็อกอินผ่าน
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Sign in Successful')),
                                  );

                                  Get.toNamed(Routes.bottomNavBar);

                                }else { // ล็อกอินไม่ผ่าน อื่นๆ
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error')),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff609966),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.mulish(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 320,
                        child: ElevatedButton(
                          onPressed:() {
                            Get.toNamed(Routes.createScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xffa8cea8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xff609966),
                            )
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
                  ],
                ),
              ),
            ],
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
