
import 'package:flutter/material.dart';


import 'package:pdks/service/auth_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/widgets/login_textfield.dart';
import 'package:pdks/widgets/mybutton.dart';
import 'package:provider/provider.dart';

import '../../style/textstyle.dart';

class WorkerSignUpPage extends StatefulWidget {
  const WorkerSignUpPage({super.key});

  @override
  State<WorkerSignUpPage> createState() => _WorkerSignUpPageState();
}

class _WorkerSignUpPageState extends State<WorkerSignUpPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _unit = TextEditingController();
  final _task = TextEditingController();

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox( 
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Scaffold(
            backgroundColor: appcolor,
            body: Column(
              children: [
                const Expanded(
                  flex: 5,
                  child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Icon(
                        Icons.add_location_alt_rounded,
                        color: enabledColor,
                        size: 50,
                      )),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Personel Kayıt Sistemi",
                        style: TextStyleClass.mainContent.copyWith(fontSize: 20)),
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    child: Column(
                      children: [
                        loginTextField(_email, "Email", const Icon(Icons.email),
                            false, "Email"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: loginTextField(_password, "Şifre",
                              const Icon(Icons.lock), true, "Şifre"),
                        ),
                        loginTextField(_username, "Ad Soyad",
                            const Icon(Icons.account_circle), false, "Ad Soyad"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: loginTextField(_phoneNumber, "Telefon Numarası",
                              const Icon(Icons.phone), false, "Telefon Numarası"),
                        ),
                        loginTextField(
                            _unit,
                            "Birim",
                            const Icon(Icons.supervised_user_circle_rounded),
                            false,
                            "Birim"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: loginTextField(_task, "Görev",
                              const Icon(Icons.task), false, "Görev"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: myButton(() {
                            String email = _email.text.trim();
                            String password = _password.text.trim();
                            String username = _username.text.trim();
                            String phoneNumber = _phoneNumber.text.trim();
                            String task = _task.text.trim();
                            String unit = _unit.text.trim();
                                  
                            if (email.isEmpty ||
                                password.isEmpty ||
                                username.isEmpty ||
                                phoneNumber.isEmpty ||
                                task.isEmpty ||
                                unit.isEmpty) {
                              showErrorDialog(
                                  context, "Lütfen tüm alanları doldurun.");
                            } else if (password.length < 6) {
                              showErrorDialog(
                                  context, "Şifre en az 6 karakter olmalıdır.");
                            } else {
                              context.read<FlutterFireAuthService>().signUp(
                                    email,
                                    password,
                                    username,
                                    phoneNumber,
                                    unit,
                                    task,
                                    context,
                                  );
                            }
                          }, "Personel Kayıt Et"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
