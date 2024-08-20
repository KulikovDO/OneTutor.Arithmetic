import 'package:first_app/audio_controller.dart';
import 'package:first_app/home_screen.dart';
import 'package:flutter/material.dart';



void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  final audioController = AudioController();
  await audioController.initialize();
  runApp(MyApp(audioController: audioController,));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.audioController, super.key});

  final AudioController audioController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice Addition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MyHomePage(title: 'Practice Addition'),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text("Practice Addition"),
        ),
        body: HomeScreen(audioController: audioController),
      ),
    );
  }
}

