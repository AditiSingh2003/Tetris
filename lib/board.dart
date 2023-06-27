import 'package:flutter/material.dart';
import 'package:tetris/pixel.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  // grid dimension
  int rowLength=10;
  int colLength = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
      itemCount: rowLength * colLength,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
      itemBuilder:(context, index) => 
      Pixel(
        color: Colors.grey[900],
        child: index.toString(),
        ) ),
    );
  } 
}