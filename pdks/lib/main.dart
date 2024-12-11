import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdks/service/auth_service.dart';
import 'package:pdks/service/notification_service.dart';
import 'package:pdks/service/permission_service.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/views/manager/manager_home_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [ 
         Provider(create: (_) => PermissionService()),
          Provider<FlutterFireAuthService>(
            create: (_) => FlutterFireAuthService(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) =>
                context.read<FlutterFireAuthService>().authStateChanges,
            initialData: null),
        ChangeNotifierProvider(create: (_) => UserService()), 
      ],

      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const ManagerHomePage()
      ),
    );
  }
}

