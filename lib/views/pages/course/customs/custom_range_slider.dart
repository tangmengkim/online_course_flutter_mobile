import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';

class CustomRangeSliderThumb extends RangeSliderThumbShape {
  final double thumbRadius;

  CustomRangeSliderThumb({this.thumbRadius = 10.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    // Paint the thumb (filled circle)
    final Paint thumbPaint = Paint()
      ..color = Colors.white // Thumb color
      ..style = PaintingStyle.fill;

    // Draw a circular thumb
    canvas.drawCircle(center, thumbRadius, thumbPaint);

    // Optional: Add a border around the thumb
    final Paint borderPaint = Paint()
      ..color = ColorConstant.primaryColor // Border color
      ..strokeWidth = 2 // Border width
      ..style = PaintingStyle.stroke;

    // Draw the border around the thumb
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}

/// Custom tooltip (value indicator)
class CustomValueIndicator extends RangeSliderValueIndicatorShape {
  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    required TextPainter labelPainter,
    required double textScaleFactor,
  }) {
    return const Size(40, 20); // Adjust tooltip size
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      bool isDiscrete = false,
      bool isOnTop = false,
      required SliderThemeData sliderTheme,
      TextDirection? textDirection,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      double? value,
      double? textScaleFactor,
      Size? sizeWithOverflow,
      Thumb? thumb}) {
    final Canvas canvas = context.canvas;

    // Adjust tooltip position
    Offset tooltipOffset = center + const Offset(0, 30);

    // Draw tooltip background
    final Paint tooltipPaint = Paint()
      ..color = Colors.transparent // Background color
      ..style = PaintingStyle.fill;

    final Rect tooltipRect = Rect.fromCenter(
      center: tooltipOffset,
      width: 40,
      height: 20,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(tooltipRect, const Radius.circular(5)),
      tooltipPaint,
    );
    // Create a custom text style for the label
    final TextStyle textStyle = TextStyle(
        color: Colors.black, // Set the text color here
        fontSize: 14, // Customize font size if needed
        fontWeight: FontWeight.w600);

    // Apply the custom text style to the labelPainter
    labelPainter.text = TextSpan(
      text: labelPainter.plainText, // Display the value as text
      style: textStyle,
    );
    // Make sure to layout the text before painting
    labelPainter.layout(minWidth: 0, maxWidth: double.infinity);
    // Draw text inside tooltip
    labelPainter.paint(
      canvas,
      Offset(tooltipOffset.dx - (labelPainter.width / 2),
          tooltipOffset.dy - (labelPainter.height / 2)),
    );
  }
}
