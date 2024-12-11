import 'package:flutter/material.dart';
import 'package:pdks/service/permission_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/widgets/add_textfield.dart';

// ignore: must_be_immutable
class PublicPermissionDetailPage extends StatefulWidget {
  final String permissionId;
  final String userId;
  Map<String, dynamic> permission;

   PublicPermissionDetailPage({
    super.key,
    required this.permissionId,
    required this.userId,
    required this.permission
  });

  @override
  State<PublicPermissionDetailPage> createState() => _PublicPermissionDetailPageState();
}

class _PublicPermissionDetailPageState extends State<PublicPermissionDetailPage> {
TextEditingController name
 = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController address = TextEditingController();

  void getPermissionsDetails(){ 

    setState(() {
       name.text = widget.permission["Ad_Soyad"];
      type.text = widget.permission["İzin Tipi"]; 
      startDate.text = widget.permission["İzin Başlangıç"];
       reason.text = widget.permission["İzin Sebebi"]; 
      endDate.text = widget.permission["İzin Bitiş"];
      address.text = widget.permission["İzin Adres"];
    });
  }
  @override
  void initState() {
   
    super.initState(); 
    getPermissionsDetails();
  }


  @override
  Widget build(BuildContext context) {
    
final permissionService = PermissionService();
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
        title: Text('İzin Detayı',style: TextStyleClass.mainTitle.copyWith(fontSize: 20),),
        centerTitle: true, 
        
          backgroundColor:
appcolor      ),
      body: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appcolor, 
     
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Ad Soyad',
              style: TextStyleClass.mainTitle.copyWith(fontSize: 16),
            ),
            addTaskTextfield('Title', name, 'Ad Soyad', 1, context),
           
            Text(
              'İzin Tipi',
              style: TextStyleClass.mainTitle.copyWith(fontSize: 16),
            ),
            addTaskTextfield('Title', type, 'İzin Tipi', 1, context),
           
            
            Text(
              'Başlangıç Tarihi ve Saati',
              style: TextStyleClass.mainTitle.copyWith(fontSize: 16),
            ),
             addTaskTextfield('Title', startDate, 'Başlangıç Tarihi ve Saati', 1, context),
           
            Text(
              'Bitiş Tarihi ve Saati',
              style: TextStyleClass.mainTitle.copyWith(fontSize: 15),
            ),
             addTaskTextfield('Title', endDate, 'Bitiş Tarihi Ve Saati', 1, context),
           
            Text(
              'İzin Sebebi',
              style: TextStyleClass.mainTitle.copyWith(fontSize: 15),
            ),
            addTaskTextfield('Title', reason, 'İzin Sebebi', 1, context), 
               Text(
              'İzindeki Adres',
              style: TextStyleClass.mainTitle.copyWith(fontSize: 15),
            ),
            addTaskTextfield('Title', address, 'İzindeki Adres', 1, context),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
      
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: enabledColor),
                    onPressed: () async {
                   permissionService.updatePermissionStatus(context, widget.permissionId, widget.userId, 'Onaylandı');
                    },
                    child: const Text(
                      "İzni Kabul Et",
                      style: TextStyle(color: appcolor2),
                    ),
                  ),
                ),
                SizedBox(
               
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: enabledColor),
                    onPressed: () async {
                   permissionService.updatePermissionStatus(context, widget.permissionId, widget.userId, 'Reddedildi');
                    },
                    child: const Text(
                      "İzni Reddet",
                      style: TextStyle(color: appcolor2),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    )
    );
  }
}

