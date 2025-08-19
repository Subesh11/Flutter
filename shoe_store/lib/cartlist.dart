// The corrected code for your Cartlist widget
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cartlist extends StatelessWidget {
  final String imagepath;
  final String name;
  final int price;
  final Function(BuildContext)? deleteList;

  // The constructor is already constant, which is great!
  const Cartlist({
    super.key,
    required this.imagepath,
    required this.name,
    required this.price,
    required this.deleteList,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteList,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
      child: Container(
        // Container itself cannot be const because its children are dynamic.
        width: 300,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Image.asset(
                'image/$imagepath', // 'imagepath' is dynamic, so Image.asset cannot be const.
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 150), // This can be constant.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name, // 'name' is dynamic, so the Text widget cannot be constant.
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4), // This can be constant.
                  Text(
                    '\$$price', // 'price' is dynamic, so the Text widget cannot be constant.
                    style: const TextStyle(fontSize: 16, color: Colors.green),
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
