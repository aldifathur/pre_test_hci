import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:pre_test_hci/blocs/home_bloc.dart';
import 'package:pre_test_hci/models/home_model.dart';
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
      appBar: AppBar(
          title: Text('Home Credit Indonesia',
              style: TextStyle(color: Colors.white))),
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
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      sliver: SliverGroupBuilder(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Color.fromRGBO(238, 237, 238, 1))),
        child: SliverGrid.count(
            crossAxisCount: 3,
            children: List.generate(snapshot.data[1].items.length, (index) {
              return GestureDetector(
                  onTap: () => _launchURL(snapshot.data[1].items[index].link),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.network(
                            snapshot.data[1].items[index].productImage,
                            scale: 6.0,
                            filterQuality: FilterQuality.high),
                        Flexible(
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0, top: 8.0),
                                child: Text(
                                    snapshot.data[1].items[index].productName,
                                    textAlign: TextAlign.center))),
                      ]));
            })),
      ),
    );
  }

  Widget title(HomeModel snapshot) {
    return SliverPersistentHeader(
      delegate: _SliverTitleDelegate(
          maxHeight: 16.0,
          minHeight: 16.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(snapshot.data[0].sectionTitle,
                style: TextStyle(fontSize: 18.0)),
          )),
    );
  }

  Widget cardList(HomeModel snapshot) {
    var size = MediaQuery.of(context).size;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      sliver: SliverGrid.count(
        childAspectRatio: size.height / 390,
        crossAxisCount: 1,
        children: List.generate(snapshot.data[0].items.length, (index) {
          return GestureDetector(
              onTap: () => _launchURL(snapshot.data[0].items[index].link),
              child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(5.0),
                              topRight: const Radius.circular(5.0)),
                          child: Image.network(
                              snapshot.data[0].items[index].articleImage,
                              fit: BoxFit.cover,
                              height: size.height / 4.5,
                              width: size.width,
                              filterQuality: FilterQuality.high)),
                      Flexible(
                          child: Container(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Text(
                                  snapshot.data[0].items[index].articleTitle,
                                  style: TextStyle(fontSize: 16)))),
                    ]),
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
