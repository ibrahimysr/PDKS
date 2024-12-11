import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:latlong2/latlong.dart';
import 'package:pdks/const/location_const.dart';
import 'package:pdks/service/auth_service.dart';
import 'package:pdks/service/shift_service.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/worker/qr_scaner_page.dart';
import 'package:pdks/widgets/my_stack.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  bool _loading = false;
  LatLng points = const LatLng(37.066666, 37.383331);
  String gelenKonum = "";
  bool check = false;

  Future<void> _getAddressFromLatLng() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(points.latitude, points.longitude);
    setState(() {
      gelenKonum = "${placemarks[0].name}";
      check = gelenKonum == location1;
    });
  }

  void bekle() async {
    setState(() {
      _loading = true; // Bekleme başladığında göstergeyi aktifleştir
    });

    PermissionStatus status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    try {
      Position guncelKonum = await enlemBoylam();
      setState(() {
        points = LatLng(guncelKonum.latitude, guncelKonum.longitude);
      });
      await _getAddressFromLatLng();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Hata"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<Position> enlemBoylam() async {
    if (!await GeolocatorAndroid().isLocationServiceEnabled()) {
      return Future.error("Konum Servisi Kapalı Lütfen Açınız");
    }
    if (await GeolocatorAndroid().checkPermission() ==
        LocationPermission.denied) return Future.error("İzin Reddedildi");

    if (await GeolocatorAndroid().requestPermission() ==
        LocationPermission.deniedForever) {
      return Future.error("İzin Temelli olarak reddedildi");
    }

    return await GeolocatorAndroid().getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    bekle();
  }

  ShiftService service = ShiftService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser;
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
     backgroundColor: appcolor,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [
          _loading
              ? const CircularProgressIndicator(
                  color: appcolor2,
                )
              : IconButton(
                  onPressed: () {
                    bekle();
                  },
                  icon: const Icon(
                    Icons.my_location_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
        ],
        title: Text(
          "PDKS",
          style: TextStyleClass.mainTitle.copyWith( fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration:
                BoxDecoration( 
                  color: appcolor2, 
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "İbrahim Yaşar",
                        style: TextStyleClass.mainContent.copyWith(fontSize: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Divider(
                        color: Colors.black,
                        height: 5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Konum",
                              style: TextStyleClass.mainContent.copyWith(fontSize: 20)),
                          check
                              ? const Icon(Icons.location_on_sharp, color: Colors.green)
                              : const Icon(Icons.cancel, color: Colors.red),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Divider(
                        color: Colors.black,
                        height: 5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                Text('Giriş',
                                    style: TextStyleClass.mainContent.copyWith(fontSize: 15)),
                                Text("08:00",
                                    style: TextStyleClass.mainContent.copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('Çıkış',
                                    style: TextStyleClass.mainContent.copyWith(fontSize: 15)),
                                Text("17:00",
                                    style: TextStyleClass.mainContent.copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              myStack(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRViewExample(
                        enabled: true,
                      ),
                    ));
              }, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRViewExample(
                        enabled: false,
                      ),
                    ));
              }, "QR İşlemleri"),
              myStack(() {
                if (check) {
                  ShiftService.addMesai(context, currentUser!);
                  showErrorDialog(context, "Tebrikler", "Giriş Yapıldı");
                } else {
                  showErrorDialog(
                      context, "Hata", "Olmanız Gereken Konumda Değilsiniz");
                }
              }, () {
                if (check) {
                  ShiftService.updateMesaiExitTime(context, currentUser!);
                  showErrorDialog(context, "Tebrikler", "Çıkış Yapıldı");
                } else {
                  showErrorDialog(
                      context, "Hata", "Olmanız Gereken Konumda Değilsiniz");
                }
              }, "Manuel İşlemler")
            ],
          ),
        ),
      ),
    );
  }
}
