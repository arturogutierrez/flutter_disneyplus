import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_disneyplus/data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets.dart';
import '../colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kNavigationBarColor,
          border: Border(
            top: BorderSide(
              color: Colors.white10,
              width: 1.0 / devicePixelRatio,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: kNavigationBarSelectedColor,
          unselectedItemColor: kNavigationBarUnselectedColor,
          iconSize: 32,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.download_rounded), label: 'Download'),
            BottomNavigationBarItem(
              // icon: Icon(Icons.person_rounded),
              icon: Container(
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white70, width: 1.5),
                ),
                child: Image.asset(Assets.avatar),
              ),
              label: 'Avatar',
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: false,
              title: SizedBox(
                height: 46,
                child: SvgPicture.asset(Assets.logo),
              ),
              backgroundColor: kBackgroundStartColor,
            ),
          ];
        },
        body: Container(
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
          child: SingleChildScrollView(
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
                // Orden:
                //  1. Add Image
                //  2. Add All 5 Images
                //  3. Extract to widget BrandButton
                //  4. Aspect Ratio
                //  5. Border, style, etc...
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 12, top: 16, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BrandButton(image: Assets.disney),
                      BrandButton(image: Assets.pixar),
                      BrandButton(image: Assets.marvel),
                      BrandButton(image: Assets.starWars),
                      BrandButton(image: Assets.nationalGeographic),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Recomendadas para ti',
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: SizedBox(
                    height: 128,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: Data.recommendedItems.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AspectRatio(
                            aspectRatio: 0.7,
                            child: Image.asset(
                              Data.recommendedItems[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 12);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Nuevo en Disney+',
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: SizedBox(
                    height: 128,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: Data.newItems.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AspectRatio(
                            aspectRatio: 0.7,
                            child: Image.asset(
                              Data.newItems[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 12);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Seguir viendo',
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: SizedBox(
                    height: 260,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: Data.keepWatching.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 350,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  Data.keepWatching[index],
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fitWidth,
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black87,
                                        ),
                                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: LinearProgressIndicator(
                                            value: 0.3,
                                            backgroundColor: Colors.white38,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            color: kKeepWatchingBackgroundColor,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Marvel Studios\' Avengers: Endgame',
                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8),
                                                    child: Text(
                                                      '2h 32m remaining',
                                                      style: Theme.of(context).primaryTextTheme.caption,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 12);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BrandButton extends StatelessWidget {
  final String image;

  const BrandButton({
    Key key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: AspectRatio(
          aspectRatio: 1.1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  kBrandButtonStartColor,
                  kBrandButtonEndColor,
                ])),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BrandButtonWithRipple extends StatelessWidget {
  final String image;

  const BrandButtonWithRipple({
    Key key,
    this.image,
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
              // First as Container, Later add Material, Ink and InkWell
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    kBrandButtonStartColor,
                    kBrandButtonEndColor,
                  ])),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(image),
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
    @required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
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
