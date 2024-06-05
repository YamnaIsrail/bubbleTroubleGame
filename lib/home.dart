import 'dart:async';

import 'package:bubbletrouble/ball.dart';
import 'package:bubbletrouble/button.dart';
import 'package:bubbletrouble/missile.dart';
import 'package:bubbletrouble/player.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
enum direction {LEFT, RIGHT}

class _HomeState extends State<Home> {
  static double playerX = 0;

  //missile variables
  double missileX= playerX;
  double missileY= 1;
  double missileHeight = 10;
  bool midshot= false;

  //ball variables
  double ballX= 0.5;
  double ballY= 1;
  var ballDirection = direction.LEFT;



  void startGame(){

    double time= 0;
    double height= 0;
    double velocity = 60; //how strong jump is

    Timer.periodic(Duration(milliseconds: 10), (timer) {

      //quadratic eq that models a bounce (upside down parabola)
      height = -5 * time * time + velocity * time;

      //if the ball reaches the ground, reset the jump
      if(height < 0){
        time= 0;
      }

      //update the new ball position
      setState(() {
      ballY = heightToCoordinate(height);
      });

//if ball hits left wall then change the direction to right
      if( ballX - 0.005 < -1){
        ballDirection = direction.RIGHT;
      }
      //if ball hits right wall then change the direction to left

      else if(ballX + 0.005 > 1){
        ballDirection = direction.LEFT;
      }

//move the ball in correct direction
    if(ballDirection ==  direction.LEFT){
        setState(() {
          ballX -= 0.005;
        });
      }
      else if( ballDirection == direction.RIGHT){
        setState(() {
          ballX += 0.005;
        });
      }

      //check if ball hits the player

      if(playerDies()){
        timer.cancel();
        _showDialog();
      }

      time+=0.1;



    });
  }
void _showDialog(){
    showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.grey[700],
        title: Text("You Dead Bro!", style: TextStyle(color: Colors.white),),
      );
        });
}
  void moveLeft() {

    setState(() {

      missileX= playerX;

      if (playerX - 0.1 < -1) {
        //Do nothing
      } else {
        playerX -= 0.1;
      }


      if(!midshot){
        missileX= playerX;
      }
    });
  }

  void moveRight() {
    setState(() {

      if (playerX + 0.1 > 1) {
        //Do nothing
      } else {
        playerX += 0.1;
      }
      missileX= playerX;
    });
  }

  void fireMissile() {
    if(midshot == false){
      Timer.periodic(Duration(milliseconds: 20), (timer){

        // shot fired
        midshot= true;

        //midshot grows it reaches till the top of screen
        setState(() {
          missileHeight += 10;
        });

        //stop missile when it reached top of screen
        if(missileHeight> MediaQuery.of(context).size.height * 3/ 4){
          resetMissile();

          timer.cancel();
        }

        //check if missile has hit the ball
        if(ballY > heightToCoordinate(missileHeight) && ballX == missileX.abs() < 0.03)
        {
          resetMissile();
          ballX = 5;
          timer.cancel();
        }

      });

    }
  }

  double heightToCoordinate(double height){
    double totalHeight = MediaQuery.of(context).size.height * 3 /4;
    double position = 1-2 * height / totalHeight;
    return position;
  }

  void resetMissile(){
    missileX= playerX;
    missileHeight= 10;
    midshot= false;
  }

  bool playerDies(){
    // if the ball touches the player
// ball and player positions are same

  if((ballX - playerX).abs() < 0.05 && ballY > 0.95){
    return true;
  }
  else{
    return false;
  }

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
                    MyBall(ballX, ballY),
                    MyMissile(missileX, missileHeight),
                    Player(playerX),

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
              MyButton(Icons.play_arrow, startGame),
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
