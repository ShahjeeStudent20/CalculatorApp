// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculatorhome extends StatefulWidget {
  const Calculatorhome({super.key});

  @override
  State<Calculatorhome> createState() => _CalculatorhomeState();
}

class _CalculatorhomeState extends State<Calculatorhome> {
  String userinput = "";
  String result = "0";
  List<String> buttonlist = [
    'Clr',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'Del',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(19),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userinput,
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: buttonlist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(buttonlist[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  CustomButton(String text) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 1,
                // offset: const Offset(-2, -3),
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == 'Clr' || text == '(' || text == ')') {
      return Colors.black;
      // yaha pr in buttons ka special clrs change hga
    }
    return Colors.white;
    // or yaha par specifically normal buttons ka clr return krdege like 1,2,3 pr
  }

  getBgColor(String text) {
    if (text == 'Clr' || text == '(' || text == ')') {
      return Colors.grey.shade500;
    }
    if (text == '/' || text == '*' || text == '+' || text == '-') {
      return Colors.orange.shade700;
    }
    if (text == '=' || text == 'Del') {
      return Colors.blueGrey;
    }
  }

  handleButtons(String text) {
    if (text == 'Clr') {
      userinput = '';
      result = '0';
      return;
    }
    if (text == 'Del') {
      if (userinput.isNotEmpty) {
        userinput = userinput.substring(0, userinput.length - 1);
      }
      return;
    }

    if (text == '=') {
      result = calculate();
      userinput = '';

      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', '');
      }
    } else {
      userinput += text;
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userinput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      userinput = '';
      return evaluation.toString();
    } catch (e) {
      userinput = '';
      return "Error";
    }
  }
}
