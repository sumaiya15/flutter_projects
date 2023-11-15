import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swipe_pageview/into_page_1.dart';
import 'package:swipe_pageview/intro_page_2.dart';
import 'package:swipe_pageview/intro_page_3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           PageView(
            controller: _controller,
          children: 
          const [
            IntroPage1(),
           IntroPage2(),
           IntroPage3(),
          ],
        ),
        Container(
          alignment: const Alignment(0,-0.75),
          child: SmoothPageIndicator(controller: _controller, count: 3),
          ),
          Positioned(
            bottom: 30,
            left: 150,
            right: 150,
            child: ElevatedButton(onPressed: () {
              _controller.animateToPage(2, 
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                
              )
            ),
            child: const Text('Skip',style: TextStyle(backgroundColor: Colors.black),
            ),

            
            ),
          )
        ],
        
      ),
    
    );
  }
}