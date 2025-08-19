// lib/listadda.dart

import 'package:flutter/material.dart';
import 'package:shoe_store/cart.dart';

class Listadda extends StatefulWidget {
  final int index;
  final String name;
  final String description;
  final String imgpth;
  final int price; // Correct parameter definition
  const Listadda({
    super.key,
    required this.index,
    required this.name,
    required this.description,
    required this.imgpth,
    required this.price, // Correct parameter definition
  });

  @override
  State<Listadda> createState() => _ListaddaState();
}

class _ListaddaState extends State<Listadda> {
  // ToDoDatabase db = ToDoDatabase();
  press(index) {
    // db.tasks.add([
    //   widget.name,
    //   widget.price,
    //   widget.description,
    //   widget.imgpth,
    // ]);
    // db.updateDatabase();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Cart(name: widget.name, price: widget.price, imgpth: widget.imgpth),
      ),
    );
  }

  // `press` is no longer needed here as you are passing it from the parent widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        width: 260,
        height: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 116, 106, 106),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "image/${widget.imgpth}",
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.name),
                        Text(widget.price.toString()),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: FloatingActionButton(
                          onPressed: press(widget.index),
                          elevation: 0,
                          child: const Icon(Icons.shopping_cart),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
