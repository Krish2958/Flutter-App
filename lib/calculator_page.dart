import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _outputHistory = "";
  String _input = "";

  void _onDigitPress(String text) {
    setState(() {
      _input += text;
      _output = _input;
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: OutlinedButton(
          onPressed: () {
            if (text == 'CLEAR ALL') {
              _clearAll();
            } else if (text == 'BACKSPACE') {
              _backspace();
            } else if (text == 'CLEAR') {
              _clearInput();
            } else if (text == '=') {
              _calculateResult();
            } else {
              _onDigitPress(text);
            }
          },
          child: text == 'BACKSPACE'
              ? Icon(Icons.backspace)
              : Text(
                  text,
                  style: TextStyle(fontSize: 24.0),
                ),
        ),
      ),
    );
  }

  void _clearAll() {
    setState(() {
      _input = "";
      _output = "0";
    });
  }

  void _backspace() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
        _output = _input.isEmpty ? "0" : _input;
      }
    });
  }

  void _clearInput() {
    setState(() {
      _input = "";
      _output = "0";
    });
  }

  void _calculateResult() {
    setState(() {
      _outputHistory = _input;
      try {
        Parser p = Parser();
        Expression exp = p.parse(_input);
        ContextModel cm = ContextModel();
        _output = exp.evaluate(EvaluationType.REAL, cm).toString();
        _input = "";
      } catch (e) {
        _output = "Error";
        _input = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                _outputHistory,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("x"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("."),
                _buildButton("0"),
                _buildButton("00"),
                _buildButton("+"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("CLEAR ALL"),
                _buildButton("CLEAR"),
                _buildButton("BACKSPACE"),
                _buildButton("="),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
