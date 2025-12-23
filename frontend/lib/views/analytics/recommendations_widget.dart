import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class RecommendationsWidget extends StatelessWidget {
  const RecommendationsWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              CarouselSlider(
                items: [
                  Column(
                    children: [
                      Container(
                        // TODO: Make book cover bigger, with managing overflow
                        height: 200,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        onPressed: () {},
                        child: Text(
                          "See details",
                          style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ],
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2 / 3,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
