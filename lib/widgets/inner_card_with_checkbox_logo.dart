import 'package:flutter/material.dart';
import 'package:moviereviews/widgets/tap_action.dart';



class CardBoxCheckAndLogo extends StatefulWidget {
  final String img;
  final String title;
  final String heroTag;
  final double innerCardWidth;
  final double innerCardHeight;
  final bool isCompleted;

  const CardBoxCheckAndLogo({Key key, this.img, this.title, this.heroTag, this.innerCardWidth, this.innerCardHeight, this.isCompleted}) : super(key: key);



  @override
  _CardBoxCheckAndLogoState createState() => _CardBoxCheckAndLogoState();
}

class _CardBoxCheckAndLogoState extends State<CardBoxCheckAndLogo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Center(
        child:Container(
            width: widget.innerCardWidth,
            height: widget.innerCardHeight,
            child: Stack(
              children: <Widget>[
                /*Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Image.asset(
                      isCompleted ? asset.checkIcon : asset.crossIcon,
                    ),
                  ),
                ),*/

                Positioned(
//                alignment: Alignment.topRight,
                  top: 4,
                  right: 4,
                  child: TapAction(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Icon(
                            Icons.check_circle,
                            size: 26,
                            color:widget.isCompleted ? Colors.green[400] : Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Hero(
                        tag: widget.heroTag,
                        child: Image.asset(
                          widget.img,
                          width: 68,
                          height: 68,
                        ),
                      ),

                      //inner card text
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(fontSize: 18, color: Color(0xFF787D9E), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8D8CA5).withOpacity(.25),
                    blurRadius: 8,
                  ),
                ],
                border: Border.all(color: Color(0xFF8D8CA5).withOpacity(.34),width: 2),
                color: Colors.white,
                //border: Border.all(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
        ),
    );
  }
}
