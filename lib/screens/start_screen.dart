import 'package:one_tutor_arithmetic/background.dart';
import 'package:one_tutor_arithmetic/config_screen.dart';
// import 'package:one_tutor_arithmetic/intros/start_screen_intro.dart';
import 'package:one_tutor_arithmetic/screens/main_screen.dart';
import 'package:one_tutor_arithmetic/model/category.dart';
import 'package:one_tutor_arithmetic/tile.dart';
import 'package:one_tutor_arithmetic/data/categories.dart';
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
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
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