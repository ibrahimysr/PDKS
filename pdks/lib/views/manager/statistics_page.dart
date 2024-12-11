// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class StatisticsPage extends StatelessWidget {
//   const StatisticsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('İstatistikler'),
//       ),
//       body: FutureBuilder<Map<String, double>>(
//         future: getMonthlyWorkHours(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Hata: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('Bu ay için veri yok'));
//           }
      
//           final workHoursData = snapshot.data!;
//           final barData = workHoursData.entries
//               .map((entry) => BarChartGroupData(
//                     x: workHoursData.keys.toList().indexOf(entry.key),
//                     barRods: [
//                       BarChartRodData(y: entry.value, colors: [Colors.blue])
//                     ],
//                   ))
//               .toList();
      
//           final userNames = workHoursData.keys.toList();
      
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: BarChart(
//               BarChartData(
//                 barGroups: barData,
//                 titlesData: FlTitlesData(
//                   leftTitles: SideTitles(showTitles: true),
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTitles: (double value) {
//                       return userNames[value.toInt()];
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<Map<String, double>> getMonthlyWorkHours() async {
//     final usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();
//     final currentDate = DateTime.now();
//     final startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
//     final endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

//     Map<String, double> workHours = {};

//     for (var doc in usersSnapshot.docs) {
      
//       final userData = doc.data();
//       final mesaiList = userData['Mesai'] as List<dynamic>;

//       double totalHours = 0.0;

//       for (var mesai in mesaiList) {
//         final tarihParts = (mesai['tarih'] as String).split(' - ');
//         final tarih = DateTime(
//           int.parse(tarihParts[2]),
//           int.parse(tarihParts[1]),
//           int.parse(tarihParts[0]),
//         );

//         if (tarih.isAfter(startOfMonth) && tarih.isBefore(endOfMonth)) {
//           final calismaSuresiParts = (mesai['toplam_calisma_suresi'] as String).split(' ');
//           final hours = double.parse(calismaSuresiParts[0]);
//           final minutes = double.parse(calismaSuresiParts[2]);

//           totalHours += hours + (minutes / 60.0);
//         }
//       }

//       final userName = userData['Ad_Soyad'] as String;
//       workHours[userName] = totalHours;
//     }

//     return workHours;
//   }
// }
