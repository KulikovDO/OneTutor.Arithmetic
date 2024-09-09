import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/screens/config_screen.dart';
import 'package:one_tutor_arithmetic/intros/start_screen_intro.dart';
import 'package:one_tutor_arithmetic/screens/main_screen.dart';
import 'package:one_tutor_arithmetic/model/category.dart';
import 'package:one_tutor_arithmetic/widgets/tile.dart';
import 'package:one_tutor_arithmetic/data/categories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  bool displayStartScreenIntro = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      displayStartScreenIntro = prefs.getBool('display_start_screen_intro') ?? true;
    });
  }

  void _selectCategory(BuildContext context, Category category) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MainScreen(arithmeticOperation: category.arithmeticOperation),
      ),
    );
  
  }

  _handleConfigOnPressed(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ConfigScreen(),
      ),
    );
  }

  _handleOnPressedGotIt() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('display_start_screen_intro', false);

    setState(() {
      displayStartScreenIntro = false;
    });
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
              if(displayStartScreenIntro)
                StartScreenIntro(
                  onPressed: _handleOnPressedGotIt,
                ),
            ],
          )

        
        
        
        
    );
  }
}