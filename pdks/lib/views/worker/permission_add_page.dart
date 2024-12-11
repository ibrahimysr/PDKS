import 'package:flutter/material.dart';
import 'package:pdks/service/permission_service.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/worker/worker_controller_page.dart';
import 'package:pdks/widgets/add_textfield.dart';
import 'package:provider/provider.dart';

class WorkerPermissionAdd extends StatefulWidget {
  const WorkerPermissionAdd({super.key});

  @override
  State<WorkerPermissionAdd> createState() => _WorkerPermissionAddState();
}

class _WorkerPermissionAddState extends State<WorkerPermissionAdd> {
  TextEditingController type = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController taskDeadline = TextEditingController();
  TextEditingController address = TextEditingController();


  static String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final formattedDate = pickedDate.toLocal().toString().split(' ')[0];
        final formattedTime = _formatTime(pickedTime);
        controller.text = "$formattedDate $formattedTime";
      }
    }
  }
   static void clearControllers(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.clear();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser; 
    final permissionService = Provider.of<PermissionService>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
     
      backgroundColor: appcolor,
      appBar: AppBar(
         flexibleSpace: Container(
            decoration: const BoxDecoration( 
              color: appcolor
            )
          ),
          backgroundColor:
              Colors.transparent, // Arka plan rengini şeffaf yapıyoruz
        elevation: 0,
        title: Text(
          'İzin Talebi Oluştur',
          style: TextStyleClass.mainTitle.copyWith(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child:  ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İzin Tipi',
                  style: TextStyleClass.mainTitle.copyWith(fontSize: 16),
                ),
                addTaskTextfield('Title', type, 'İzin Tipi', 1, context),
               
                
                Text(
                  'Başlangıç Tarihi ve Saati',
                  style: TextStyleClass.mainTitle.copyWith(fontSize: 16),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          onTap: () async {
                            await _selectDateTime(context, startDate);
                          },
                          style: const TextStyle(color: textColor),
                          controller: startDate,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: Color(0xff282C34),
                              hintText: "Başlangıç Tarihi ve Saati",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Bitiş Tarihi ve Saati',
                  style: TextStyleClass.mainTitle.copyWith(fontSize: 15),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          onTap: () async {
                            await _selectDateTime(context, taskDeadline);
                          },
                          style: const TextStyle(color: textColor),
                          controller: taskDeadline,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: Color(0xff282C34),
                              hintText: "Bitiş Tarihi ve Saati",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ),
                      ),
                    ),
                  ),
                ),
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
               
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: enabledColor),
                    onPressed: () async {
                      if (type.text.isEmpty ||
                          startDate.text.isEmpty ||
                          address.text.isEmpty ||
                          taskDeadline.text.isEmpty || 
                          reason.text.isEmpty
                          ) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: appcolor,
                            title: Text(
                              "Eksik Bilgi!",
                              style: TextStyleClass.mainContent,
                            ),
                            content: Text(
                              "Lütfen tüm alanları doldurun.",
                              style: TextStyleClass.mainContent,
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: enabledColor,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Tamam",
                                  style: TextStyleClass.mainContent.copyWith(
                                    color: appcolor2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
          
                        
                        await permissionService.addPermission(
                            context,
                            currentUser!.uid, 
                            type.text, 
                            startDate.text , 
                            taskDeadline.text,
                            reason.text, 
                            address.text
                            );
                             if (context.mounted) {
                               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const WorkerControlPage(),));
                             }
                        clearControllers([
                          type,
                          startDate,
                          taskDeadline,
                          reason, 
                          address
                        ]);
                      }
                    },
                    child: const Text(
                      "Talebi Gönder",
                      style: TextStyle(color: appcolor2),
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
