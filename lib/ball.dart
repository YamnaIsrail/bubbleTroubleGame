import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;

  const MyBall(this.ballX, this.ballY);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      // decoration: BoxDecoration(shape: BoxShape.circle),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(50)
        ),
      ),
      //  color: Colors.pink,
    );
  }
}
