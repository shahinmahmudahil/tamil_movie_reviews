import 'package:flutter/material.dart';

class BgScaffold extends StatefulWidget {
  final Widget child;

  const BgScaffold({Key key, this.child}) : super(key: key);

  @override
  _BgScaffoldState createState() => _BgScaffoldState();
}


class _BgScaffoldState extends State<BgScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
