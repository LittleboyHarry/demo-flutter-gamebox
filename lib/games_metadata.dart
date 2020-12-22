import 'package:flutter/material.dart';

var gamesMetadataList = <GameMetadata>[
  GameMetadata(
      name: "A",
      desc: "dsfjoewjfoewf",
      color: Colors.pinkAccent,
      icon: Icons.add_alarm),
  GameMetadata(name: "B", desc: "fewfe", color: Colors.deepPurple, icon: Icons.face),
  GameMetadata(
      name: "C", desc: "sdccdsc", color: Colors.green, icon: Icons.gamepad),
  GameMetadata(
      name: "D", desc: "fdsaf", color: Colors.orange, icon: Icons.account_box),
  GameMetadata(
      name: "E", desc: "cxv", color: Colors.lightBlueAccent, icon: Icons.cake_outlined),
  GameMetadata(
      name: "F",
      desc: "fewfew",
      color: Colors.yellow,
      icon: Icons.radio_button_checked)
];

class GameMetadata {
  final String name;
  final String desc;
  final Color color;
  final IconData icon;

  GameMetadata({
    @required this.name,
    @required this.desc,
    @required this.color,
    @required this.icon,
  });
}
