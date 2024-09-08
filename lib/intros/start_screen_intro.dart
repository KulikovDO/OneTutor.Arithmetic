import 'dart:async';
import 'package:one_tutor_arithmetic/data/categories.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/corner_border_decoration.dart';
import 'package:one_tutor_arithmetic/widgets/intro_button.dart';


class StartScreenIntro extends StatefulWidget {
  final Function onPressed;
  
  const StartScreenIntro({
    super.key,
    required this.onPressed
  });

  @override
  State<StartScreenIntro> createState() => _StartScreenIntroState();
}

class _StartScreenIntroState extends State<StartScreenIntro> {

  late Timer _timer;
  int categoryIndex = 0;
  
  @override
  void initState() {
    super.initState();
 
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

          Padding(
            padding: EdgeInsets.only(top: isPortrait ? 20.0 : 0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "#1. Select Operation",
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
                        style: TextStyle(
                          color: category == categories[categoryIndex] ? Colors.white : Colors.transparent,
                          fontSize: 30, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: isPortrait ? 20.0 : 0),
                  child: IntroButton(
                    text: "Got it", 
                    onPressed: () {
                      widget.onPressed();
                    },
                  ),
                )
              ],
            ),
          ),

        ]
      )
    );
  }

}