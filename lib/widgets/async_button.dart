import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  const AsyncButton({
    super.key,
    required this.onClick,
    required this.child,
    this.loadingCircleSize = 25,
    this.loadingCircleWidth = 4,
  });

  final Future Function() onClick;
  final Widget child;
  final double loadingCircleSize;
  final double loadingCircleWidth;

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool isActive = true;

  void _onClick() async {
    setState(() {
      isActive = false;
    });
    await widget.onClick();
    setState(() {
      isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? _onClick : null,
      child: isActive
          ? widget.child
          : SizedBox(
              width: widget.loadingCircleSize,
              height: widget.loadingCircleSize,
              child: CircularProgressIndicator(
                strokeWidth: widget.loadingCircleWidth,
              ),
            ),
    );
  }
}
