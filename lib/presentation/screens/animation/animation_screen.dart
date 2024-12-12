import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  AnimationScreenState createState() => AnimationScreenState();
}

class AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    setState(() {
      if (_isAnimating) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isAnimating = !_isAnimating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.black,
      appBar: AppBar(title: const Text("Fade and Scale on Click")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 400,
                      decoration: BoxDecoration(
                        color: Colours.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Animate",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                      _isAnimating ? "Reverse Animation" : "Start Animation")),
            ),
          ],
        ),
      ),
    );
  }
}
