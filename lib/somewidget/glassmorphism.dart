import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatefulWidget {
  final double blur;
  final double opacity;
  final Widget child;
  const GlassMorphism({Key? key,required this.blur,required this.child,required this.opacity}) : super(key: key);

  @override
  State<GlassMorphism> createState() => _GlassMorphismState();
}

class _GlassMorphismState extends State<GlassMorphism> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.blur,sigmaY: widget.blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(widget.opacity),
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            border: Border.all(
              width: 1.5,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
