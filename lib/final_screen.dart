import 'package:first_app/main_screen.dart';
import 'package:flutter/material.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  void _handleOnPressed(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MainScreen(),
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
      ),
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 50.0,
          child: 
            ElevatedButton(
              onPressed: () { 
                _handleOnPressed(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restart_alt,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('Restart'),
                    
                  ],
                )
              ),
            ),
        )
      ),
    );
    
  }
}