import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/screens/start_screen.dart';
import 'package:one_tutor_arithmetic/widgets/decorated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {

  int _iterations = 10;
  bool canSave = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _iterations = prefs.getInt('iterations') ?? 10;
    });
  }

  void _handleOnPressedSave(BuildContext context) async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('iterations', _iterations);

    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const StartScreen(),
      ),
    );
   
  }

  @override
  Widget build(BuildContext context) {

    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text( "OneTutor: Arithmetic" ),
        ),
        body: Stack(
            children: [
              const Background( ),
              Center(
                child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Number of iterations: $_iterations",
                        style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),

                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always),
                        child: Slider(
                          value: _iterations.toDouble(),
                          min: 3,
                          max: 25,
                          // divisions: 20,
                          label: _iterations.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _iterations = value.toInt();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      DecoratedButton(
                        width: 200.0,
                        height: 50.0,
                        text: "Save", 
                        icon: Icons.save, 
                        onPressed: () {
                          _handleOnPressedSave(context);
                        }
                      ),
                    ]
                  ),
              ),
            ],
        ),
      );
      
  }

}