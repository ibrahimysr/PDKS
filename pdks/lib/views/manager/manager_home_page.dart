import 'package:flutter/material.dart';
import 'package:pdks/service/auth_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/manager/public_permissions_request_page.dart';
import 'package:pdks/views/manager/worker_signup.dart';
import 'package:pdks/views/manager/workers_page.dart';
import 'package:pdks/widgets/manager_container.dart';
import 'package:provider/provider.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        
          backgroundColor:
              appcolor,
        leading: IconButton(onPressed: (){
          context.read<FlutterFireAuthService>().signOut(context);
         }, icon: const Icon(Icons.output_rounded,color: Colors.black,)),
      
        title: Text("PDKS",style: TextStyleClass.mainTitle), 
        centerTitle: true,
      ),
        backgroundColor: appcolor,
        body: Column(
         
          
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Text("Yönetici Paneli" , style: TextStyleClass.mainTitle,),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               managerContainer(Icons.supervised_user_circle_sharp, "Çalışanlar",() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkersPage(),));
                 
               }) , 
               managerContainer(Icons.task, "İzin Talepleri", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const  PermissionsListPage(),));
               },)
              ],
            ) , 
            const SizedBox(height: 15),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               managerContainer(Icons.group_add_rounded, "Personel Kayıt",() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const WorkerSignUpPage(),));
                 
               }) , 
               managerContainer(Icons.stacked_bar_chart, "İstatistikler",() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerSignUpPage(),));
        
                 
               },)
              ],
            )
          ],
        ));
  }
}
