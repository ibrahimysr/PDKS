import 'package:flutter/material.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/widgets/shift_stream_builder.dart';

import 'package:provider/provider.dart';

class WorkerShiftPage extends StatefulWidget {
  const WorkerShiftPage({super.key});

  @override
  State<WorkerShiftPage> createState() => _WorkerShiftPageState();
}

class _WorkerShiftPageState extends State<WorkerShiftPage> {

    


  @override
  Widget build(BuildContext context) {

         final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser;

    return SafeArea(
      child: 
      currentUser != null ?
       Scaffold(
        appBar: AppBar( 
          
          backgroundColor:
appcolor,          title: Text("Mesailer",style: TextStyleClass.mainTitle,),
          centerTitle: true,
        ),
        
        body: const Column(
          children: [
        
            Expanded(child: ShiftStreamBuilder()),
           
          ],
        ),
      ) : const Text("Veril Bulunamadı")
    );
  }
}