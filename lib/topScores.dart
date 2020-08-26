import 'package:flutter/material.dart';

import 'app_drawer.dart';

class TopScores extends StatelessWidget{
  static const String routeName = "/topScores";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Highscores")),
      body: Center(
        child: Text("Highscores"),
      ),
    );

    }
  }



