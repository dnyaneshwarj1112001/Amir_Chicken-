// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TrackOrderPage extends StatefulWidget {
//   const TrackOrderPage({super.key});

//   @override
//   State<TrackOrderPage> createState() => _TrackOrderPageState();
// }

// class _TrackOrderPageState extends State<TrackOrderPage> {
//   GoogleMapController? _mapController;

//   final LatLng _deliveryBoyLocation = const LatLng(18.5204, 73.8567);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Track Your Order"),
//         centerTitle: true,
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _deliveryBoyLocation,
//           zoom: 15,
//         ),
//         markers: {
//           Marker(
//             markerId: const MarkerId('delivery_boy'),
//             position: _deliveryBoyLocation,
//             infoWindow: const InfoWindow(title: 'Delivery Boy Location'),
//             icon: BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueAzure),
//           ),
//         },
//         onMapCreated: (controller) {
//           _mapController = controller;
//         },
//       ),
//     );
//   }
// }
