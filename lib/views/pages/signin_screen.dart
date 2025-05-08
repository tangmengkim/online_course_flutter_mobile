import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/customs/custom_snackbar.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../customs/input_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final bool checkbox = false;
  bool isObscureText = true;
  void _submit() {
    // print(emailController.text);
    controller.email.value = emailController.text;
    controller.password.value = passwordController.text;
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      controller.signIn();
    } else {
      CustomSnackbar.showError(
          title: "Incorrect Email or Password",
          description: "Please check your email or password. and try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SignIn",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                InputText(label: "Email", controller: emailController),
                SizedBox(
                  height: 20,
                ),
                InputText(
                    label: "Password",
                    controller: passwordController,
                    isPassword: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forget password?"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3D5CFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Center(
                          child: controller.isLoading.value
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Color(0xFF3D5CFF)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
