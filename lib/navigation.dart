import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/model/tile_content.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/arithmetic_screen.dart';
import 'package:one_tutor_arithmetic/screens/ordering_screen/ordering_screen.dart';
import 'package:one_tutor_arithmetic/screens/task_screen/task_screen.dart';

class Navigation {

  late BuildContext context;
  
  Navigation(BuildContext ctx){

    context = ctx;

  }

  navigate(TileContent tileContent) {

    if([TaskName.addition, TaskName.subtraction, TaskName.multiplication, TaskName.division].contains(tileContent.taskName)){

      ArithmeticOperation arithmeticOperation = taskNameToArithmeticOperation(tileContent.taskName);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ArithmeticScreen(arithmeticOperation: arithmeticOperation),
        ),
      );

    } else if ( tileContent.taskName == TaskName.ordering ){
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => OrderingScreen(),
        ),
      );

    } else {

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => TaskScreen(taskName: tileContent.taskName),
        ),
      );

    }

  }

  ArithmeticOperation taskNameToArithmeticOperation(TaskName taskName){

    if(taskName == TaskName.addition)
    {
      return ArithmeticOperation.addition;
    }
    if(taskName == TaskName.subtraction)
    {
      return ArithmeticOperation.subtraction;
    }
    if(taskName == TaskName.multiplication)
    {
      return ArithmeticOperation.multiplication;
    }
    if(taskName == TaskName.division)
    {
      return ArithmeticOperation.division;
    }

    throw ArgumentError();

  }
}

