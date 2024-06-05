import 'package:bubbletrouble/button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double playerX = 0;

  void moveLeft() {
    setState(() {
      playerX -= 0.1;
    });
  }

  void moveRight() {
    setState(() {
      playerX += 0.1;
    });
  }

  void fireMissile() {

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          alignment: Alignment(playerX, 1),
                          child: Container(
                            color: Colors.deepPurple,
                            height: 50,
                            width: 50,
                          ),
                        ))
                  ],
                ),
              ),
            )),
        Expanded(
            child: Container(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(Icons.arrow_back, moveLeft),
              MyButton(Icons.arrow_upward, fireMissile),
              MyButton(Icons.arrow_forward, moveRight),
            ],
          ),
        ))
      ],
    );
  }
}
