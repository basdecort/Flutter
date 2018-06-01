import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttyworldcup/core.dart';

class GamePageWidget extends StatefulWidget
{
 GamePageWidget({this.child, this.teamA, this.teamB});
 final Widget child;
 final Team teamA;
 final Team teamB;

  @override
  GamePageWidgetState createState() {
    return new GamePageWidgetState();
  }
}

class GamePageWidgetState extends State<GamePageWidget>
{
  Game game;
  StreamSubscription subscription;
  List<GameEventRecord> events;

  @override
  void initState() 
  {
      super.initState();
      events = new List<GameEventRecord>();
      game = Game.start(a: widget.teamA, b: widget.teamB);
      subscription = game.gameEvent.listen((GameEventRecord e)
      {
        print("${e.event}");
        setState(() {
          events.add(e);
       });
      });
  }

  @override
  void dispose() 
  {
      super.dispose();
      subscription.cancel();
  }

  @override
  GamePageModel build(BuildContext context) {
    return new GamePageModel(model: this,child: widget.child);
  }

}

class GamePageModel extends InheritedWidget
{
  GamePageModel({this.model, this.child}) : super(child:child);
  final GamePageWidgetState model;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

   static GamePageModel of(BuildContext context) 
   {
    return context.inheritFromWidgetOfExactType(GamePageModel);
  }
}