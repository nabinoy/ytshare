import 'package:flutter/material.dart';

class Design0 extends StatefulWidget {
  final double widgetSize;
  final ValueChanged<double> onSizeChanged;

  const Design0(this.widgetSize,this.onSizeChanged, {super.key});

  @override
  State<Design0> createState() => _Design0State();
}

class _Design0State extends State<Design0> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          height: MediaQuery.of(context).size.height * 0.55,
          width: MediaQuery.of(context).size.width * 0.6),
      Container(
        width: widget.widgetSize, // Adjust based on the maximum size
        height: widget.widgetSize, // Adjust based on the maximum size
        child: Container(
          color: Colors.blue,
          child: Text(
            'Text',
            style: TextStyle(fontSize: widget.widgetSize * 0.4),
          ),
        ),
      )
    ]);
  }
}
