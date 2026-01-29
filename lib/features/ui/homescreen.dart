// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'login_page.dart';

// class Homescreen extends StatelessWidget {
//   final String userName;
//   const Homescreen({super.key, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box('logindata');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               box.delete('currentUser');

//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const LoginPage(),
//                 ),
//                 (route) => false,
//               );
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: Text(
//           "Welcome $userName ",
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
