import 'package:aspis/design/theme.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enable;
  const Button(this.text, {super.key, required this.onPressed, this.enable = true});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.enable ? widget.onPressed : null,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.enable ?
            _isPressed ?
              Palette.sub4 :
              Palette.sub2 :
          Color(0xFFD0D0D0)
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        duration: Duration(milliseconds: 150),
        child: Center(
          child: Text(widget.text, style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: Weight.regular,
            height: 1.2
          ))
        )
      ),
    );
  }
}

class SheetButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onPressed;
  const SheetButton({super.key, required this.iconPath, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 51,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.sub2,
            width: 1
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 11),
            Text(text, style: TextStyle(fontSize: 14, height: 1))
          ]
        )
      ),
    );
  }
}

