
import 'package:flutter/material.dart';


class TapAction extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  double scaleFactor;

  TapAction({
    Key key,
    @required this.child,
    this.onTap,
    this.scaleFactor ,
  }) : super(key: key);


  @override
  _TapActionState createState() => _TapActionState();
}

class _TapActionState extends State<TapAction>with  SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleFactor;


  @override
  void initState() {
    super.initState();
    if(widget.scaleFactor==null)
      widget.scaleFactor= 0.90;

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _scaleFactor = Tween(begin: 1.0, end: widget.scaleFactor).animate(_animationController);
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  void _onTap() {
    if(mounted && !_animationController.isAnimating)
    {
      _animationController.forward().then((x){
        return _animationController.reverse();
      }).then((_){
        if(widget.onTap != null)
        {
          widget.onTap();
        }
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _scaleFactor,
        child: widget.child,
      ),
    );
  }
}
