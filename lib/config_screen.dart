import 'package:first_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {

  void _handleSaveOnPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {

    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // hintText: "Number of iterations",
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
                        onPressed: () { 
                          _handleSaveOnPressed(context);
                        },
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