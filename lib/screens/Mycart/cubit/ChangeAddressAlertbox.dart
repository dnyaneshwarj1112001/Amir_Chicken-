import 'package:flutter/material.dart';

class ChangeAddressAlertbox extends StatefulWidget {
  const ChangeAddressAlertbox({super.key});

  @override
  State<ChangeAddressAlertbox> createState() => _ChangeAddressAlertboxState();
}

class _ChangeAddressAlertboxState extends State<ChangeAddressAlertbox> {
  bool isDefault = true; // Track default address

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)), // Rounded corners
      title: Text(
        "Select Address",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 390,
            decoration: BoxDecoration(
              color: isDefault
                  ? Colors.green.withOpacity(0.1)
                  : Colors.white, // Green for default
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isDefault ? Colors.green : Colors.grey.shade300),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "John Doe\n123, Street Name, City, 567890",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (isDefault)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Default",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              isDefault = !isDefault; // Toggle default
                            });
                          },
                          icon: Icon(Icons.check_circle, color: Colors.green),
                          label: Text("Set as Default"),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                      label:
                          Text("Delete", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
