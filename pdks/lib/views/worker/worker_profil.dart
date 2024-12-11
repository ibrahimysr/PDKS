import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/views/worker/profil_image_picker.dart';
import 'package:pdks/widgets/login_textfield.dart';

class WorkerProfil extends StatefulWidget {
  const WorkerProfil({super.key});

  @override
  State<WorkerProfil> createState() => _WorkerProfilState();
}

class _WorkerProfilState extends State<WorkerProfil> {
  final _email = TextEditingController();
  
  final _username = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _unit = TextEditingController();
  final _task = TextEditingController();
  String? _profileImageUrl;
  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          _username.text = snapshot.data()?['Ad_Soyad'] ?? '';
          _email.text = snapshot.data()?['Email'] ?? '';
          _phoneNumber.text = snapshot.data()?['Telefon Numarası'] ?? '';
          _unit.text = snapshot.data()?['Birim'] ?? '';
          _task.text = snapshot.data()?['Görev'] ?? '';

          _profileImageUrl = snapshot.data()?['profileImageUrl'] ?? '';
        });
      }
    }
  }

  Future<void> _selectProfileImage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileImagePickerPage()),
    );

    if (result != null && result is String) {
      setState(() {
        _profileImageUrl = result;
      });

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'profileImageUrl': result,
        });
      }
    }
  }
  @override
  void initState() {
    super.initState(); 
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Scaffold(
            backgroundColor: appcolor,
            body: Column(
              children: [
                GestureDetector(
                  onTap: _selectProfileImage,
                  child: Container(
                    height: 110,
                    width: 110,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: enabledColor,
                      image: _profileImageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(_profileImageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImageUrl == null
                        ? const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 35,
                            ),
                          )
                        : null,
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    child: Column(
                      children: [
                        loginTextField(_email, "Email", const Icon(Icons.email),
                            false, "Email"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: loginTextField(
                            _username,
                            "Ad Soyad",
                            const Icon(Icons.account_circle),
                            false,
                            "Ad Soyad"),
                        ),
                        loginTextField(
                            _username,
                            "Ad Soyad",
                            const Icon(Icons.account_circle),
                            false,
                            "Ad Soyad"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: loginTextField(
                              _phoneNumber,
                              "Telefon Numarası",
                              const Icon(Icons.phone),
                              false,
                              "Telefon Numarası"),
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
