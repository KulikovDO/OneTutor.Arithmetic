import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/arrow.dart';
import 'package:one_tutor_arithmetic/widgets/intro_button.dart';


class MainScreenIntro extends StatefulWidget {
  final Function onPressed;
  
  const MainScreenIntro({
    super.key,
    required this.onPressed
  });

  @override
  State<MainScreenIntro> createState() => _MainScreenIntroState();
}

class _MainScreenIntroState extends State<MainScreenIntro> {

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
      ),
      child: 
        Column(
         
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "#2. After an answer was given click the \"Next\" button to go to the next task",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150.0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 100.0,
                                // color: Colors.red,
                                child: const Center(child: Arrow())
                              ),
                            ],
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: isPortrait ? 20.0 : 0),
                        child: IntroButton(
                          text: "Got it", 
                          onPressed: () {
                            widget.onPressed();
                          },
                        ),
                      ),
                    ], 
                  )
              ),
            ]
          

          // children: [
          //   Positioned.fill(
          //     child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Padding(
          //             padding: EdgeInsets.only(bottom: isPortrait ? 20.0 : 0),
          //             child: IntroButton(
          //               text: "Got it", 
          //               onPressed: () {
          //                 widget.onPressed();
          //               },
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          // ],

        )
        // Text(
        //           "#1. Select Operation",
        //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        //         ),
        
        
    );
  }
}