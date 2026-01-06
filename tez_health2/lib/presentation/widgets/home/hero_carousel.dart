import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../theme/app_colors.dart';
import '../common/tez_button.dart';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  int _currentIndex = 0;

  final List<SlideData> _slides = const [
    SlideData(
      title: 'tez.health',
      subtitle: 'Skilled nurse. Expert care @Home in minutes.',
      image:
          'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=1920&q=80',
      buttonText: 'Book Your Services',
    ),
    SlideData(
      title: 'Home Care',
      subtitle: 'Lab test @ Home, Fast and Hassle-free.',
      image: 'assets/images/doctor_visit.jpg',
      buttonText: 'Learn More',
    ),
    SlideData(
      title: 'Physiotherapy',
      subtitle: 'Skip the inconvenience, get IV infusion at home.',
      image:
          'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=1920&q=80',
      buttonText: 'Book Now',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: _slides.length,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            height: 350,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return _SlideItem(slide: _slides[index]);
          },
        ),

        // Indicators
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _slides.asMap().entries.map((entry) {
              return Container(
                width: _currentIndex == entry.key ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentIndex == entry.key
                      ? AppColors.tezBlue
                      : Colors.white.withValues(alpha: 0.5),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final String image;
  final String buttonText;

  const SlideData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonText,
  });
}

class _SlideItem extends StatelessWidget {
  final SlideData slide;

  const _SlideItem({required this.slide});

  @override
  Widget build(BuildContext context) {
    final isAssetImage = slide.image.startsWith('assets/');

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        if (isAssetImage)
          Image.asset(
            slide.image,
            fit: BoxFit.cover,
          )
        else
          CachedNetworkImage(
            imageUrl: slide.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.gray100,
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.gray100,
              child: const Icon(Icons.image, size: 50, color: AppColors.gray400),
            ),
          ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.6),
              ],
            ),
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slide.title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                slide.subtitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 32),
              TezButton(
                text: slide.buttonText,
                onPressed: () {
                  // Navigate to booking or details
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
