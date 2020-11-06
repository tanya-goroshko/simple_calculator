import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit()
      : super(CalculatorState(
            result: '0',
            expression: '0',
            resultFontSize: 38.0,
            expressionFontSize: 28.0));

  void input(String symbol) {
    var newState = state.expression == '0' ? '' : state.expression;

    if (state.expression[state.expression.length - 1] == '.' && symbol == '.') {
      newState = newState.substring(0, newState.length - 1);
    }

    emit(state.copyWith(
        result: state.result,
        expression:
            (symbol == '0' && newState == '0') ? '0' : newState + symbol,
        resultFontSize: 28.0,
        expressionFontSize: 38.0));
  }

  void reset() => emit(state.copyWith(
      result: '0',
      expression: '0',
      resultFontSize: 28.0,
      expressionFontSize: 28.0));

  void backspace() => emit(state.copyWith(
      result: '0',
      expression: state.expression.substring(0, state.expression.length - 1),
      resultFontSize: 28.0,
      expressionFontSize: 38.0));

  void result() {
    var expression = state.expression.replaceAll("÷", "/");
    expression = expression.replaceAll("×", "*");

    if (expression.length == 0) {
      emit(state.copyWith(
          result: '0',
          expression: '0',
          resultFontSize: 28.0,
          expressionFontSize: 28.0));
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);

      ContextModel cm = ContextModel();
      emit(state.copyWith(
          result: '${exp.evaluate(EvaluationType.REAL, cm)}',
          expression: state.expression,
          resultFontSize: 38.0,
          expressionFontSize: 28.0));
    } catch (e) {
      emit(state.copyWith(
          result: "Error",
          expression: '0',
          resultFontSize: 38.0,
          expressionFontSize: 0));
    }
  }
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

  CalculatorState copyWith(
      {String result,
      String expression,
      double resultFontSize,
      double expressionFontSize}) {
    return CalculatorState(
        result: result ?? this.result,
        expression: expression ?? this.expression,
        resultFontSize: resultFontSize ?? this.resultFontSize,
        expressionFontSize: expressionFontSize ?? this.expressionFontSize);
  }
}
