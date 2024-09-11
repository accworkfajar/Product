import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  SigninView({super.key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SigninView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => TextField(
              autocorrect: false,
              controller: passC,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHidden.toggle();
                  },
                  icon: Icon(controller.isHidden.isFalse
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Text("LOGIN"),
          ),
        ],
      ),
    );
  }
}
