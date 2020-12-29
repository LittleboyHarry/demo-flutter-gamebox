import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_game_box/routes/game_details_route.dart';
import 'package:flutter_game_box/routes/login_route.dart';
import 'package:flutter_game_box/routes/shopping_route.dart';
import 'package:flutter_game_box/routes/welcome_route.dart';
import 'package:flutter_game_box/utils.dart';

import '../games_metadata.dart';

class CenterRoute extends StatefulWidget {
  const CenterRoute({
    Key key,
  }) : super(key: key);

  @override
  _CenterRouteState createState() => _CenterRouteState();
}

class _CenterRouteState extends State<CenterRoute>
    with SingleTickerProviderStateMixin {
  int _activeIndex = 0;

  //导航栏高度
  double _height = 52.0;

  //悬浮图标半径
  double _floatRadius;

  //移动补间
  double _moveTween = 0.0;

  //浮动图标与圆弧之间的间隙
  double _padding = 10.0;

  //动画控制器
  AnimationController _animationController;

  //移动动画
  Animation<double> _moveAnimation;

  //导航栏使用到的图标
  List _icons = [
    Icons.videogame_asset,
    Icons.explore_outlined,
    Icons.message,
    Icons.person,
  ];

  final _titles = ["游戏库", "探索", "社交", "个性"];

  @override
  void initState() {
    _floatRadius = _height * 2 / 3;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => WelcomeRoute(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                      child) =>
                  SlideTransition(
                    position:
                        Tween(begin: const Offset(0.0, -1.0), end: Offset.zero)
                            .animate(CurvedAnimation(
                                parent: animation, curve: Curves.ease)),
                    child: child,
                  )));
    });
  }

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

    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    double width = MediaQuery.of(context).size.width;
    double singleWidth = width / _icons.length;
    double posTop = _animationController.value <= 0.5
        ? (_animationController.value * _height * _padding / 2) -
            _floatRadius / 3 * 2
        : (1 - _animationController.value) * _height * _padding / 2 -
            _floatRadius / 3 * 2;
    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Stack(children: [
        Scaffold(
          body: _widgetOptions.elementAt(_activeIndex),
          backgroundColor: Color(0xFFEEEEEE),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: width,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                //浮动图标
                Positioned(
                  top: posTop,
                  left: _moveTween * singleWidth +
                      (singleWidth - _floatRadius) / 2 -
                      _padding / 2 -
                      2,
                  child: DecoratedBox(
                    decoration:
                        ShapeDecoration(shape: CircleBorder(), shadows: [
                      BoxShadow(
                          blurRadius: _padding / 2,
                          offset: Offset(0, _padding / 2),
                          spreadRadius: 0,
                          color: Colors.black26),
                    ]),
                    child: CircleAvatar(
                        radius: _floatRadius - _padding,
                        //浮动图标和圆弧之间设置10pixel间隙
                        backgroundColor: Colors.white,
                        child: Icon(_icons[_activeIndex], color: Colors.blue)),
                  ),
                ),
                //所有图标
                CustomPaint(
                  child: SizedBox(
                    height: _height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _icons
                          .asMap()
                          .map((i, v) => MapEntry(
                              i,
                              GestureDetector(
                                child: buildBottomItem(
                                    _activeIndex, i, v, _titles[i]),
                                onTap: () {
                                  _switchNav(i);
                                },
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                  painter: ArcPainter(
                      navCount: _icons.length,
                      moveTween: _moveTween,
                      padding: _padding),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  _switchNav(int newIndex) {
    print("switch " + newIndex.toString());
    double oldPosition = _activeIndex.toDouble();
    double newPosition = newIndex.toDouble();
    if (oldPosition != newPosition &&
        _animationController.status != AnimationStatus.forward) {
      _animationController.reset();
      _moveAnimation = Tween(begin: oldPosition, end: newPosition).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCubic))
        ..addListener(() {
          setState(() {
            _moveTween = _moveAnimation.value;
          });
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _activeIndex = newIndex;
            });
          }
        });
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  buildBottomItem(int selectIndex, int index, IconData iconData, String title) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    Color iconColor = Colors.grey;
    Color bgColor = Colors.white;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);

    if (selectIndex == index) {
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: 0.0, color: Colors.transparent);
      //选中状态的按钮样式
      iconColor = Colors.transparent;
      bgColor = Colors.transparent;
      padding = EdgeInsets.only(top: 0.0);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: bgColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 52,
      child: padItem,
    );
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

//绘制圆弧背景
class ArcPainter extends CustomPainter {
  final int navCount; //导航总数
  final double moveTween; //移动补间
  final double padding; //间隙
  ArcPainter({this.navCount, this.moveTween, this.padding});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = (Colors.white)
      ..style = PaintingStyle.stroke; //画笔
    double width = size.width; //导航栏总宽度，即canvas宽度
    double singleWidth = width / navCount; //单个导航项宽度
    double height = size.height; //导航栏高度，即canvas高度
    double arcRadius = height * 2 / 3; //圆弧半径
    double restSpace = (singleWidth - arcRadius * 2) / 2; //单个导航项减去圆弧直径后单边剩余宽度

    Path path = Path() //路径
      ..relativeLineTo(moveTween * singleWidth, 0)
      ..relativeCubicTo(restSpace + padding, 0, restSpace + padding / 2,
          arcRadius, singleWidth / 2, arcRadius) //圆弧左半边
      ..relativeCubicTo(arcRadius, 0, arcRadius - padding, -arcRadius,
          restSpace + arcRadius, -arcRadius) //圆弧右半边
      ..relativeLineTo(width - (moveTween + 1) * singleWidth, 0)
      ..relativeLineTo(0, height)
      ..relativeLineTo(-width, 0)
      ..relativeLineTo(0, -height)
      ..close();
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
