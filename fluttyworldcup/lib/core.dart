import 'dart:async';
import 'dart:math';

class Team
{
  Team({this.name, this.strength, this.imageUrl});

  final String name;
  final int strength;
  final String imageUrl;
}

class GameEventRecord
{
  GameEventRecord({this.event, this.state, this.minute, this.target});

  final GameState state;
  final GameEvent event;
  final int minute;
  final Team target;
}

enum GameEvent
{
  GoalScored,
  NearMiss,
  Tackle,
  Penalty,
  RedCard,
  YellowCard,
  Corner,
  FreeKick,
  Substitute,
  TimerTick
}

enum GameState
{
  Starting,
  Started,
  Paused,
  Ended
}

class Game
{
  Stream<GameEventRecord> get gameEvent { return gameEventController.stream; }

  int minute = 0;
  StreamController<GameEventRecord> gameEventController = new StreamController.broadcast();

  Team a;
  Team b;

  Game.start({this.a, this.b})
  {
    minute = 0;

    new Timer.periodic(new Duration(milliseconds: 200), (Timer t){

        if (minute == 106)
        {
          t.cancel();
           gameEventController.close();
        }else{
          calcEvent(minute++);
        }

    });
  }

  calcEvent(int minute)
  {
     var gameState =  minute == 0 ? GameState.Starting : minute == 105 ? GameState.Ended : (minute > 45 && minute < 60) ? GameState.Paused : GameState.Started;

     //gameEventController.add(new GameEventRecord(event: GameEvent.TimerTick, state: gameState,minute: minute, target: null));
     var chance = new Random().nextInt(100) % (minute < 15 || minute > 75 ? 5 : 10) == 0;

     if (chance && gameState == GameState.Started)
     {
       int rnd = new Random().nextInt(GameEvent.values.length-1);
       var team = new Random().nextInt(2) == 0 ? a : b;
       var event = GameEvent.values[rnd];

       if (event == GameEvent.GoalScored)
       {
          int diff = (a.strength - b.strength).abs();

          bool goal = diff > 10 ?  new Random().nextInt(5) == 0 : diff > 5 ? new Random().nextInt(3) == 0 : new Random().nextInt(2) == 0;
          if (goal)
          {
            gameEventController.add(new GameEventRecord(event: event, state: gameState, minute: minute, target: team));
          }else
          {
            gameEventController.add(new GameEventRecord(event: GameEvent.NearMiss, state: gameState, minute: minute, target: team));
          }
       }
       else
       {
         gameEventController.add(new GameEventRecord(event: event, state: gameState, minute: minute, target: team));
       }
     }
  }

}

main()
{
  var teamA = new Team(name: "Nederland", strength: 100);
  var teamB = new Team(name: "Duitsland", strength: 10);
  var game = new Game.start(a:teamA, b:teamB);
  game.gameEvent.listen((GameEventRecord e)
  {
    print("${e.minute}: ${e.state}  ${e.event} ${e.target?.name}");
  });
}

