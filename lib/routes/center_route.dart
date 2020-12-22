import 'package:flutter/material.dart';
import 'package:flutter_game_box/routes/game_details_route.dart';
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

  static const optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = <Widget>[
      SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          padding: EdgeInsets.all(8.0),
          children: gamesMetadataList
              .map((gm) =>
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GameDetailsRoute(gm)));
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
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
                            colors: [lighten(gm.color, 0.15), gm.color, darken(
                                gm.color, 0.05)
                            ]),
                        borderRadius: BorderRadius.circular(26.0)),
                  ),
                ),
              ))
              .toList(),
        ),
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Scaffold(
        body: Center(child: const Text('Press the button below!')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(Icons.add)
        ),
      ),
      SafeArea(
        child: Text(
          'Index 3: fff',
          style: optionStyle,
        ),
      ),
    ];
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset),
                label: '游戏大全',
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
            selectedItemColor: Theme
                .of(context)
                .primaryColor,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            }));
  }
}
