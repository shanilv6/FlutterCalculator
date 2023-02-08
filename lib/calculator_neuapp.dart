import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'constants.dart';
import 'neu_container.dart';

class CalculatorNeuApp extends StatefulWidget {
  @override
  _CalculatorNeuAppState createState() => _CalculatorNeuAppState();
}

class _CalculatorNeuAppState extends State<CalculatorNeuApp> {
  bool darkMode = false;

  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput =false;
  double outputSize = 34;

  onButtonClick(value, icon) {
    //if value is C
    if (value == "C") {
      input = "";
      output = "";
      //if value is Back-button
    } else if (icon == Icons.backspace_outlined) {
      if(input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      //if value is =
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
       if(output.endsWith(".0")){
         output = output.substring(0,output.length - 2);
       }
       input = output;
       hideInput = true;
       outputSize =50;

      }
    }else {
      input = input + value;
      hideInput = false;
      outputSize =34;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          darkMode ? darkMode = false : darkMode = true;
                        });
                      },
                      child: _switchMode()),
                  const SizedBox(
                    height: 80,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      hideInput ? "":
                      input,
                      style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: darkMode ? Colors.white : Colors.red),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "=",
                        style: TextStyle(
                            fontSize: 35,
                            color: darkMode ? Colors.green : Colors.grey),
                      ),
                      Text(
                        output,
                        style: TextStyle(
                            fontSize: outputSize,
                            color: darkMode ? Colors.green : Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              Column(
                children: [
                  /*  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonOval(title: 'sin'),
                      _buttonOval(title: 'cos'),
                      _buttonOval(title: 'tan'),
                      _buttonOval(title: '%'),
                    ],
                  )*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(
                            title: "C",
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent,
                          ),
                          _buttonRounded(
                            icon: Icons.backspace_outlined,
                            iconColor:
                                darkMode ? Colors.green : Colors.redAccent,
                          ),
                        ],
                      ),
                      _buttonRounded(
                        title: "/",
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: "7"),
                      _buttonRounded(title: "8"),
                      _buttonRounded(title: "9"),
                      _buttonRounded(
                        title: "x",
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: "4"),
                      _buttonRounded(title: "5"),
                      _buttonRounded(title: "6"),
                      _buttonRounded(
                        title: "-",
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: "1"),
                      _buttonRounded(title: "2"),
                      _buttonRounded(title: "3"),
                      _buttonRounded(
                        title: "+",
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: "%"),
                      _buttonRounded(title: "0"),
                      _buttonRounded(title: "."),
                      _buttonRounded(
                        title: "=",
                        textColor: darkMode ? Colors.green : Colors.redAccent,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonRounded(
      {title, double padding = 17, icon, iconColor, textColor}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuContainer(
        onTap: () => onButtonClick(title, icon),
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(40),
        padding: EdgeInsets.all(padding),
        child: SizedBox(
          width: padding * 2,
          height: padding * 2,
          child: Center(
              child: title != null
                  ? Text(
                      '$title',
                      style: TextStyle(
                          color: textColor ??
                              (darkMode ? Colors.white : Colors.black),
                          fontSize: 30),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 30,
                    )),
        ),
      ),
    );
  }

  /* Widget _buttonOval({title, double padding = 17}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: NeuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(50),
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: SizedBox(
          width: padding * 2,
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }*/

  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.wb_sunny,
              color: darkMode ? Colors.grey : Colors.redAccent,
            ),
            Icon(
              Icons.nightlight_round,
              color: darkMode ? Colors.green : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
