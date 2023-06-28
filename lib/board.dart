import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

/*

Game Board

this is a 2x2 grid null representing an empty space.
A non empty space will have the color to represent the landed pieces

 */

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);


class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {


  // current Tetrus piece
  Piece currentPiece = Piece(type:Tetromino.T);

  @override

  void initState(){
    super.initState();

    // start game when app starts
    startGame();
  }

  void startGame(){
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  // gameLoop

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer){
        setState(() {

          // check now for landing
          checkLandig();
          
          // move current piece down
          currentPiece.movePiece(Direction.down);
        });
      }
    );
  }

  // check for collision in a future position
  // return true if collision and return false if not collision
  bool checkCollision(Direction direction){
    // loop through  each postiton of the current position
    for( int i=0;i<currentPiece.position.length;i++)
    {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // adjust the row and col based on the direction
      if(direction == Direction.left){
        col -= 1;
      }
      else if(direction == Direction.right)
      {
        col += 1;
      }
      else if(direction == Direction.down){
        row += 1;
      }

      // check if the piece is out of bounds(either too low or to far to the left or right)
      if(row >= colLength || col <0 || col >= rowLength){
        return true;
      }
      if (row >= 0 && col >= 0 && gameBoard[row][col] != null &&
          !currentPiece.position.contains(row * rowLength + col)) {
        return true;
      }
    }

    

      // if no collison are detected, return false
      return false;
  }

  void checkLandig(){
    // if going down is occupied
    if(checkCollision(Direction.down)){
      // mark position as occupied on the game
      for( int i=0; i < currentPiece.position.length; i++){
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);
        if (row >= 0 && col >= 0){
          gameBoard[row][col] = currentPiece.type;
        }
      }
    // once landed, create the next piece
    createNewPiece();
    }
  }

  void createNewPiece(){
    // create a randpm object to generate random tetromino types
    Random rand = Random();

    // create a new piece with random type
    Tetromino randomType =
      Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
      itemCount: rowLength * colLength,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
      itemBuilder:(context, index) {
        // get row and col of each index
        int row = (index / rowLength).floor();
        int col = (index % rowLength);
      if(currentPiece.position.contains(index))
      {
        // current Piece
        return Pixel(
          color: Colors.cyanAccent,
          child: index.toString(),
          );
      }
      // landed pieces
      else if(gameBoard[row][col] != null) {
        return Pixel(
          color: Colors.pinkAccent,
          child: '',
          );
      }
      // blank pixel
      else{
        return Pixel(
          color: Colors.grey[900],
          child: index.toString(),
        );
      }
      }
      ),
    );
  }
}