import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/piece.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5B3A3A),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 300)),
              Image.asset('assets/block.png'),
              Padding(padding: EdgeInsets.only(bottom: 50)),


              Text(
                'BLOCKOUT',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Padding(padding: EdgeInsets.only(bottom: 50)),

              ElevatedButton(onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameBoard()),
              );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0), // Adjust the padding as needed
                backgroundColor:Color(0xFFA89A91),
              ),
              child: Text('Start Game', style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}