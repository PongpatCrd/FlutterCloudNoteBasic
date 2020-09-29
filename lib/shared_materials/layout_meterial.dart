import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  
  final Widget title;
  final bool innerBoxIsScrolled;

  BaseAppBar({this.title, this.innerBoxIsScrolled=false});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.amber,
      pinned: true,
      floating: false,
      forceElevated: innerBoxIsScrolled,
      title: title,
      
      leading: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }, 
      )
    );
  }
}

// class PersistentHeader extends SliverPersistentHeaderDelegate {

//   final PreferredSize child;

//   PersistentHeader({this.child});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     // TODO: implement build
//     return child;
//   }

//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => child.preferredSize.height;

//   @override
//   // TODO: implement minExtent
//   double get minExtent => child.preferredSize.height;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     // TODO: implement shouldRebuild
//     return false;
//   }
// }

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;

  PersistentHeader({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: child,
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class BaseLayout extends StatelessWidget {

  final Widget appBar;
  final Widget alertBar;
  final Widget child;

  BaseLayout({this.appBar, this.alertBar, this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        appBar,
        SliverPersistentHeader(
          pinned: true,
          delegate: PersistentHeader(
            child: PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: alertBar, 
            )
          ),
        ),
        SliverToBoxAdapter(
          child: child,
        ),
      ],
    );
  }
}

class BaseEmptyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}