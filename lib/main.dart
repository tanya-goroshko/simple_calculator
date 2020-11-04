import 'package:calculator/bloc.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: BlocProvider<CalculatorBloc>(
        create: (context) => CalculatorBloc(CalculatorState(
            result: '0',
            expression: '0',
            resultFontSize: 38.0,
            expressionFontSize: 28.0)),
        child: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    state.expression,
                    style: TextStyle(fontSize: state.expressionFontSize),
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Text(
                      state.result,
                      style: TextStyle(fontSize: state.resultFontSize),
                    )),
                Expanded(
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Table(
                          children: [
                            _buttonRow('C', Colors.redAccent, '×', Colors.blue,
                                '÷', Colors.blue, '⌫', Colors.blue),
                            _buttonRow('7', Colors.black54, '8', Colors.black54,
                                '9', Colors.black54, '+', Colors.blue),
                            _buttonRow('4', Colors.black54, '5', Colors.black54,
                                '6', Colors.black54, '-', Colors.blue),
                            _buttonRow('1', Colors.black54, '2', Colors.black54,
                                '3', Colors.black54, '=', Colors.redAccent),
                            _buttonRow('(', Colors.black54, ')', Colors.black54,
                                '0', Colors.black54, '.', Colors.black54),
                          ],
                        )),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  TableRow _buttonRow(
      firstButtonName,
      firstButtonColor,
      secondButtonName,
      secondButtonColor,
      thirdButtonName,
      thirdButtonColor,
      fourthButtonName,
      fourthButtonColor) {
    return TableRow(children: [
      BuildButton(text: firstButtonName, height: 1, color: firstButtonColor),
      BuildButton(text: secondButtonName, height: 1, color: secondButtonColor),
      BuildButton(text: thirdButtonName, height: 1, color: thirdButtonColor),
      BuildButton(text: fourthButtonName, height: 1, color: fourthButtonColor),
    ]);
  }
}
