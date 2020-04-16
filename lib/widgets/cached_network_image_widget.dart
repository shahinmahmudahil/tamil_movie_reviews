import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImgWithError extends StatefulWidget {

  final String imgUrl;
//  final double radius;
  final double width;
  final double height;

  const CachedImgWithError({Key key, @required this.imgUrl, this.width=double.infinity, this.height=200}) : super(key: key);

  @override
  _CachedImgWithErrorState createState() => _CachedImgWithErrorState();
}

class _CachedImgWithErrorState extends State<CachedImgWithError> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        width: widget.width ,
        height: widget.height ,
        decoration: BoxDecoration(
          shape: widget.width!=null ? BoxShape.rectangle :BoxShape.circle,
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      imageUrl:
      widget.imgUrl,
      placeholder: (context, url) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(shape: widget.width!=null ? BoxShape.rectangle :BoxShape.circle,
          color: Colors.grey
        ),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: widget.width,
        height:widget.height,
        decoration: BoxDecoration(shape: widget.width!=null ? BoxShape.rectangle :BoxShape.circle,
            color: Colors.grey
        ),
        child: Icon(
          Icons.error,
          color: Colors.orangeAccent,

        ),
      ),
    );
  }
}
