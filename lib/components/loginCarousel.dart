import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderP extends StatefulWidget {
  const SliderP({super.key});

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  final gifs = [
    'assets/gif/try.gif',
    'assets/gif/try1.gif',
    'assets/gif/try2.gif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: gifs.length,
              itemBuilder: (context, index, realIndex) {
                final gif = gifs[index];
                return buildImage(gif, index);
              },
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                autoPlayInterval:
                    const Duration(milliseconds: 3000), // Set to 0.5 seconds
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
            ),
            const SizedBox(height: 12),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
          dotWidth: 15,
          activeDotColor: Colors.blue,
        ),
        activeIndex: activeIndex,
        count: gifs.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String gif, int index) =>
      Image.asset(gif, fit: BoxFit.cover);
}
