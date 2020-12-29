import 'package:flutter/material.dart';

import 'game_widgets/dice.dart';

var gamesMetadataList = <GameMetadata>[
  GameMetadata(
      name: "摇骰子",
      desc: "一次摇两个",
      color: Colors.pink,
      icon: Icons.drag_indicator,
      builder: (_) => DicesGameWidget()),
  GameMetadata(
      name: "B", desc: "fewfe", color: Colors.deepPurple, icon: Icons.face),
  GameMetadata(
      name: "C", desc: "sdccdsc", color: Colors.green, icon: Icons.gamepad),
  GameMetadata(
      name: "D", desc: "fdsaf", color: Colors.orange, icon: Icons.account_box),
  GameMetadata(
      name: "E",
      desc: "cxv",
      color: Colors.lightBlue,
      icon: Icons.cake_outlined),
  GameMetadata(
      name: "F",
      desc: "fewfew",
      color: Colors.yellow,
      icon: Icons.radio_button_checked),
  GameMetadata(
      name: "G",
      desc: "fewfew",
      color: Colors.amber,
      icon: Icons.wallet_giftcard),
  GameMetadata(
      name: "H", desc: "fewfew", color: Colors.purple, icon: Icons.pages)
];

class GameMetadata {
  final String name;
  final String desc;
  final MaterialColor color;
  final IconData icon;

  //final WidgetBuilder image;
  final WidgetBuilder builder;

  GameMetadata(
      {@required this.name,
      @required this.desc,
      @required this.color,
      @required this.icon,
      this.builder});
}
