import 'package:first_app/background.dart';
import 'package:first_app/config_screen.dart';
import 'package:first_app/main_screen.dart';
import 'package:first_app/model/category.dart';
import 'package:first_app/tile.dart';
import 'package:first_app/data/categories.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
  
    print(category);
  
  }

  void _handleStartOnPressed(BuildContext context){
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => MainScreen(),
    //   ),
    // );
  }

  void _handleConfigOnPressed(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ConfigScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text("Practice Addition"),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () { 
                _handleConfigOnPressed(context);
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            const Background(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final category in categories)
                      Tile(
                        width: 300.0,
                        height: 100.0,
                        category: category,
                        onPressed: () {
                          _selectCategory(context, category);
                        },
                      )
                ],
              ),
            ),
          ],
        ),

        // body: Stack(
        //   children: [
        //     const Background(),
        //     GridView(
        //       padding: const EdgeInsets.all(50),
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 1,
        //         childAspectRatio: 5 / 2,
        //         crossAxisSpacing: 20,
        //         mainAxisSpacing: 20,
        //       ),
        //       children: [
        //         for (final category in categories)
        //           Tile(
        //             category: category,
        //             onSelect: () {
        //               _selectCategory(context, category);
        //             },
        //           )
        //       ],
        //     ),
        //   ],
        // ),
            // body: Center(
            //   child: SizedBox(
            //     width: 300.0,
            //     height: 100.0,
            //     child: 
            //       ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           // backgroundColor: null,

            //         ),
            //         onPressed: () { 
            //           _handleStartOnPressed(context);
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.all(10.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.play_arrow,
            //               ),
            //               SizedBox(
            //                 width: 5.0,
            //               ),
            //               Text('Start'),
                          
            //             ],
            //           )
            //         ),
            //       ),
            //   )
            // ),
          //body: 
          
          //  Stack(
          // children: [
          //   const Background(),
          // Tile(
          //   category: categories[0],
          //   width: 300.0,
          //   height: 100.0,
          //   onPressed: () { 
          //     _handleStartOnPressed(context);
          //   },
          // ),
          // ]
          //  )
    );
  }
}