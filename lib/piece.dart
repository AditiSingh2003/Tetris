import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece{

  // type of tetris piece
  Tetromino type;

  Piece({required this.type});

  //the piece is just a list of integers
  List<int> position = [];

  // color of tetris piece
  Color get color {
    return tetrominoColors[type]! ?? Colors.white;
  }


  // generate the integers
  void initializePiece() {
    switch(type) {
      case Tetromino.L:
      position =[
        -26,
        -16,
        -6,
        -5,
      ];
      break;

      case Tetromino.J:
      position =[
        -25,
        -15,
        -6,
        -5,
      ];
      break;

      case Tetromino.I:
      position =[
        -4,-5,-6,-7,
      ];
      break;

      case Tetromino.O:
      position =[
        -15,-16,-5,-6,
      ];
      break;

      case Tetromino.S:
      position =[
        -5,-6,-15,-14,
      ];
      break;

      case Tetromino.Z:
      position =[
        -17,-16,-6,-5,
      ];
      break;

      case Tetromino.T:
      position =[
        -26,-16,-6,-15,
      ];
      break;

    default:
    }
  }

  void movePiece(Direction direction){
    switch(direction){
      case Direction.down:
      for (int i = 0; i<position.length; i++)
      {
        position[i] += rowLength;
      }
      break;

      case Direction.left:
      for (int i = 0; i<position.length; i++)
      {
        position[i] -= 1;
      }
      break;

      case Direction.right:
      for (int i = 0; i<position.length; i++)
      {
        position[i] += 1;
      }
      break;

      default:
    }
  }

  // rotate the piece
  int rotationState = 1;
  void rotatePiece(){
    // new position 
    List<int> newPosition = [];

    // rotate the piece
    switch (type) {
      case Tetromino.L:
          switch(rotationState){
              case 0:
            newPosition =[
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength +1,
              ];

              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              // case 1
              case 1:
            newPosition =[
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              ];

             if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              case 2:
            newPosition =[
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength -1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
              
              // case 3:
              case 3:
            newPosition =[
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        break;

          // J block

          case Tetromino.J:
          switch(rotationState){
              case 0:
            newPosition =[
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
              ];

              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              // case 1
              case 1:
            newPosition =[
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
              ];

             if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              case 2:
            newPosition =[
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
              
              // case 3:
              case 3:
            newPosition =[
              position[1] + 1,
              position[1],
              position[1] -1,
              position[1] + rowLength + 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
          }
          break;

          // I block

          case Tetromino.I:
          switch(rotationState){
              case 0:
            newPosition =[
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] +2,
              ];

              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              // case 1
              case 1:
            newPosition =[
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength ,
              ];

             if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              case 2:
            newPosition =[
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
              
              // case 3:
              case 3:
            newPosition =[
              position[1] + rowLength ,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        break;


          // S block

          case Tetromino.S:
          switch(rotationState){
              case 0:
            newPosition =[
              position[1] ,
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
              ];

              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              // case 1
              case 1:
            newPosition =[
              position[1] - rowLength,
              position[1],
              position[1] + 1,
              position[1] + rowLength + 1,
              ];

             if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              case 2:
            newPosition =[
              position[1] ,
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength ,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
              
              // case 3:
              case 3:
            newPosition =[
              position[1] - rowLength ,
              position[1],
              position[1] + 1,
              position[1] + rowLength + 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        break;

        // Z case
        case Tetromino.Z:
          switch(rotationState){
              case 0:
            newPosition =[
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength -1,
              position[3] +1,
              ];

              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              // case 1
              case 1:
            newPosition =[
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
              ];

             if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              case 2:
            newPosition =[
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
              
              // case 3:
              case 3:
            newPosition =[
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
          }
          break;

          // T case
          case Tetromino.T:
          switch(rotationState){
              case 0:
            newPosition =[
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength ,
              ];

              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              // case 1
              case 1:
            newPosition =[
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength ,
              ];

             if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;

              case 2:
            newPosition =[
              position[1] - rowLength,
              position[1] - 1,
              position[1] ,
              position[1] + rowLength ,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
              
              // case 3:
              case 3:
            newPosition =[
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
              ];

              // update position
              if(piecePositonIsValid(newPosition)){
                // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
              }
              break;
          }
          break;
      default:
    }
  }

  // check if valid position
  bool positionIsValid( int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // if the position is taken, return false
    if(row < 0 || col <0 || gameBoard[row][col] != null) {
      return false;
    }

    // postiton is valid so return true
    else{
      return true;
    }

  }

  bool piecePositonIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for(int pos in piecePosition) {
      if(!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLength;

      if(col ==0) {
        firstColOccupied = true;
      }

      if( col == rowLength -1) {
        lastColOccupied = true;
      }

    }

    return !(firstColOccupied && lastColOccupied);
  }
}