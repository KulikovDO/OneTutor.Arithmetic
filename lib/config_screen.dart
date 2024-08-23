import 'package:first_app/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {

  late TextEditingController _textEditingController;
  bool canSave = true;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {
        canSave = _textEditingController.text == "";  
      });
    });
    _loadPrefs();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final iterations = prefs.getInt('iterations') ?? 10;
    _textEditingController.text = iterations.toString();

  }

  void _handleSaveOnPressed(BuildContext context) async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('iterations', int.parse(_textEditingController.text));

    // ??? if (!mounted) return;

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
          // automaticallyImplyLeading: false,
          title: const Text("Practice Addition"),
        ),
        body: 
          Center(
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Number of iterations",
                        ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: 300.0,
                    height: 50.0,
                    child: 
                      ElevatedButton(
                        onPressed: canSave ? null: () => _handleSaveOnPressed(context),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.save,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Save'),
                              
                            ],
                          )
                        ),
                      ),
                  ),
                ]
              ),
          ),
      );
      
  }

}