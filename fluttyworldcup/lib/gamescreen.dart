import 'package:flutter/material.dart';
import 'package:fluttyworldcup/core.dart';
import 'package:fluttyworldcup/gamePageModel.dart';

class GameScreen extends StatefulWidget {
  final Team teamA;
  final Team teamB;
  GameScreen({this.teamA, this.teamB});

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
    return Material(
        child: new Scaffold(body: Column(children: [
      new Container(
          height: 250.0,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage("assets/images/pitch-h.jpg"))),
          child: Stack(
            children: [
              new Center(
                  child: new Container(
                      padding: EdgeInsets.only(bottom: 150.0),
                      child: new Text(GamePageModel.of(context).model.minutes.toString(),
                          style: new TextStyle(
                              color: Colors.white, fontSize: 50.0)))),
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
                      child: new Text("${GamePageModel.of(context).model.teamAScore.toString()} - ${GamePageModel.of(context).model.teamBScore.toString()}",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 50.0))))
            ],
          )),
      new Expanded(
          child: new Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: GamePageModel.of(context).model.events.length,
                  itemBuilder: (BuildContext context, int index) {

                    var update = GamePageModel.of(context).model.events[index];
                    return new Container(
                        child: new Text(update.event.toString(),
                            style: new TextStyle(color: Colors.grey),
                            textAlign: update.target.name == this.teamB.name 
                                ? TextAlign.right
                                : TextAlign.left));
                  })))
    ]), appBar: new AppBar(),));
  }
}
