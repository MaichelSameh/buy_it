import 'package:flutter/material.dart';

class LogoBuilder extends StatelessWidget {
  final BoxConstraints constraints;
  LogoBuilder({required this.constraints});
  @override
  Widget build(BuildContext context) {
    final double width =
        constraints.maxWidth > 300 ? 300 : constraints.maxWidth;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: constraints.maxHeight * 0.03,
          ),
          height: constraints.maxHeight * 0.2,
          width: width,
          child: Image.asset("assets/icons/buy_it.png"),
        ),
        Text(
          "Buy it",
          style: TextStyle(
            fontFamily: "pacifico",
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
