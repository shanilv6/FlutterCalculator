import 'package:flutter/material.dart';

import 'constants.dart';

class NeuContainer extends StatefulWidget {
  final onTap;
  final bool darkMode;
  final  child;
  final borderRadius;
  final padding;

  const NeuContainer(
      {super.key, this.darkMode = false,
        this.child,
        this.borderRadius,
        this.padding,  this.onTap});
  @override
  State<NeuContainer> createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    bool? darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: darkMode ? colorDark : colorLight,
              borderRadius: widget.borderRadius,
              boxShadow: _isPressed
                  ? null
                  : [
                BoxShadow(
                    color: darkMode
                        ? Colors.black54
                        : Colors.blueGrey.shade200,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color:
                    darkMode ? Colors.blueGrey.shade700 : Colors.white,
                    offset: const Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0)
              ],
            ),
            child: widget.child),
      ),
    );
  }
}
