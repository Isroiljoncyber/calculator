import 'package:calculator/components/constants.dart';
import 'package:calculator/components/utils.dart';
import 'package:calculator/components/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin, Util {
  List<String> symbols = [
    "C",
    "+/-",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "⌫",
    "="
  ];

  double textSize = 80;
  double textSizeTop = 40;
  var answer = '';

  Alignment startAlignment = const Alignment(-1, 0);
  Alignment endAlignment = const Alignment(1, 0);
  late Alignment align = startAlignment;
  late TextEditingController _textEditingControllerTop;
  late TextEditingController _textEditingControllerMain;

  late AnimationController animationController;
  late Animation<Alignment> animAlign;

  late String main;
  late String top;
  late String temple;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    animAlign = AlignmentTween(begin: startAlignment, end: endAlignment)
        .animate(animationController);
    _textEditingControllerTop = TextEditingController();
    _textEditingControllerMain = TextEditingController();

    _textEditingControllerMain.text = "0";
    _textEditingControllerTop.text = "0";
    _textEditingControllerMain.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: clrBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height * 0.1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (animationController.status ==
                        AnimationStatus.dismissed) {
                      animationController.forward();
                      switchMode(ThemeModeEnum.lightMode);
                    } else if (animationController.status ==
                        AnimationStatus.completed) {
                      animationController.reverse();
                      switchMode(ThemeModeEnum.darkMode);
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: size.height * 0.04,
                    width: 72,
                    decoration: BoxDecoration(
                      color: clrSwitchBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Stack(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: const AssetImage("assets/sun.png"),
                                  height: size.height * 0.03,
                                  width: size.height * 0.03,
                                ),
                                Image(
                                  image: const AssetImage("assets/moon.png"),
                                  height: size.height * 0.03,
                                  width: size.height * 0.03,
                                )
                              ],
                            ),
                          ),
                          AnimatedBuilder(
                            builder: (BuildContext context, Widget? child) {
                              return Align(
                                alignment: animAlign.value,
                                child: Container(
                                  width: size.height * 0.03,
                                  height: size.height * 0.03,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: clrSwitchRoundBg,
                                  ),
                                ),
                              );
                            },
                            animation: animAlign,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.end,
                    enabled: false,
                    controller: _textEditingControllerTop,
                    style: TextStyle(
                      fontSize: textSizeTop,
                      color: clrTextTop,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    dragStartBehavior: DragStartBehavior.start,
                    textAlign: TextAlign.end,
                    enabled: false,
                    controller: _textEditingControllerMain,
                    style: TextStyle(
                      fontSize: textSize,
                      color: clrText,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: size.height * 0.61,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                primary: false,
                itemCount: symbols.length,
                itemBuilder: (BuildContext context, int index) {
                  return buttonKeyboard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonKeyboard(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: getButtonColor(index),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            buttonFun(index);
          },
          child: Center(
            child: Text(
              symbols[index],
              style: TextStyle(
                fontSize: 32,
                color: getButtonTextColor(index),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buttonFun(int index) {
    switch (symbols[index]) {
      case "0":
        textAppend(text: symbols[index]);
        break;
      case "1":
        textAppend(text: symbols[index]);
        break;
      case "2":
        textAppend(text: symbols[index]);
        break;
      case "3":
        textAppend(text: symbols[index]);
        break;
      case "4":
        textAppend(text: symbols[index]);
        break;
      case "5":
        textAppend(text: symbols[index]);
        break;
      case "6":
        textAppend(text: symbols[index]);
        break;
      case "7":
        textAppend(text: symbols[index]);
        break;
      case "8":
        textAppend(text: symbols[index]);
        break;
      case "9":
        textAppend(text: symbols[index]);
        break;
      case "+":
        {
          if (isLastDecimal()) {
            String temp = _textEditingControllerTop.text;
            if (temp != "0" && temp != "") {
              textAppend(text: symbols[index]);
              _textEditingControllerMain.text = "0";
            }
          }
        }
        break;
      case "×":
        {
          if (isLastDecimal()) {
            String temp = _textEditingControllerTop.text;
            if (temp != "0" && temp != "") {
              textAppend(text: symbols[index]);
              _textEditingControllerMain.text = "0";
            }
          }
        }
        break;
      case "-":
        {
          if (isLastDecimal()) {
            String temp = _textEditingControllerTop.text;
            if (temp != "0" && temp != "") {
              textAppend(text: symbols[index]);
              _textEditingControllerMain.text = "0";
            }
          }
        }
        break;
      case "÷":
        {
          if (isLastDecimal()) {
            String temp = _textEditingControllerTop.text;
            if (temp != "0" && temp != "") {
              textAppend(text: symbols[index]);
              _textEditingControllerMain.text = "0";
            }
          }
        }
        break;
      case "=":
        {
          if (_textEditingControllerMain.text.toString() != "0") {
            _textEditingControllerTop.text =
                _textEditingControllerMain.text.toString();
            _textEditingControllerMain.text = "0";
          }
        }
        break;
      case "C":
        {
          _textEditingControllerMain.text = "0";
          _textEditingControllerTop.text = "0";
          setState(() {});
        }
        break;
      case "⌫":
        {
          String temp = _textEditingControllerTop.text;
          if (temp.isNotEmpty) {
            temp = temp.substring(0, temp.length - 1);
          }
          if (temp.isEmpty) {
            temp = "0";
          }
          _textEditingControllerTop.text = temp;
          _textEditingControllerMain.text = temp;
          if (isAvailableForCalc()) {
            equalPressed();
          }
        }
        break;
      case ".":
        {
          String temp = _textEditingControllerTop.text;
          if (!temp.contains(".")) {
            textAppend(text: ".");
          }
          // _textEditingControllerTop.text = temp;
        }
        break;
      case "+/-":
        {
          String temp = _textEditingControllerMain.text;
          if (temp != "0") {
            _textEditingControllerMain.text = "-$temp";
            if (temp[0] == "-") {
              _textEditingControllerMain.text = temp.replaceAll("-", "");
            }
          }
          // _textEditingControllerTop.text = temp;
        }
        break;
      case "%":
        {
          String temp = _textEditingControllerMain.text;
          if (temp != "0") {
            equalPressed(mathEx: "$temp/100");
          }
          // _textEditingControllerTop.text = temp;
        }
        break;
    }
    changeTextSize();
  }

  changeTextSize() {
    if (_textEditingControllerMain.text.length > 9) {
      textSize = 50;
    } else if (_textEditingControllerMain.text.length > 8) {
      textSize = 60;
    } else if (_textEditingControllerMain.text.length > 7) {
      textSize = 70;
    }

    if (_textEditingControllerTop.text.length > 19) {
      textSizeTop = 25;
    } else if (_textEditingControllerTop.text.length > 15) {
      textSizeTop = 30;
    } else {
      textSizeTop = 40;
    }
    setState(() {});
  }

  textAppend({String text = ""}) {
    if (_textEditingControllerMain.text.toString() == "0" && text != ".") {
      _textEditingControllerMain.text = "";
    }
    if (_textEditingControllerTop.text.toString() == "0" && text != ".") {
      _textEditingControllerTop.text = "";
    }
    changeTextSize();
    if (text.isNotEmpty) {
      String temp = _textEditingControllerTop.text;
      if (!isAvailableForCalc()) {
        _textEditingControllerMain.text += text;
      }
      _textEditingControllerTop.text = temp + text;
    }
    if (isAvailableForCalc()) {
      equalPressed();
    }
    setState(() {});
  }

  void equalPressed({String mathEx = ""}) {
    bool isDecimal = false;
    String temp;
    String finalUserInput;
    finalUserInput = mathEx;
    if (mathEx == "") {
      finalUserInput = _textEditingControllerTop.text
          .replaceAll('×', '*')
          .replaceAll('÷', '/');
    }

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();

    temp = answer.substring(answer.indexOf(".") + 1, answer.length);
    for (int i = 1; i <= 9; i++) {
      if (temp.contains("$i")) {
        isDecimal = true;
        break;
      }
    }

    temp = answer;
    if (!isDecimal) {
      temp = answer.substring(0, answer.indexOf("."));
    }
    if (temp.length > 7) {
      _textEditingControllerMain.text = temp.substring(0, 8);
    } else {
      _textEditingControllerMain.text = temp;
    }
  }

  bool isAvailableForCalc() {
    String temp = _textEditingControllerTop.text.toString();
    return ((temp.contains("-") ||
        temp.contains("+") ||
        temp.contains("×") ||
        temp.contains("÷")) &&
        isLastDecimal());
  }

  bool isLastDecimal() {
    String temp = _textEditingControllerTop.text.toString();
    return (temp[temp.length - 1] != "÷" &&
        temp[temp.length - 1] != "×" &&
        temp[temp.length - 1] != "+" &&
        temp[temp.length - 1] != "-");
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Text(
        value,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
