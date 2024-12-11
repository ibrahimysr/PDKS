import 'package:flutter/material.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/widgets/workers_streambuilder.dart';
import 'package:provider/provider.dart';

class WorkersPage extends StatefulWidget {
  const WorkersPage({super.key});

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser;

    return SafeArea(
      child: currentUser != null
          ? Scaffold(
            appBar: AppBar(
            
          backgroundColor:
appcolor,              title: Text(
                      "Çalışanlar",
                      style: TextStyleClass.mainTitle,
                    ), 
                    centerTitle: true,
            ),
              backgroundColor: appcolor,
              body: const Column(
                children: [
                 
                   Expanded(child: WorkersStreamBuilder()),
                ],
              ),
            )
          : const Text("Giriş Yapmış Kullanıcı Bulunamadı"),
    );
  }
}
