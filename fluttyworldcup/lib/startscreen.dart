import 'package:flutter/material.dart';
import 'package:fluttyworldcup/core.dart';
import 'package:fluttyworldcup/gamePageModel.dart';
import 'package:fluttyworldcup/gamescreen.dart';

class StartScreen extends StatefulWidget {
  @override
  StartScreenState createState() {
    return new StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  Team teamA;
  Team teamB;

  List<Team> teams = [
    new Team(
        name: "Nederland",
        strength: 100,
        imageUrl: "http://flags.fmcdn.net/data/flags/w1160/nl.png"),
    new Team(
        name: "United States",
        strength: 100,
        imageUrl: "http://flags.fmcdn.net/data/flags/w1160/us.png"),
    new Team(
        name: "Duitsland",
        strength: 100,
        imageUrl: "http://flags.fmcdn.net/data/flags/w1160/de.png")
  ];

  _teamUpdated(Team team, int selectorIndex) {
    if (selectorIndex == 0) {
      this.teamA = team;
    } else {
      this.teamB = team;
    }
  }

  _pushGameScreen() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new GamePageWidget(
            child: new GameScreen(teamA: teamA, teamB: teamB),
            teamA: teamA,
            teamB: teamB)));
  }

  @override
  Widget build(BuildContext context) {
    teamA = teams.elementAt(0);
    teamB = teams.reversed.toList().elementAt(0);

    return Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new AssetImage("assets/images/pitch.jpg"))),
        child: new Stack(
          children: [
            new Column(children: [
              new CountrySelector(
                  selectorIndex: 0, teams: teams, teamUpdated: _teamUpdated),
              new CountrySelector(
                  selectorIndex: 1,
                  teams: teams.reversed.toList(),
                  teamUpdated: _teamUpdated),
              new Container(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: new RaisedButton(
                      onPressed: () {
                        _pushGameScreen();
                      },
                      child: new Text("Start game")))
            ]),
            new Container(
                padding: EdgeInsets.only(bottom: 80.0),
                child: new Center(
                    child: new Image.asset("assets/images/vs.png",
                        height: 150.0))),
          ],
        ));
  }
}

class CountrySelector extends StatelessWidget {
  CountrySelector({this.selectorIndex, this.teams, this.teamUpdated});
  final int selectorIndex;
  final Function(Team team, int selectorIndex) teamUpdated;
  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: Center(
            child: Container(
                child: PageView.builder(
                    itemCount: teams.length,
                    onPageChanged: (i) {
                      teamUpdated(teams[i], selectorIndex);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                          child: new Image.network(teams[index].imageUrl));
                    }),
                height: 100.0)));
  }
}
