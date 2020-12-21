import 'package:flutter/material.dart';
import 'center_route.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(color: Colors.redAccent),
                  child: Column(
                    children: [
                      Container(
                        height: 128,
                      ),
                      Center(
                        child: Text('社交游戏百宝箱',
                            style: TextStyle(
                                color: Colors.white, fontSize: 32)),
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
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Center(
                    child: OutlineButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("开始", style: TextStyle(fontSize: 28)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) => CenterRoute()
                        ));
                      },
                    )))
          ],
        ));
  }
}
