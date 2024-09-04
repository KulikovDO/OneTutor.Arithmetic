import 'dart:async';

import 'package:one_tutor_arithmetic/data/categories.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/model/category.dart';
import 'package:one_tutor_arithmetic/widgets/corner_border_decoration.dart';
import 'package:one_tutor_arithmetic/widgets/intro_button.dart';

class StartScreenIntro extends StatefulWidget {
  const StartScreenIntro({super.key});

  @override
  State<StartScreenIntro> createState() => _StartScreenIntroState();
}

class _StartScreenIntroState extends State<StartScreenIntro> {

  late Timer _timer;
  // Category category = categories[0];
  int categoryIndex = 0;
  
  @override
  void initState() {
    super.initState();

    // var a = categories.indexed;

    

    _timer = Timer.periodic(const Duration(seconds:3), (Timer t) {

      setState(() {

        if(categoryIndex == categories.length - 1){
          categoryIndex = 0;
        } else {
          categoryIndex += 1; 
        }
      });
    
    });
  }

@override
void dispose() {
  _timer.cancel();
  super.dispose();
}

  _handleOnPressedGotIt(){

  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
      ),
      child: Stack(
        children: [

          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Operation",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Center(
                child: GridView.count(
                  childAspectRatio: 3,
                  crossAxisCount: isPortrait ? 1 : 2,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  shrinkWrap: true,
                  children: [
                    for (final category in categories)
                      Container(
                        decoration: category == categories[categoryIndex] 
                          ?
                        const CornerBorderDecoration(
                          frameSFactor: 0.05,
                        gap: 5,
                        )
                          : 
                        null,
                        child: Center(
                          child: Text(
                            category.arithmeticOperation.name.capitalize(),
                            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

          // Expanded(
          //   child: Align(
          //     alignment: FractionalOffset.bottomCenter,
          //     child: Padding(
          //       padding: const EdgeInsets.only(bottom: 20.0),
          //       child: IntroButton(text: "Got it", onPressed: _handleOnPressedGotIt)
          //     ),
          //   ),
          // ),

        ]
      )
    );
  }

}