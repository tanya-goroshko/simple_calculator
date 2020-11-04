import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

enum Operation { reset, backspace, result, input, error }

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc(CalculatorState initialState) : super(initialState);

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    switch (event.operation) {
      case Operation.input:
        var newState = state.expression == '0' ? '' : state.expression;

        if (state.expression[state.expression.length - 1] == '.' && event.symbol == '.') {
          newState = newState.substring(0, newState.length - 1);
        }
        yield CalculatorState(
            result: state.result,
            expression: (event.symbol == '0' && newState == '0')
                ? '0'
                : newState + event.symbol,
            resultFontSize: 28.0,
            expressionFontSize: 38.0);
        break;
      case Operation.reset:
        yield CalculatorState(
            result: '0',
            expression: '0',
            resultFontSize: 28.0,
            expressionFontSize: 28.0);
        break;
      case Operation.backspace:
        yield CalculatorState(
            result: '0',
            expression:
                state.expression.substring(0, state.expression.length - 1),
            resultFontSize: 28.0,
            expressionFontSize: 38.0);
        break;
      case Operation.result:
        var expression = state.expression.replaceAll("÷", "/");
        expression = expression.replaceAll("×", "*");

        if (expression.length == 0) {
          yield CalculatorState(
              result: '0',
              expression: '0',
              resultFontSize: 28.0,
              expressionFontSize: 28.0);
          break;
        }

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          yield CalculatorState(
              result: '${exp.evaluate(EvaluationType.REAL, cm)}',
              expression: state.expression,
              resultFontSize: 38.0,
              expressionFontSize: 28.0);
        } catch (e) {
          yield CalculatorState(
              result: "Error",
              expression: '0',
              resultFontSize: 38.0,
              expressionFontSize: 0);
        }
        break;
      default:
        yield CalculatorState(
            result: 'Unknown operation',
            expression: '',
            resultFontSize: 38.0,
            expressionFontSize: 0);
    }
  }
}

class CalculatorEvent extends Equatable {
  final Operation operation;
  final String symbol;

  CalculatorEvent({@required this.symbol, @required this.operation})
      : assert(operation != null),
        assert(symbol != null);

  @override
  List<Object> get props => [symbol, operation];
}

class CalculatorState extends Equatable {
  final String result;
  final String expression;
  final double resultFontSize;
  final double expressionFontSize;

  CalculatorState(
      {@required this.result,
      @required this.expression,
      @required this.resultFontSize,
      @required this.expressionFontSize})
      : assert(result != null),
        assert(expression != null),
        assert(resultFontSize != null),
        assert(expressionFontSize != null);

  @override
  List<Object> get props =>
      [result, expression, resultFontSize, expressionFontSize];
}
