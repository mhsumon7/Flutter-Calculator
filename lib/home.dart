import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalCulator extends StatefulWidget {
  //const CalCulator({Key? key}) : super(key: key);

  @override
  State<CalCulator> createState() => _CalCulatorState();
}

class _CalCulatorState extends State<CalCulator> {

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 50.0;
  double resultFontSize = 60.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = '0';
        result = '0';
        equationFontSize = 50.0;
        resultFontSize = 60.0;
      }

      else if (buttonText == "Del") {
        equationFontSize = 50.0;
        resultFontSize = 60.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      }

      else if (buttonText == "=") {
        equationFontSize = 50.0;
        resultFontSize = 60.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          //Expression exp = p.parse('50 - 10%');

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      }

      else {
        equationFontSize = 50.0;
        resultFontSize = 60.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttontext, double buttonHeight,
      Color buttonColor) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
            side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid
            ),
        ),

        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttontext),
        child: Text(buttontext,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 90, 10, 10),
            child: Text(equation, style: TextStyle(
              fontSize: equationFontSize,
            ),
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("", 1, Colors.transparent),
                          buildButton("C", 1, Colors.transparent),
                          buildButton("Del", 1, Colors.transparent),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.transparent),
                          buildButton("8", 1, Colors.transparent),
                          buildButton("9", 1, Colors.transparent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.transparent),
                          buildButton("5", 1, Colors.transparent),
                          buildButton("6", 1, Colors.transparent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('1', 1, Colors.transparent),
                          buildButton("2", 1, Colors.transparent),
                          buildButton("3", 1, Colors.transparent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.transparent),
                          buildButton("0", 1, Colors.transparent),
                          buildButton("0", 1, Colors.transparent),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("÷", 1, Colors.transparent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.transparent),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.transparent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.transparent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 1, Colors.transparent),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}