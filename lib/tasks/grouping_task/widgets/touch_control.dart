import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/grouping_task/models/grouping_assignment.dart';

class TouchControl extends StatefulWidget {

  // final List<Offset> centres;
  // final double fontSize;
  // final int cols;
  // final int rows;
  final GroupingAssignment assignment;
  
  const TouchControl({ super.key, /*required this.cols, required this.rows, required this.centres, required this.fontSize*/required this.assignment });

  @override
  State<TouchControl> createState() => _TouchControlState();
}

class _TouchControlState extends State<TouchControl> {

  List<List<Offset>> paths = [];
  int currentPath = -1;

  updatePath(Offset offset){

    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset position = referenceBox.globalToLocal(offset);
    setState((){
      paths[currentPath].add(position);
    });

  }

  void _handlePanStart(DragStartDetails details) {
    currentPath++;
    paths.add([]);
    updatePath(details.globalPosition);
  }

  void _handlePanUpdate(DragUpdateDetails details) => updatePath(details.globalPosition);
  

  void _handlePanEnd(DragEndDetails details) {
    setState((){
      paths[currentPath].add(paths[currentPath][0]);
      bool isGroupAdded = widget.assignment.hitTest(paths[currentPath]);
      if(!isGroupAdded){

        paths.remove(paths[currentPath]);
        currentPath--;

      }
    });

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double height = size.width + widget.assignment.fontSize;

    return SizedBox(
      width: size.width,
      height: height,
      // decoration: BoxDecoration(color: Colors.grey[200] as Color,),
      child: GestureDetector(
        onPanStart:_handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        child: CustomPaint(
          size: Size(size.width, height),
          painter: TouchControlPainter( widget.assignment.cols, widget.assignment.rows, widget.assignment.centres, widget.assignment.selectedCentres, widget.assignment.fontSize, widget.assignment.icon, paths,),
        ),
      ),
    );

  }
}

class TouchControlPainter extends CustomPainter {

  final List<List<Offset>> paths;
  final List<Offset> centres;
  final List<Offset> selectedCentres;
  final double fontSize;
  final int cols;
  final int rows;
  final IconData icon;

  TouchControlPainter(this.cols, this.rows, this.centres, this.selectedCentres, this.fontSize,  this.icon, this.paths,);

  @override
  void paint(Canvas canvas, Size size) {

    double vertOffset = 0.5 * fontSize;

    // final auxPaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1;

    // for(int col = 0; col < cols; col ++)
    // {
    //   canvas.drawLine(
    //     Offset(size.width / cols * col, vertOffset), 
    //     Offset(size.width / cols * col, size.width + vertOffset), 
    //     auxPaint
    //   );
    // }

    // for(int row = 0; row < rows; row ++)
    // {
    //   canvas.drawLine(
    //     Offset(0, size.width / rows * row + vertOffset),
    //     Offset(size.width, size.width / rows * row + vertOffset), 
    //     auxPaint
    //   );
    // }

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for(List<Offset> offsets in paths){
      drawPath(offsets, canvas, paint);
    }

    // const icon = Icons.egg;
  
    for(Offset centre in centres){

      if(selectedCentres.contains(centre)){
        continue;
      }

      var newOffset = Offset(centre.dx - 0.5*fontSize, centre.dy - 0.5*fontSize + vertOffset);

      TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
      textPainter.text = TextSpan(text: String.fromCharCode(icon.codePoint), style: TextStyle(fontSize: fontSize, fontFamily: icon.fontFamily, color: Colors.black));
      textPainter
        ..layout()
        ..paint(canvas, newOffset);

      // canvas.drawCircle(Offset(centre.dx, centre.dy + vertOffset), 2, auxPaint);

    }

    for(Offset selectedCentre in selectedCentres){

      var newOffset = Offset(selectedCentre.dx - 0.5*fontSize, selectedCentre.dy - 0.5*fontSize + vertOffset);

      TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
      textPainter.text = TextSpan(text: String.fromCharCode(icon.codePoint), style: TextStyle(fontSize: fontSize, fontFamily: icon.fontFamily, color: Colors.grey));
      textPainter
        ..layout()
        ..paint(canvas, newOffset);


      // canvas.drawCircle(Offset(selectedCentre.dx, selectedCentre.dy + vertOffset), 2, auxPaint);

    }

  }

  drawPath(List<Offset> offsets, Canvas canvas, Paint paint){
    
    if(offsets.length < 2){
      return;
    }
    
    final path = Path()..moveTo(offsets[0].dx, offsets[0].dy);

    for(int i = 1; i < offsets.length; i++){
      path.lineTo(offsets[i].dx, offsets[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}