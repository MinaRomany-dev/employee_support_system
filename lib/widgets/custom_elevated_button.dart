import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final Color? backgroundColor;
  final double? radius;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final bool isStadiumBorder;
  final Widget? child;

  final List<Color>? gradientColors;
  final double? elevation;

  const CustomElevatedButton({
    super.key,
    this.prefixIcon,
    this.textStyle,
    this.isStadiumBorder = true,
    this.backgroundColor,
    this.radius,
    this.suffixIcon,
    this.label,
    required this.onTap,
    this.child,
    this.gradientColors,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = isStadiumBorder
        ? BorderRadius.circular(50)
        : BorderRadius.circular(radius ?? 17);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,

        gradient: gradientColors != null
            ? LinearGradient(colors: gradientColors!)
            : null,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: elevation ?? 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: gradientColors != null
              ? Colors.transparent
              : backgroundColor ?? Colors.blue,
          shadowColor: Colors.transparent,
          shape: isStadiumBorder
              ? const StadiumBorder()
              : RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
        onPressed: onTap,
        child:
            child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  label ?? '',
                  style:
                      textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (suffixIcon != null) ...[
                  const SizedBox(width: 8),
                  suffixIcon!,
                ],
              ],
            ),
      ),
    );
  }
}
