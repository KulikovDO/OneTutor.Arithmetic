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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MainScreen(),
      ),
    );
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
            GridView(
              padding: const EdgeInsets.all(50),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
                for (final category in categories)
                  Tile(
                    category: category,
                    onSelect: () {
                      _selectCategory(context, category);
                    },
                  )
              ],
            )
            // Center(
            //   child: SizedBox(
            //     width: 200.0,
            //     height: 50.0,
            //     child: 
            //       ElevatedButton(
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
          ],
        ),
          
    );
  }
}