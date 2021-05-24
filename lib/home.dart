import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final diceList = <String>[
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png',
  ];

  var index_1 = 0;
  var index_2 = 0;
  var score =0;
  var result = 0;
  var luck = 0;
  final random = Random.secure();
  bool isGameOver = false;
  bool isPlay = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dice Game',),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            if(isGameOver)  Stack(
              children: [
                Container(width: 220,height: 190,
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius:BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.grey,spreadRadius: 2,blurRadius: 10,
                        offset: Offset(0,4,))
                      ]),
                  ),

                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(alignment: Alignment.center,width: 200,height: 80,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius:BorderRadius.circular(8)),
                    child:Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Total Score ',style: TextStyle(fontSize: 16,color: Colors.white),),
                        Text('$score',style: TextStyle(fontSize: 32,color: Colors.white),),
                      ],
                    ),
                  ),
               ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child:Container(alignment: Alignment.center,width: 110,height: 80,
                            decoration: BoxDecoration(color: Colors.red, borderRadius:BorderRadius.circular(8)),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Result',style: TextStyle(fontSize: 14,color: Colors.white),),
                                Text('$result',style: TextStyle(fontSize: 32,color: Colors.white),),
                              ],
                            ),
                        ),
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child:Container(alignment: Alignment.center,width: 80,height: 80,
                            decoration: BoxDecoration(color: Colors.greenAccent, borderRadius:BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Luck',style: TextStyle(fontSize: 14,color: Colors.white),),
                                Text('$luck',style: TextStyle(fontSize: 32,color: Colors.white),),
                              ],
                            ),
                        ),
                ),
              ],
            ),
            if(isGameOver) Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset( diceList[index_1], width: 100, height: 100,),
                SizedBox(width: 20,),
                Image.asset( diceList[index_2], width: 100, height: 100,),
              ],
            ),
            if(isGameOver) ElevatedButton(onPressed: _rollDice, child: Text("Roll The Dice"),),

            Column(
            children: [
                    if(isPlay)Image.asset('images/dice.png',width: 180, height:180),
                    SizedBox(height: 50,),
                    if(isPlay)ElevatedButton(onPressed: playGame,
                      child: Text("Play"),style: ElevatedButton.styleFrom( primary: Colors.greenAccent,),),
                  ],),

            if(!isGameOver && !isPlay)Image.asset('images/game_over.png',width: 250, height:250),

            Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(!isGameOver && !isPlay)ElevatedButton(onPressed: playGame,
                child: Text("Play Again"),style: ElevatedButton.styleFrom( primary: Colors.orange,),),
              SizedBox(width: 20,),
              if(!isGameOver && !isPlay)ElevatedButton(onPressed: stopGame,
                child: Text("Stop"),style: ElevatedButton.styleFrom( primary: Colors.red,),
              )
            ],),
          ],
        ),
      ),
    );
  }

  void _rollDice() {
    setState(() {

      calculation();

      if (result != 7)
        score += index_1 + index_2 + 2;
      else
        reset();

      if(index_1 == index_2)
        luck = luck + 1;

    });
  }

  void calculation(){
    setState(() {
      index_1 = random.nextInt(6);
      index_2 = random.nextInt(6);
      result = index_1 + index_2 + 2;
    });
  }

  void reset(){
    setState(() {
      score = 0;
      luck = 0;
      result = 0;
      isGameOver = false;
    });
  }

  void playGame(){
    setState(() {
      _rollDice();
      isPlay = false;
      isGameOver = true;
    });

  }

  void stopGame() {
    setState(() {
      isPlay = true;
      isGameOver = false;
    });
  }

}
