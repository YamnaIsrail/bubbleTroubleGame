import 'package:bubbletrouble/button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
            )),
        Expanded(
            child: Container(
          color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    Icons.arrow_back
                  ),
                  MyButton(
                      Icons.arrow_upward
                  ),
                  MyButton( Icons.arrow_forward),

                ],
              ),
        ))
      ],
    );
  }
}
