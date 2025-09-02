import 'package:flutter/material.dart';
import 'package:note_adv/home.dart';

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({super.key});

  @override
  FadeInDemoState createState() => FadeInDemoState();
}

class FadeInDemoState extends State<FadeInDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward(); // Start the animation
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Home()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FadeTransition(
              opacity: _animation,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/emoji.png",
                              height: 200,
                              width: 150,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset("assets/2049.gif", width: 50),
                            SizedBox(height: 100),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Never Forget Any Thing With Us",
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(height: 50),
            Text(
              "The Only Reminder/\nAssistance You Need",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 80),
            // GestureDetector(
            //   onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => Home()),
            //   ),
            //   child: Text("Get Started"),
            // ),
          ],
        ),
      ),
    );
  }
}
