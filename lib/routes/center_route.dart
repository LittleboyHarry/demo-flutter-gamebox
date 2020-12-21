import 'package:flutter/material.dart';

class CenterRoute extends StatelessWidget {
  const CenterRoute({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('center')));
  }
}
