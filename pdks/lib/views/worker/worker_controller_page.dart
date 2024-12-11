import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pdks/service/auth_service.dart';
import 'package:pdks/service/error_message_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/worker/permission_page.dart';
import 'package:pdks/views/worker/worker_home_page.dart';
import 'package:pdks/views/worker/worker_profil.dart';
import 'package:pdks/views/worker/worker_shift_page.dart';
import 'package:pdks/widgets/bottom_navigator_button.dart';
import 'package:provider/provider.dart';

class WorkerControlPage extends StatefulWidget {
  const WorkerControlPage({super.key});

  @override
  State<WorkerControlPage> createState() => _WorkerControlPageState();
}

class _WorkerControlPageState extends State<WorkerControlPage> {
  final PageController _pageController = PageController();
  int index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.transparent, // Arka plan rengini şeffaf yapıyoruz
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [MenuHeader(), MenuItems()],
          ),
        ),
      ),
      backgroundColor: appcolor,
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        onPageChanged: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        children: const [WorkerHomePage(), WorkerPermissionPage(), WorkerProfil()],
      ),
      bottomNavigationBar: Container(
        decoration:BoxDecoration( 
          color: Colors.white
        ),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent, // Arka plan rengini şeffaf yapıyoruz
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  bottomNavigatorButton(() {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }, index, 0, "Ana Sayfa", Icons.home),

                  bottomNavigatorButton(() {
                    _pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }, index, 1, "İzinler", Icons.task),

                  bottomNavigatorButton(() {
                    _pageController.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }, index, 2, "Profil", Icons.account_circle_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Menü başlığı widget'ı
class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  Future<Map<String, dynamic>?> _getProfileImageAndUsername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        String? profileImageUrl = userDoc.get('profileImageUrl') as String?;
        String? username = userDoc.get('Ad_Soyad') as String?;

        if (profileImageUrl != null && username != null) {
          return {
            'profileImageUrl': profileImageUrl,
            'Ad_Soyad': username,
          };
        } else {
          debugPrint('Profile image URL or username is null');
          return null;
        }
      } else {
        debugPrint('User document does not exist');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching profile image URL and username: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appcolor
      ),

      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _getProfileImageAndUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const CircleAvatar(
              backgroundImage: AssetImage("assets/icon.png"),
              radius: 40,
            );
          } else if (!snapshot.hasData) {
            return const CircleAvatar(
              backgroundImage: AssetImage("assets/icon.png"),
              radius: 40,
            );
          } else {
            String profileImageUrl = snapshot.data!["profileImageUrl"]!;
            String username = snapshot.data!["Ad_Soyad"]!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileImageUrl),
                    radius: 40,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      username,
                      style: const TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Menü öğeleri widget'ı
class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(
            Icons.home,
            color: textColor,
          ),
          title: Text("Home", style: TextStyleClass.mainContent),
          onTap: () {
            Scaffold.of(context).closeDrawer();
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.access_time_filled_outlined,
            color: textColor,
          ),
          title: Text("Mesai", style: TextStyleClass.mainContent),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerShiftPage(),));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.notifications,
            color: textColor,
          ),
          title: Text(
            "Hata Bildirimi",
            style: TextStyleClass.mainContent,
          ),
          onTap: () {
            showReportDialog(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.exit_to_app,
            color: textColor,
          ),
          title: Text("Çıkış Yap", style: TextStyleClass.mainContent),
          onTap: () {
            context.read<FlutterFireAuthService>().signOut(context);
          },
        ),
      ],
    );
  }
}
