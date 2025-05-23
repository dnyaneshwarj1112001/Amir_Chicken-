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

class _ProductDetailListState extends State<ProductDetailList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        padding: const EdgeInsets.all(8.0),
        child: FadeTransition(
          opacity: _animation,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: child,
                  );
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: widget.onPressed,
                    splashColor: Appcolor.primaryRed.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Image.asset(
                            widget.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.text[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: const Text("View More"),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
