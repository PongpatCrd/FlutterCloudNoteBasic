import 'package:flutter/material.dart';

class AlertBar extends StatelessWidget {

  final String errorMsg;
  final Function alertSetStateFunction;

  AlertBar({this.errorMsg, this.alertSetStateFunction});

  @override
  Widget build(BuildContext context) {
    if (errorMsg != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                errorMsg,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close,) ,
                onPressed: () {
                  alertSetStateFunction();
                }),
            ),
          ],
        ),
      );
    }
    else{
      return SizedBox(height: 0,);
    }
  }
}

class LoadingWraper extends StatelessWidget {

  final Widget child;

  LoadingWraper({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Opacity(
          opacity: 0.5,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        Center(
          child: Image.asset('assets/images/base_logo.gif'),
        )
      ],
    );
  }
}
