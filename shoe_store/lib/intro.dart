import 'package:flutter/material.dart';
import 'package:shoe_store/home.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});

  @override
  Widget build(BuildContext context) {
    strat() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset('image/Front.png', height: 400, width: double.infinity),
          SizedBox(height: 40),
          const Text(
            "Get Real Comfy With Your Leg",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 20),
          // TextButton(

          //   onPressed: strat,
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStateProperty.all<Color>(Colors.green),

          //   ),
          //   child: Text("Star Your Journy"),

          // ),
          GestureDetector(
            onTap: strat,
            child: Container(
              alignment: AlignmentDirectional.center,
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 54, 60, 68),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Start Your Journy",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
