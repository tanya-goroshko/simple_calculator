import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class BuildButton extends StatelessWidget {
  final String text;
  final double height;
  final Color color;

  BuildButton({this.text, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * height,
        color: color,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () {
            textToFunction(() {
              context.bloc<CalculatorCubit>().reset();
            }, () {
              context.bloc<CalculatorCubit>().backspace();
            },
            () {
              context.bloc<CalculatorCubit>().result();
            },
            () {
              context.bloc<CalculatorCubit>().input(text);
            });
          },
          child: Text(text,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ));
  }

  void textToFunction(
      Function reset, Function backspace, Function result, Function input) {
    switch (text) {
      case 'C':
        reset();
        break;
      case '⌫':
        backspace();
        break;
      case '=':
        result();
        break;
      default:
        input();
    }
  }
}
