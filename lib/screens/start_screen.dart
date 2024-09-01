import 'package:first_app/background.dart';
import 'package:first_app/config_screen.dart';
// import 'package:first_app/intros/start_screen_intro.dart';
import 'package:first_app/screens/main_screen.dart';
import 'package:first_app/model/category.dart';
import 'package:first_app/tile.dart';
import 'package:first_app/data/categories.dart';
import 'package:flutter/material.dart';



class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MainScreen(arithmeticOperation: category.arithmeticOperation),
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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text("OneTutor: Arithmetic"),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () { 
                _handleConfigOnPressed(context);
              },
            ),
          ],
        ),
        body: 
          Stack(
            children: [
              const Background(),
              Center(
                child: GridView.count(
                  childAspectRatio: 3,
                  crossAxisCount: isPortrait ? 1 : 2,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  shrinkWrap: true,
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
              // const StartScreenIntro(),
            ],
          )

        
        
        
        
    );
  }
}