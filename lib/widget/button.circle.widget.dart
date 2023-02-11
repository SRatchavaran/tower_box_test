import 'package:flutter/cupertino.dart';

class ButtonCircleWidget extends StatelessWidget {
  final Function()? onLongPressUp;
  final Function()? onPressed;
  final Color color;
  const ButtonCircleWidget(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.onLongPressUp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: onLongPressUp,
      onLongPress: onPressed,
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF707070),
            width: 1,
          ),
        ),
      ),
    );
  }
}
