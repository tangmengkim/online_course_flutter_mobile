import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/customs/custom_snackbar.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../customs/input_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool checkbox = false;
  bool isObscureText = true;

  void _submit() {
    controller.email.value = emailController.text;
    controller.password.value = passwordController.text;

    if (controller.email.value.isNotEmpty &&
        controller.password.value.isNotEmpty &&
        checkbox) {
      controller.signUp();
    } else {
      CustomSnackbar.showError(
          title: "Fail to SignUp",
          description: "Please check you information!");
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
                  "SignUp",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Enter your detail below & free sign up.",
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputText(label: "username", controller: emailController),
                SizedBox(
                  height: 20,
                ),
                InputText(
                    label: "password",
                    controller: passwordController,
                    isPassword: true),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value ? null : _submit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3D5CFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Center(
                          child: controller.isLoading.value
                              ? CircularProgressIndicator()
                              : Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (value) => setState(() {
                        checkbox = value!;
                      }),
                      value: checkbox,
                    ),
                    Expanded(
                      child: Text(
                        "By creating an account you have to agree with our them & condication.",
                        maxLines: 2,
                        style: TextStyle(color: Color(0xFF858597)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Color(0xFF3D5CFF)),
                        ))
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
