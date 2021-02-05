import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_disneyplus/data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets.dart';
import '../colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: false,
                title: SizedBox(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: SvgPicture.asset(Assets.logo),
                  ),
                ),
                backgroundColor: kBackgroundStartColor,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cast),
                  ),
                ],
              )
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kBackgroundStartColor,
                    kBackgroundEndColor,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: [
                      FeaturedItem(imageName: Assets.wandaVisionLarge),
                      FeaturedItem(imageName: Assets.soulLarge),
                      FeaturedItem(imageName: Assets.simpsonsLarge),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 0.87,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BrandButton(imageName: Assets.disney),
                        BrandButton(imageName: Assets.pixar),
                        BrandButton(imageName: Assets.marvel),
                        BrandButton(imageName: Assets.starWars),
                        BrandButton(imageName: Assets.nationalGeographic),
                      ],
                    ),
                  ),
                  TitleSection(title: 'Recomendadas para ti'),
                  PosterList(imageNames: Data.recommendedItems),
                  TitleSection(title: 'Nuevo en Disney+'),
                  PosterList(imageNames: Data.newItems),
                  TitleSection(title: 'Seguir viendo'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return KeepWatchingItem(imageName: Data.keepWatching[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 16);
                        },
                        itemCount: Data.keepWatching.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: kNavigationBarColor,
            border: Border(top: BorderSide(color: Colors.white10, width: 1.0 / devicePixelRatio))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          iconSize: 32,
          elevation: 0,
          selectedItemColor: kNavigationBarSelectedColor,
          unselectedItemColor: kNavigationBarUnselectedColor,
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.download_rounded), label: 'Download'),
            BottomNavigationBarItem(
              icon: Container(
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white60, width: 1.5),
                ),
                child: Image.asset(Assets.avatar),
              ),
              label: 'Avatar',
            ),
          ],
        ),
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

class KeepWatchingItem extends StatelessWidget {
  final String imageName;

  const KeepWatchingItem({
    Key key,
    @required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 350,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imageName,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black87),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Colors.white38,
                          ),
                        ),
                      ),
                      Container(
                        color: kKeepWatchingBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Marvel Studio\' Avengers: Endgame',
                                style: Theme.of(context).primaryTextTheme.subtitle1,
                              ),
                              Text(
                                '2h 32m remaining',
                                style: Theme.of(context).primaryTextTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PosterList extends StatelessWidget {
  final List<String> imageNames;

  const PosterList({
    Key key,
    @required this.imageNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        height: 128,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: AspectRatio(
                aspectRatio: 0.7,
                child: Image.asset(
                  imageNames[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 12);
          },
          itemCount: imageNames.length,
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String title;

  const TitleSection({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

class BrandButton extends StatelessWidget {
  final String imageName;

  const BrandButton({
    Key key,
    @required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: AspectRatio(
          aspectRatio: 1.1,
          child: Material(
            color: Colors.transparent,
            elevation: 0,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kBrandButtonStartColor,
                    kBrandButtonEndColor,
                  ],
                ),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(imageName),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturedItem extends StatelessWidget {
  final String imageName;

  const FeaturedItem({
    Key key,
    this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          imageName,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
