import 'package:first_app/model/category.dart';
import 'package:flutter/material.dart';

// class Tile extends StatelessWidget {
//   const Tile({
//     super.key,
//     required this.category,
//     required this.onSelect,
//   });

//   final Category category;
//   final void Function() onSelect;

//   @override
//   Widget build(BuildContext context) {

//     return Ink(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
//         child: InkWell(
//           onTap: onSelect,
//           splashColor: Theme.of(context).primaryColor,
//           borderRadius: BorderRadius.circular(16),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: LinearGradient(
//                   colors: [
//                     category.color.withOpacity(0.55),
//                     category.color.withOpacity(0.9),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                   category.icon,
//                   ),
//                   const SizedBox(
//                     width: 5.0,
//                   ),
//                   Text(
//                     category.title,
//                     style: const TextStyle(fontSize: 40),
//                   ),
                  
//                 ],
//               )
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Tile extends StatelessWidget {
  final Category category;
  final double width;
  final double height;
  final Function onPressed;

  Tile({
    required this.category,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(

        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    category.color.withOpacity(0.55),
                    category.color.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),


        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //         color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        //   ],
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     stops: [0.0, 1.0],
        //     colors: [
        //       Colors.deepPurple.shade400,
        //       Colors.deepPurple.shade200,
        //     ],
        //   ),
        //   color: Colors.deepPurple.shade300,
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              fixedSize: MaterialStateProperty.all(Size(width, height)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.transparent),
              // elevation: MaterialStateProperty.all(3),
              shadowColor:
                  MaterialStateProperty.all(Colors.transparent),
                  ),
          onPressed: () {
            onPressed();
          },
          // child: Padding(
          //   padding: const EdgeInsets.only(
          //     top: 10,
          //     bottom: 10,
          //   ),
          //   child: Text(
          //     category.title,
          //     style: TextStyle(
          //       fontSize: 18,
          //       // fontWeight: FontWeight.w700,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          child: Container(
            // padding: const EdgeInsets.all(16),
            // child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category.icon,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      category.title,
                      style: const TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    
                  ],
                )
              ),
          //),
        ),
      ),
    );
  }
}