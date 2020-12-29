import 'package:flutter/material.dart';

import 'center_route.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 2),
                  pageBuilder: (_, __, ___) => CenterRoute())),
          child: Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Column(children: [
                Container(
                  height: 128,
                ),
                Center(
                  child: Text('社交游戏百宝箱',
                      style: TextStyle(color: Colors.white, fontSize: 32)),
                ),
                Container(
                  height: 64,
                ),
                Center(
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(color: Colors.orange),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text('… 点击空白处开始 …',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24))))
              ]))),
    );
  }
}
