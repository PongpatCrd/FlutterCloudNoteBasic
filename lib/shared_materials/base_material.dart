import 'package:flutter/material.dart';

class AlertBar extends StatelessWidget {
  final String errorMsg;
  final Function alertBarStateFunction;

  AlertBar({this.errorMsg, this.alertBarStateFunction});

  @override
  Widget build(BuildContext context) {
    if (errorMsg != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 9,
            ),
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
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  alertBarStateFunction();
                }),
            ),
          ],
        ),
      );
    }
    else {
      return SizedBox();
    }
  }
}

class AlertPopUp extends StatelessWidget {
  final String subjectLabel;
  final String descLabel;

  final Function positiveAction;

  AlertPopUp({
    this.subjectLabel = 'Confirm Action',
    this.descLabel = 'Are you sure?',
    this.positiveAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(subjectLabel),
      content: Text(descLabel),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        SizedBox(
          width: 5,
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.pop(context, false);
            positiveAction();
          }
        )
      ],
      elevation: 9.0,
    );
  }
}

class LoadingWrapper extends StatelessWidget {

  final child;
  final bool loadingActive;

  LoadingWrapper({this.child, this.loadingActive});

  @override
  Widget build(BuildContext context) {
    if (loadingActive) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
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
            ),
          ],
        ),
      );
   }
    else {
      return child;
    }
  }
}
