import 'package:first_app/data/categories.dart';
import 'package:first_app/misc/extensions.dart';
import 'package:flutter/material.dart';

class StartScreenIntro extends StatefulWidget {
  const StartScreenIntro({super.key});

  @override
  State<StartScreenIntro> createState() => _StartScreenIntroState();
}

class _StartScreenIntroState extends State<StartScreenIntro> {

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final category in categories)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                    child:
                    Container(
                      width: 300.0,
                      height: 100.0,
                      // decoration: const BoxDecoration(
                      //   color: Colors.white
                      // ),
                      child: Center(
                        child: Text(
                          category.arithmeticOperation.name.capitalize(),
                          style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ),
              ],
            ),
          ),

          // const Expanded(

          // child: Padding(
          //   padding: EdgeInsets.only(bottom: 20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     //crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         "Got it",
          //         style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
          // ),
        ]

      )
      // child: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       for (final category in categories)
      //           const SizedBox(
      //             width: 300.0,
      //             height: 100.0,
      //           )
      //     ],
      //   ),
      // ),
    );
  }

}