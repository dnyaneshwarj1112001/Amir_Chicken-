// import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
// import 'package:amir_chikan/screens/Screen/HomeScrens/nearshops.dart';
// import 'package:flutter/material.dart';
// import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
// import 'package:amir_chikan/presentation/Global_widget/CustomiseDrawerandchip.dart';
// import 'package:amir_chikan/presentation/Global_widget/dummyimages.dart';
// import 'package:amir_chikan/presentation/Global_widget/gap.dart';
// import 'package:amir_chikan/screens/Screen/HomeScrens/shopsListHorizontal.dart';
// import 'package:amir_chikan/screens/shop/productdetailstpage.dart';
// import 'package:amir_chikan/presentation/Drawer/drawer.dart';

// class HomePageScreen extends StatefulWidget {
//   const HomePageScreen({super.key});

//   @override
//   State<HomePageScreen> createState() => _HomePageScreenState();
// }

// class _HomePageScreenState extends State<HomePageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const DrawerExample(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Fixed Change Location Widget
//           const Padding(
//             padding: EdgeInsets.only(top: 30, left: 8, right: 8),
//             child: CustomiseDrawerandchip(
//               text: "Change location",
//             ),
//           ),
//           Gaph(height: 10),

//           // Fixed Search Bar

//           const SizedBox(height: 10),

//           // Make the content scrollable while keeping header fixed
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Apptext(
//                       text: "ABHISHEK, WHAT’S ON YOUR MIND?",
//                     ),
//                     const SizedBox(height: 10),

//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Apptext(text: "SHOPS NEAR YOU"),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailList(
//                                   text: DummyData.shopNames,
//                                   images: DummyData.images,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             "See all",
//                             style: TextStyle(color: Appcolor.primaryRed),
//                           ),
//                         ),
//                       ],
//                     ),

//                     ShopListGrid(
//                       text: "Balaji Chicken",
//                       images: DummyData.images,
//                     ),
//                     Container(
//                       height: 230,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(color: Colors.amber),
//                     ),

//                     const Gaph(height: 10),

//                     const Padding(
//                       padding: EdgeInsets.all(0.0),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: Image(
//                               image: AssetImage(
//                                   "lib/innitiel_screens/images/Murga.png"),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               "WE DELIVER FRESH AND HYGENIC MEAT FROM YOUR FAVOURITE SHOPS",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Shop list horizontal
//                     ShopsNearyou(
//                       text: DummyData.shopNames,
//                       Subtitle: DummyData.shopNames,
//                       images: DummyData.images,
//                       time: "30-40 Mins ",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
