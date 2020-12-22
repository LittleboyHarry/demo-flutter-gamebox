import 'package:flutter/material.dart';
import 'package:flutter_game_box/games_metadata.dart';

class GameDetailsRoute extends StatelessWidget {
  final GameMetadata gm;

  GameDetailsRoute(this.gm, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(), body: Center(child: Text(gm.name)));
  }
}
