import 'package:flutter/material.dart';
import 'package:pre_test_hci/blocs/home_bloc.dart';
import 'package:pre_test_hci/models/home_model.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void dispose() {
    super.dispose();
    homeBloc.dispose();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeBloc.loadData();
    return Scaffold(
      appBar: AppBar(title: Text('Home Credit Indonesia', style: TextStyle(color: Colors.white))),
      body: SafeArea(
        child: StreamBuilder(
            stream: homeBloc.dataHome,
            builder: (context, AsyncSnapshot<HomeModel> snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    gridView(snapshot.data),
                    title(snapshot.data),
                    cardList(snapshot.data)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget gridView(HomeModel snapshot) {
    return SliverSafeArea(
      sliver: SliverGrid.count(
          crossAxisCount: 3,
          children: List.generate(snapshot.data[1].items.length, (index) {
            return GestureDetector(
                onTap: () => _launchURL(snapshot.data[1].items[index].link),
                child: Card(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                            snapshot.data[1].items[index].productImage,
                            scale: 6.0),
                        Text(snapshot.data[1].items[index].productName),
                      ]),
                ));
          })),
    );
  }

  Widget title(HomeModel snapshot) {
    return SliverPersistentHeader(
      delegate: _SliverTitleDelegate(
        maxHeight: 16.0,
        minHeight: 16.0,
        child: Center(child: Text(snapshot.data[0].sectionTitle)),
      ),
    );
  }

  Widget cardList(HomeModel snapshot) {
    return SliverSafeArea(
      sliver: SliverGrid.count(
        crossAxisCount: 1,
        children: List.generate(snapshot.data[0].items.length, (index) {
          return GestureDetector(
              onTap: () => _launchURL(snapshot.data[0].items[index].link),
              child: Column(
                children: <Widget>[
                  Image.network(snapshot.data[0].items[index].articleImage),
                  Text(snapshot.data[0].items[index].articleTitle),
                ],
              ));
        }),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _SliverTitleDelegate extends SliverPersistentHeaderDelegate {
  _SliverTitleDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverTitleDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
