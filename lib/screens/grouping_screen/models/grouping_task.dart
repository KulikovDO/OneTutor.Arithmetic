import 'dart:math';

import 'package:flutter/material.dart';

Random rng = Random();

const groupSize = 2;

const icons = [Icons.egg, Icons.star, Icons.ac_unit, Icons.local_florist, Icons.park, Icons.toys];
const objectNames = ["eggs", "stars", "snowflakes", "flowers", "trees", "cars"];

class GroupingTask {

  const GroupingTask({
      
      required this.rows,
      required this.cols,
      required this.fontSize,
      required this.centres,
      required this.selectedCentres,
      required this.icon,
      required this.answer,
      required this.text,
      required this.richText,

    });

  final int rows;
  final int cols;  
  final double fontSize;
  final List<Offset> centres;
  final List<Offset> selectedCentres;
  final IconData icon;
  final int answer;
  final String text;
  final Widget richText;

  static GroupingTask create() => GroupingTask( rows: 0, cols: 0, fontSize: 0, centres: [], selectedCentres: [], icon: icons[0], answer: 0, text: "", richText: const Text(""));

  GroupingTask prepareTask(double screenWidth){

    int cols = rng.nextInt(5 - 3 + 1) + 3;
    int rows = rng.nextInt(5 - 3 + 1) + 3;

    double fontSize = 0.7 * screenWidth / min(cols, rows);
    int numOfObjects = 6 + rng.nextInt(cols * rows - 6);

    if(numOfObjects % groupSize != 0){
      numOfObjects++;
    }

    List<Offset> cellPositions = [];
    List<Offset> centres = [];

    for(int i = 0; i < numOfObjects; i++){

    // [ 0.5 * fontSize .. screenWidth / cols - 0.5*fontSize ] - horizontal
    // [ 0.5 * fontSize .. screenWidth / rows - 0.5*fontSize ] - vertical

      cellPositions.add(
        Offset(
          rng.nextDouble() * ( screenWidth / cols - fontSize ) + 0.5 * fontSize,
          rng.nextDouble() * ( screenWidth / rows - fontSize ) + 0.5 * fontSize
        )

      );

    }

    int objectIndex = 0;
    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
      
        
        if(objectIndex >= cellPositions.length){
          break;
        }

        centres.add(
          Offset(
            cellPositions[objectIndex].dx + screenWidth / cols * col,
            cellPositions[objectIndex].dy + screenWidth / rows * row
          )
        );

        objectIndex++;

      }
    }

    int iconIndex = rng.nextInt(icons.length);

    String text = "Group the ${objectNames[iconIndex]} in twos. How many groups are there?";

    Widget richText = RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 20, color: Colors.black,),
        children: [
          TextSpan(text: "Group the ${objectNames[iconIndex]} in "),
          const TextSpan(text: "twos", style: TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: " How many groups are there?"),
        ],
      ),
    );

    return GroupingTask(
      rows: rows, 
      cols: cols, 
      fontSize: fontSize, 
      centres: centres, 
      selectedCentres: [], 
      icon: icons[iconIndex],
      answer: (numOfObjects / groupSize).round(),
      text: text,
      richText: richText,
    );

  }

  bool hitTest(List<Offset> polygon){

    List<Offset> selectedCentresToAdd = [];

    for(Offset centre in centres){

      if(selectedCentres.contains(centre)){
        continue;
      }

      Offset offsettedCentre = Offset(centre.dx, centre.dy + 0.5*fontSize);
      bool isInside = isPointInPolygon(offsettedCentre, polygon);
      if(isInside){
        selectedCentresToAdd.add(centre);
      }
    }

    if(selectedCentresToAdd.length == groupSize){

      for(Offset selectedCentreToAdd in selectedCentresToAdd){
        selectedCentres.add(selectedCentreToAdd);
      }

    }

    return selectedCentresToAdd.length == groupSize;

  }

  bool isPointInPolygon(Offset p, List<Offset> polygon){

    double minX = polygon[ 0 ].dx;
    double maxX = polygon[ 0 ].dx;
    double minY = polygon[ 0 ].dy;
    double maxY = polygon[ 0 ].dy;
    for ( int i = 1 ; i < polygon.length ; i++ )
    {
        Offset q = polygon[ i ];
        minX = min( q.dx, minX );
        maxX = max( q.dx, maxX );
        minY = min( q.dy, minY );
        maxY = max( q.dy, maxY );
    }

    if ( p.dx < minX || p.dx > maxX || p.dy < minY || p.dy > maxY )
    {
        return false;
    }

    // https://wrf.ecse.rpi.edu/Research/Short_Notes/pnpoly.html
    bool inside = false;
    for ( int i = 0, j = polygon.length - 1 ; i < polygon.length ; j = i++ )
    {
        if ( ( polygon[ i ].dy > p.dy ) != ( polygon[ j ].dy > p.dy ) &&
             p.dx < ( polygon[ j ].dx - polygon[ i ].dx ) * ( p.dy - polygon[ i ].dy ) / ( polygon[ j ].dy - polygon[ i ].dy ) + polygon[ i ].dx )
        {
            inside = !inside;
        }
    }

    return inside;

  }
}