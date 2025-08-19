import 'package:flutter/material.dart';
import 'package:shoe_store/cart.dart';

class MyWidget extends StatefulWidget {
  final int index;
  final String name;
  final String description;
  final String imgpth;
  final int price;

  const MyWidget({
    super.key,
    required this.index,
    required this.name,
    required this.description,
    required this.imgpth,
    required this.price,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // A simple press handler
  void press(int index) {
    // Navigate to the Cart widget and pass the required data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cart(
          name: widget.name,
          price: widget.price,
          imgpth:
              widget.imgpth, // It is good practice to pass all relevant data
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 260,
        height: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 116, 106, 106),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "image/${widget.imgpth}",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "\$${widget.price.toString()}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    FloatingActionButton(
                      onPressed: () => press(widget.index),
                      elevation: 0,
                      mini: true,
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
