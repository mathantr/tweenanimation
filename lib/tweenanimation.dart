import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'widget/widget.dart';

class AnimatedCircularBackgroundScreen extends StatefulWidget {
  const AnimatedCircularBackgroundScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedCircularBackgroundScreen> createState() =>
      _AnimatedCircularBackgroundScreenState();
}

class _AnimatedCircularBackgroundScreenState
    extends State<AnimatedCircularBackgroundScreen> {
  final List<String> images = [
    'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg',
    'https://images.pexels.com/photos/3792581/pexels-photo-3792581.jpeg',
    'https://images.pexels.com/photos/432059/pexels-photo-432059.jpeg',
    'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg',
  ];

  int _currentIndex = 0;
  late List<bool> _completedAnimations;

  @override
  void initState() {
    super.initState();
    _completedAnimations = List<bool>.filled(images.length, false);
    _startAnimationsSequentially();
  }

  Future<void> _startAnimationsSequentially() async {
    for (int i = 0; i < images.length; i++) {
      if (!mounted) return;
      setState(() {
        _currentIndex = i;
      });
      await Future.delayed(
          const Duration(seconds: 3)); // Duration of each animation
      setState(() {
        _completedAnimations[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color.fromRGBO(253, 248, 226, 1),
                    ),
                    child: Column(
                      children: [
                        const Text('New animation'),
                        if (_completedAnimations[index] ||
                            index == _currentIndex)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedCircularImage(
                              imageUrl: images[index],
                              isAnimating: index == _currentIndex,
                            ),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Text(
                'Mathan Thiruvenkadam',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
