import 'package:amir_chikan/helper/util.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/trackorderMap.page/TrackOrderPage.dart';
import 'package:amir_chikan/screens/AuthScreen/custome_Next_button.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Order/orderService/myorderService.dart';
import 'package:amir_chikan/screens/Order/orderrecipt.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<dynamic> orders = [];
  bool isLoading = true;

  Future<void> fetchOrders() async {
    final fetchedOrders = await OrderDetailq.fetchOrders();
    print(fetchedOrders);
    if (fetchedOrders != null) {
      setState(() {
        orders = fetchedOrders;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDate(String rawDate) {
    final date = DateTime.parse(rawDate);
    return DateFormat('dd MMM yyyy').format(date); // e.g., 30 May 2025
  }

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
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primaryRed,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final products = order['order_children'] ?? [];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order ID & Status Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Apptext(
                              text: "Order ${order["order_master_id"]}",
                              fontWeight: FontWeight.bold,
                              size: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order["status"] ?? "")
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Apptext(
                                text: order["status"] ?? "Unknown",
                                fontWeight: FontWeight.w600,
                                size: 10,
                                color: _getStatusColor(order["status"] ?? ""),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Order Code
                        Apptext(
                          text: "Order Code: ${order["tbl_order_code"]}",
                          size: 10,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(height: 4),

                        // Date & Payment Method
                        Apptext(
                          text:
                              "Date: ${formatDate(order["order_delivery_date"])}  •  Payment: ${order["PaymentMethod"]}",
                          size: 10,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),

                        // Buttons
                        Row(
                          children: [
                            CustomButton(
                              height: 35,
                              width: 90,
                              text: "View Receipt",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReceiptPage()),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            //  CustomButton(
                            //   height: 35,
                            //   width: 90,
                            //   text: "Track Order",
                            //   // onPressed: () {
                            //   //   Navigator.push(
                            //   //     context,
                            //   //     MaterialPageRoute(
                            //   //         builder: (context) => TrackOrderPage()),
                            //   //   );
                            //   // },
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Order Details Title
                        Apptext(
                          text: "Order Details",
                          fontWeight: FontWeight.bold,
                          size: 11,
                        ),
                        const SizedBox(height: 6),

                        // Product List
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: List<Widget>.generate(
                              products.length,
                              (i) {
                                final item = products[i];
                                final productName = item['product']
                                        ?['product_name'] ??
                                    'Unknown';
                                final price =
                                    item['child_mrp']?.toString() ?? '0.00';

                                return Column(
                                  children: [
                                    _buildProductRow(productName, price),
                                    if (i != products.length - 1)
                                      const Divider(
                                          height: 16, color: Colors.grey),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProductRow(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Apptext(
          text: name,
          fontWeight: FontWeight.w500,
          size: 10,
        ),
        Apptext(
          text: "₹ $price",
          color: Colors.green,
          fontWeight: FontWeight.bold,
          size: 10,
        ),
      ],
    );
  }
}
