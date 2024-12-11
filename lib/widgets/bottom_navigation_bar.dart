import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/custom_floating_action_button.dart';
import 'package:one_tutor_arithmetic/widgets/stacked_icons.dart';

class BottomNavigationBarContainer extends StatelessWidget {
  
  final Function onPress;
  final bool isDisabled;

  const BottomNavigationBarContainer({ super.key, required this.onPress, required this.isDisabled });
  
  _handleFloatingActionButtonPress() {
    onPress();
  }

  @override
  Widget build(BuildContext context) {
  
    return Container(
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        height: 60,
        width: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomFloatingActionButton(
              isDisabled: isDisabled,
              onPressed: _handleFloatingActionButtonPress,
              child: const StackedIcons(
                baseIcon: Icons.navigate_next,
                secondIcon: Icons.add,
                size: 40
              ),   
            ),
            const SizedBox(
              width: 10.0,
            ),
            // CustomFloatingActionButton(
            //   onPressed: _handleFloatingActionButtonPress,
            //   child: const StackedIcons(
            //     baseIcon: Icons.navigate_next,
            //     secondIcon: Icons.remove,
            //     size: 40
            //   ),   
            // ),
          ],
        ),
      );
  }

  
}

