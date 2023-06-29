import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
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
  Piece currentPiece = Piece(type:Tetromino.L);

  // current score
  int currentScore = 0;

  // game over status
  bool gameOver = false;

  // move left
  void moveLeft(){
    if(!checkCollision(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right
  void moveRight(){
    if(!checkCollision(Direction.right)){
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate
  void moveRotate(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLine() {
    // step 1: Loop Through each row of the game board from bottom to top
    for(int row = colLength -1; row >= 0; row--)
    {
      // step 2: Initialize a avariable to track if the row is full
      bool isRowFull = true;

      // step 3: Check if the row is full (all column in the row are not null)
      for(int col = 0; col < rowLength; col++)
      {
        // if there's an empty column, set rowISfull to false and break out of the loop
        if(gameBoard[row][col] == null)
        {
          isRowFull = false;
          break;
        }
      }

      // Step 4: if the row is full, clear the row and shift row down
      if(isRowFull) {
        // step 5: move all rows above the current row down by 1
        for(int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r-1]);
        }

        // step 6: clear the top row
        gameBoard[0] = List.generate(rowLength, (index) => null);

        // step 7: increment the score
        currentScore +=10;
        
      }
    }
  }

  @override

  void initState(){
    super.initState();

    // start game when app starts
    startGame();
  }

  void startGame(){
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 700);
    gameLoop(frameRate);
  }

  // gameLoop

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer){
        setState(() {

          // clear lines
          clearLine();

          // check now for landing
          checkLandig();

          // check if the game is over or not?
          if(gameOver){
            timer.cancel();
            showAlert();
          }
          
          // move current piece down
          currentPiece.movePiece(Direction.down);
        });
      }
    );
  }

  // 
  void showAlert(){
    QuickAlert.show(
      context: context,
      title: 'Game Over',
      text:'Your Score: $currentScore',
      type: QuickAlertType.warning,
      confirmBtnColor: Color(0xFF008181),
      confirmBtnText: 'Play Again',
      onConfirmBtnTap: (){
        // reset the game
              resetGame();
              // close the dialog
              Navigator.of(context).pop();
      }
    );
  }

  // reset game
  void resetGame(){
    // reset the game board
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    // reset the score
    currentScore = 0;

    // reset the game over status
    gameOver = false;

    // create a new piece
    createNewPiece();

    // start the game
    startGame();
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

    // check if the game is over
    if(isGameOver()){
      // stop the game loop
      gameOver = true;
    }

  }

  // GAME OVER MESSAGE
  bool isGameOver(){
    // loop through the top row of the game board
    for(int col = 0; col < rowLength; col++){
      // if the top row is occupied, return true
      if(gameBoard[0][col] != null){
        return true;
      }
    }
    // if the top row is not occupied, return false
    return false;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          //GAME GRID
          Expanded(
            child: GridView.builder(
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
                color: currentPiece.color,
                );
            }
            // landed pieces
            else if(gameBoard[row][col] != null) {
              final Tetromino? tetrominoType = gameBoard[row][col];
              return Pixel(
                color: tetrominoColors[tetrominoType]!,
                );
            }
            // blank pixel
            else{
              return Pixel(
                color: Colors.grey[900],
              );
            }
            }
            ),
          ),
          
          // Score

          // GAME CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  resetGame();
                },
                 child:Text('PLAY',
                  style: TextStyle(fontSize: 30)
                  ,),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(8.0), // Adjust the padding as needed
                    backgroundColor: Color(0xFF008181)
                  ),
                  ),

                // left button
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  iconSize: 40, 
                  icon: Icon(Icons.arrow_back_ios),
                  ),
          
                  // rotate button
                IconButton(
                  onPressed: moveRotate,
                  color: Colors.white,
                  iconSize: 40,   
                  icon: Icon(Icons.rotate_right),
                  ),
          
                // right button
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  iconSize: 40,  
                  icon: Icon(Icons.arrow_forward_ios),
                  ),
          
              ],
            ),
          ),
        ],
      ),
    );
  }
}