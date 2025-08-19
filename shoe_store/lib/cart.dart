import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoe_store/cartlist.dart';

class Cart extends StatefulWidget {
  final String name;
  final int price;
  final String imgpth;

  const Cart({
    super.key,
    required this.name,
    required this.price,
    required this.imgpth,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late final Box _myBox;
  List cart = [];

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box("My_box");
    // Load existing items from the database
    cart = _myBox.get("Items", defaultValue: []);
    // Add the new item to the list and database
    addItemToCart();
  }

  void addItemToCart() {
    // This check prevents adding the same item every time the screen is opened
    if (!cart.any((item) => item['name'] == widget.name)) {
      setState(() {
        cart.add({
          "name": widget.name,
          "price": widget.price,
          "imgpth": widget.imgpth,
        });
        _myBox.put("Items", cart);
      });
    }
  }

  void removeItemFromCart(int index) {
    setState(() {
      cart.removeAt(index);
      _myBox.put("Items", cart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.shopping_cart_checkout),
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (BuildContext context, int index) {
          final item = cart[index]; // Get the current item from the list
          return Cartlist(
            imagepath: item['imgpth'],
            name: item['name'],
            price: item['price'],
            deleteList: (context) => removeItemFromCart(index),
          );
        },
      ),
    );
  }
}
