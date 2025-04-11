import 'package:aspis/design/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final void Function(String) onChanged;
  final bool isSecure;
  final bool enabled;
  final TextEditingController? controller;
  final String? placeholder;
  final Widget? actionWidget;
  final EdgeInsets? actionPadding;
  const Input({
    super.key,
    required this.onChanged,
    this.controller,
    this.placeholder,
    this.actionWidget,
    this.actionPadding,
    this.enabled = true,
    this.isSecure = false
  });

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF626161),
        width: 1
      ),
      borderRadius: BorderRadius.circular(5)
    );
    return TextField(
      enabled: enabled,
      onChanged: onChanged,
      controller: controller,
      obscureText: isSecure,
      obscuringCharacter: '*',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        height: 1.2
      ),
      cursorHeight: 24,
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled ? Colors.white : Color(0xFFF1F1F1),
        suffixIcon: actionWidget == null ? null : Padding(
          padding: actionPadding ?? EdgeInsets.zero,
          child: actionWidget
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: enabled ? Color(0xFF929292) : Color(0xFFB6B6B6),
          fontSize: 20,
          height: 1.2
        ),
        border: borderStyle,
        enabledBorder: borderStyle,
        disabledBorder: borderStyle,
        focusedBorder: borderStyle,
        errorBorder: borderStyle,
        focusedErrorBorder: borderStyle,
        isDense: false,
        contentPadding: EdgeInsets.only(left: 13, top: 12, bottom: 12)
      )
    );
  }
}

class InputScope extends StatelessWidget {
  final String label;
  final Input input;
  const InputScope({super.key, required this.label, required this.input});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 20, fontWeight: Weight.medium)),
        const SizedBox(height: 12),
        input
      ]
    );
  }
}
