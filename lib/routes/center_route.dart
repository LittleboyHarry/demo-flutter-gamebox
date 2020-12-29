import 'package:flutter/material.dart';
import 'package:flutter_game_box/routes/game_details_route.dart';
import 'package:flutter_game_box/routes/login_route.dart';
import 'package:flutter_game_box/routes/shopping_route.dart';
import 'package:flutter_game_box/utils.dart';

import '../games_metadata.dart';

class CenterRoute extends StatefulWidget {
  const CenterRoute({
    Key key,
  }) : super(key: key);

  @override
  _CenterRouteState createState() => _CenterRouteState();
}

class _CenterRouteState extends State<CenterRoute> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const gameListGap = 10.0;
    const gameListItemRadius = 20.0;

    final _widgetOptions = <Widget>[
      SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          padding: EdgeInsets.all(gameListGap),
          children: gamesMetadataList.map((gm) {
            return Padding(
              padding: const EdgeInsets.all(gameListGap),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => GameDetailsRoute(gm)));
                },
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        gm.icon,
                        color: Colors.white,
                        size: 64.0,
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        gm.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        )
                      ],
                      color: gm.color,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            lighten(gm.color, 0.15),
                            gm.color,
                            darken(gm.color, 0.05)
                          ]),
                      borderRadius: BorderRadius.circular(gameListItemRadius)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      ExplorerWidget(),
      SocialWidget(),
      SafeArea(
        child: Column(
          children: [
            Center(
              child: TextButton(
                child: Text("登录"),
                onPressed: () => login(context),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ShoppingRoute())),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 96,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.redAccent),
                  child: Center(
                      child: Text('我的商城',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .fontSize,
                              color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset),
                label: '游戏库',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: '探索',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: '社交',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '个性',
              )
            ],
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
                if (index == 3) login(context);
              });
            }));
  }

  void login(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginRoute()));
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.add)),
    );
  }
}

class ExplorerWidget extends StatelessWidget {
  const ExplorerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Index 1: Business');
  }
}
