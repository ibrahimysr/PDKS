import 'package:flutter/material.dart';
import 'package:pdks/service/auth_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/widgets/login_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appcolor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Icon(Icons.add_location_alt_rounded,color: enabledColor,size: 70,)
                ),
                const SizedBox(height: 25,),
                Expanded(
                  flex: 10,
                  child: Text(
                    "Personel Devam Takip Sistemi",
                    style: TextStyleClass.mainTitle.copyWith(fontSize: 25,color:Colors.black),
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        loginTextField(_email, "Email", const Icon(Icons.email),
                            false, "Email"),
                        const SizedBox(
                          height: 20,
                        ),
                        loginTextField(_password, "Şifre",
                            const Icon(Icons.lock), true, "Şifre"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgatPasswordPage(),));
                                 
                                },
                                child: Text("Şifremi Unuttum",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.blue)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: enabledColor, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                              onPressed: (){
                                 context.read<FlutterFireAuthService>().signIn(
                                _email.text.trim(),
                                _password.text.trim(),
                                context);
                              }, child:  Text("Giriş Yapınız",style: TextStyleClass.mainContent.copyWith(
                                color: appcolor2
                              ),))),
                        ) , 
                       
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
