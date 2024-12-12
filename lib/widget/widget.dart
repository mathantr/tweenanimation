import 'package:flutter/material.dart';

class AnimatedCircularImage extends StatefulWidget {
  final String imageUrl;
  final bool isAnimating;

  const AnimatedCircularImage({
    Key? key,
    required this.imageUrl,
    required this.isAnimating,
  }) : super(key: key);

  @override
  State<AnimatedCircularImage> createState() => _AnimatedCircularImageState();
}

class _AnimatedCircularImageState extends State<AnimatedCircularImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: -100, end: 70).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    if (widget.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
