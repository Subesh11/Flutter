// home.dart

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoe_store/addlist.dart';
import 'package:shoe_store/database.dart';
import 'package:shoe_store/list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = [
    [
      "Nike",
      20000,
      "Double Sole Comfertable Shoe with water proofing",
      'Nike.png',
    ],
    ["Addidas", 20052, "Balled sole With strong ground grip", "adidas.png"],
    ["Puma", 50000, "Running shoe with strong athletic build", "puma.png"],
    ["Kito", 82252, "Shoe To make your look taller", "kito.png"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        leading: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
          child: Icon(Icons.settings, size: 20),
        ),
        title: Container(
          width: 380,
          height: 35,
          decoration: BoxDecoration(),
          child: SearchBar(
            elevation: WidgetStatePropertyAll(0),
            hintText: "Shoe You Want",
          ),
        ),
      ),
      body: Column(
        // Use Column instead of CustomScrollView
        children: [
          SizedBox(height: 90),
          Container(
            decoration: BoxDecoration(color: Colors.amber),
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.filter_4_outlined),
                SizedBox(width: 20),
                Text("Hot Sales", style: TextStyle(fontSize: 20)),
                SizedBox(width: 140),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [Icon(Icons.filter_alt), Text("view")],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 340,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return
                // Text("data");
                MyWidget(
                  index: index,
                  name: items[index][0],
                  description: items[index][2],
                  imgpth: items[index][3],
                  price: items[index][1],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          GButton(icon: Icons.home, text: "Home", textSize: 15),
          GButton(icon: Icons.shopping_cart_outlined, text: "Cart"),
        ],
      ),
    );
  }
}
