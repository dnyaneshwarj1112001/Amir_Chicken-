import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:flutter/material.dart';

class ProductDetailList extends StatefulWidget {
  const ProductDetailList({
    super.key,
    required this.text,
    required this.images,
    this.onPressed,
  });

  final List<String> text;
  final List<String> images;
  final VoidCallback? onPressed;

  @override
  State<ProductDetailList> createState() => _ProductDetailListState();
}

class _ProductDetailListState extends State<ProductDetailList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Our Products",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primaryRed,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8, // Compact & aligned layout
          ),
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        widget.images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Text(
                      widget.text[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.onPressed != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: ElevatedButton(
                        onPressed: widget.onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text("View More"),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
