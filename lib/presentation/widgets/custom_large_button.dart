import 'package:flutter/material.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';

class CustomLargeButton extends StatefulWidget {
  final double width;
  final void Function()? onPressed;
  final Color backgroundColor;
  final String text;
  final TextStyle? textStyle;

  const CustomLargeButton({
    super.key,
    required this.width,
    this.onPressed,
    required this.backgroundColor,
    required this.text,
    this.textStyle,
  });

  @override
  State<CustomLargeButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomLargeButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: kSize50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: widget.backgroundColor),
        child: Text(widget.text, style: widget.textStyle),
      ),
    );
  }
}
