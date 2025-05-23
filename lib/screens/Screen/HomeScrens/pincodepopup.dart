import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:flutter/material.dart';

class PincodeBottomSheet extends StatefulWidget {
  final Function(String)? onLocationSelected;

  const PincodeBottomSheet(BuildContext context, {super.key, this.onLocationSelected});

  @override
  State<PincodeBottomSheet> createState() => _PincodeBottomSheetState();
}

class _PincodeBottomSheetState extends State<PincodeBottomSheet> {
  final TextEditingController _pincodeController = TextEditingController();
  String? selectedAddress;

  final List<String> fakeAddresses = [
    "411001 - Shivajinagar, Pune",
    "411002 - Camp, Pune",
    "411003 - Deccan, Pune",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Colors.red, size: 40),
          const SizedBox(height: 10),
          const Text(
            "Enter Delivery Location",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "We need your location to show nearby shops.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Google location button
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                // Handle Google location logic
              },
              icon: const Icon(Icons.my_location, color: Colors.red),
              label: const Text("Use current location"),
            ),
          ),

          // Address radio list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fakeAddresses.length,
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                value: fakeAddresses[index],
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value;
                    _pincodeController.text = value!.split(" - ")[0];
                  });
                },
                title: Text(
                  fakeAddresses[index],
                  style: const TextStyle(fontSize: 14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                dense: true,
                activeColor: Colors.red,
              );
            },
          ),

          const SizedBox(height: 10),

          // Pincode TextField
          TextField(
            controller: _pincodeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              labelText: "Enter 6-digit Pincode",
              prefixIcon: const Icon(Icons.pin_drop, color: Colors.red),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            label: const Apptext(
              text: "Confirm Location",
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              String pin = _pincodeController.text.trim();
              if (pin.length == 6) {
                Navigator.pop(context);
                widget.onLocationSelected?.call(pin);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter a valid 6-digit pincode."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
