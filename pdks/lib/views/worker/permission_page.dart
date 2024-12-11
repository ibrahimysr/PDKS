import 'package:flutter/material.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/worker/permission_add_page.dart';
import 'package:pdks/widgets/permission_stream_builder.dart';


import 'package:provider/provider.dart';

class WorkerPermissionPage extends StatefulWidget {
  const WorkerPermissionPage({super.key});

  @override
  State<WorkerPermissionPage> createState() => _WorkerPermissionPageState();
}

class _WorkerPermissionPageState extends State<WorkerPermissionPage> {

    


  @override
  Widget build(BuildContext context) {

         final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser;

    return SafeArea(
      child: 
      currentUser != null ?
       Scaffold(
        
        backgroundColor: appcolor,
        body: Container(
          decoration: BoxDecoration( 
            color: appcolor
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("İzinler",style: TextStyleClass.mainTitle,),
              ),
             const Expanded(child: PermissionStreamBuilder()),
             
            ],
          ),
        ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: enabledColor,
        child:const Icon(Icons.add,color: appcolor2,),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerPermissionAdd(),));
      }),
      ) : const Text("Giriş Yapmış Kullanıcı Bulunamadı") , 
      
    );
  }
}