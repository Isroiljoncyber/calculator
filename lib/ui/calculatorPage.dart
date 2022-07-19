import 'package:calculator/components/constants.dart';
import 'package:calculator/components/utils.dart';
import 'package:calculator/components/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Alignment startAlignment = const Alignment(-1, 0);
  Alignment endAlignment = const Alignment(1, 0);
  late Alignment align = startAlignment;
  late TextEditingController _textEditingControllerTop;
  late TextEditingController _textEditingControllerMain;

  late AnimationController animationController;
  late Animation<Alignment> animAlign;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    animAlign = AlignmentTween(begin: startAlignment, end: endAlignment)
        .animate(animationController);
    _textEditingControllerTop = TextEditingController();
    _textEditingControllerMain = TextEditingController();

    _textEditingControllerTop.text = "0";
    _textEditingControllerMain.text = "0";
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
    Size size = MediaQuery.of(context).size;
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
              padding: const EdgeInsets.only(right: 20,left: 20),
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
                      fontSize: 40,
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
                      fontSize: 80,
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
            calculationFun(index);
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

  calculationFun(int index) {
    if (_textEditingControllerMain.text.toString() == "0") {
      _textEditingControllerMain.text = "";
    }
    switch (symbols[index]) {
      case "0":
        {
          _textEditingControllerMain.text += symbols[index];
        }
        break;
      case "1":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "2":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "3":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "4":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "5":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "6":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "7":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "8":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "9":
        _textEditingControllerMain.text += symbols[index];
        break;
      case "C":
        _textEditingControllerMain.text = "0";
        break;
      case "⌫":
        {
          String temp = _textEditingControllerMain.text;
          if (temp.isNotEmpty) {
            temp = temp.substring(0, temp.length - 1);
          }
          if (temp.isEmpty) {
            temp = "0";
          }
          _textEditingControllerMain.text = temp;
        }
        break;
      case ".":
        {
          String temp = _textEditingControllerMain.text;
          if (!temp.contains(".")) {
            temp += ".";
          }
          _textEditingControllerMain.text = temp;
        }
        break;
    }
  }
}
