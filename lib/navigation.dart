import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/model/tile_content.dart';
import 'package:one_tutor_arithmetic/screens/task_screen.dart';

class Navigation {

  late BuildContext context;
  
  Navigation(BuildContext ctx) {

    context = ctx;

  }

  navigate(TileContent tileContent) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => TaskScreen(taskName: tileContent.taskName),
      ),
    );

  }
}

