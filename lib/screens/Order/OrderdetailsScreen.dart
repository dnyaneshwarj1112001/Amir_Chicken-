import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/custome_Next_button.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Order/orderrecipt.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  // Sample order list
  final List<Map<String, String>> orders = [
    {
      "orderId": "101",
      "product": "Laptop",
      "status": "Delivered",
      "ordercode": "3704",
      "date": "12/1/97",
      "PaymentMethod": "Cash On Delivery",
    },
    {
      "orderId": "102",
      "product": "Smartphone",
      "status": "Shipped",
      "ordercode": "3704",
      "date": "12/1/97",
      "PaymentMethod": "Cash On Delivery",
    },
    {
      "orderId": "103",
      "product": "Headphones",
      "status": "Processing",
      "ordercode": "3704",
      "date": "12/1/97",
      "PaymentMethod": "Cash On Delivery",
    },
    {
      "orderId": "104",
      "product": "Watch",
      "status": "Delivered",
      "ordercode": "3704",
      "date": "12/1/97",
      "PaymentMethod": "Cash On Delivery",
    },
    {
      "orderId": "105",
      "product": "Tablet",
      "status": "Cancelled",
      "ordercode": "3704",
      "date": "12/1/97",
      "PaymentMethod": "Cash On Delivery",
    },
  ];

  // Method to get color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Shipped":
        return Colors.blue;
      case "Processing":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Apptext(
                        text: "Order ID: ${order["orderId"]}",
                        fontWeight: FontWeight.bold,
                      ),
                      // Custom Status Container
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order["status"] ?? "")
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: _getStatusColor(order["status"] ?? ""),
                              width: 1.5),
                        ),
                        child: Apptext(
                          text: order["status"] ?? "Unknown",
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(order["status"] ?? ""),
                        ),
                      ),
                      Row(
                        children: [
                          Apptext(
                            text: "Order Code:  ",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 25,
                            child: Chip(
                              backgroundColor: Colors.grey[200],
                              labelPadding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              label: Text(
                                order["ordercode"] ?? "N/A",
                                style: TextStyle(fontSize: 8),
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gaph(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Apptext(
                        text: "Date: ${order["date"]}",
                        fontWeight: FontWeight.bold,
                      ),
                      Apptext(
                        text: "PaymentMethod: ${order["PaymentMethod"]}",
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  Gaph(height: 10),
                  Row(
                    children: [
                      CustomButton(
                        height: 35,
                        width: 100,
                        text: "View Recipt",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReceiptPage()));
                        },
                      ),
                      Gapw(width: 20),
                      CustomButton(
                        height: 35,
                        width: 115,
                        text: "Track Live Order",
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Gaph(height: 10),
                  Divider(),
                  Apptext(
                    text: "Order Details",
                    fontWeight: FontWeight.bold,
                  ),
                  Gaph(height: 10),
                  Container(
                    height: 100, // Increased height slightly for better spacing
                    width: 450,
                    decoration: BoxDecoration(
                      color:
                          Colors.white, // Changed to white for a cleaner look
                      borderRadius: BorderRadius.circular(
                          12), // Slightly increased for softer edges
                      border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1), // Lighter border color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Subtle shadow
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Apptext(
                                text: "Product: Eggs - 30Nos",
                                fontWeight: FontWeight.bold,
                              ),
                              Apptext(
                                text: "₹ 160.00",
                                fontWeight: FontWeight.w600,

                                color: Colors.green, // Highlight price
                              ),
                            ],
                          ),
                          SizedBox(height: 6), // Added spacing
                          Divider(
                            thickness: 1.2,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 6), // Added spacing
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Apptext(
                                text: "Product: Chicken - 500GM",
                                fontWeight: FontWeight.bold,
                              ),
                              Apptext(
                                text: "₹ 200.00",
                                fontWeight: FontWeight.w600,

                                color: Colors.green, // Highlight price
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
