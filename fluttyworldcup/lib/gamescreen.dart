import 'package:flutter/material.dart';
import 'package:fluttyworldcup/core.dart';

class GameScreen extends StatefulWidget {
  final Team teamA;
  final Team teamB;
  GameScreen.start({this.teamA, this.teamB});

  @override
  GameScreenState createState() {
    return new GameScreenState(teamA: this.teamA, teamB: this.teamB);
  }
}

class GameScreenState extends State<GameScreen> {
  final Team teamA;
  final Team teamB;
  GameScreenState({this.teamA, this.teamB});

  @override
  Widget build(BuildContext context) {
    return Material(child:new Column(children: [
      new Container(
          height: 250.0,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage("assets/images/pitch-h.jpg"))),
          child: Stack(
            children: [
              Center(
                  child: Row(
                children: [
                  Expanded(
                      child: Container(
                          height: 80.0, child: Image.network(teamA.imageUrl))),
                  Expanded(
                      child: Container(
                          height: 80.0, child: Image.network(teamB.imageUrl)))
                ],
              )),
              new Center(
                  child: new Container(
                      padding: EdgeInsets.only(top: 170.0),
                      child: new Text("1 - 1", style: new TextStyle(color: Colors.white, fontSize: 50.0))))
            ],
          )),
      new Expanded(
          child: new Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                        child: new Text("TEst",
                            style: new TextStyle(color: Colors.grey),
                            textAlign: index % 2 == 0
                                ? TextAlign.right
                                : TextAlign.left));
                  })))
    ]));
  }
}
