import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicButton extends StatelessWidget {
  final double? width;
  final double height;
  final double? iconSize;
  final double? textSize;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? leadingIcon;
  final Color? iconColor;
  final bool? showLeading;
  final String? text;
  final void Function()? onTap;
  final double? radius;
  final FontWeight? boldness;

  DynamicButton({
    super.key,
    this.width,
    this.iconSize,
    this.textSize,
    this.backgroundColor,
    this.textColor,
    this.leadingIcon,
    required this.text,
    this.showLeading,
    this.iconColor,
    this.onTap,
    required this.height,
    this.radius,
    this.boldness,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 25))),
        child: Center(
          child: (showLeading ?? false)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      leadingIcon,
                      color: iconColor,
                      size: iconSize,
                    ),
                    Text(
                      text ?? " ",
                      style: GoogleFonts.poppins(
                          fontWeight: boldness ?? FontWeight.normal,
                          color: Colors.white,
                          fontSize: textSize ?? 18),
                    )
                  ],
                )
              : Text(
                  text ?? " ",
                  style: GoogleFonts.poppins(
                      fontWeight: boldness ?? FontWeight.normal,
                      color: textColor ?? Colors.white,
                      fontSize: textSize ?? 18),
                ),
        ),
      ),
    );
  }
}
