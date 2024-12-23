import 'dart:math';
import 'package:calculator_bmi/result/bmi_result_screen.dart';
import 'package:calculator_bmi/sharing/sharing.dart';
import 'package:calculator_bmi/theme/mode_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});
  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  bool isMale = false;
  double height = 120.0;
  int weight = 40;
  int age = 20;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading:  const ShareButton(),
          title: const Text(
            "صحة الجسم",
            style: TextStyle(),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<ThemeMode>(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : themeProvider.themeMode == ThemeMode.light
                        ? Icons.light_mode
                        : Icons.brightness_7_outlined,
              ),
              onSelected: (ThemeMode mode) {
                themeProvider.setThemeMode(mode);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: ThemeMode.light,
                  child: Text("فاتح"),
                ),
                const PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Text("داكن"),
                ),
                const PopupMenuItem(
                  value: ThemeMode.system,
                  child: Text("ثيم النظام"),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: !isMale ? const Color.fromARGB(255, 253, 253, 253) : const Color.fromARGB(255, 165, 176, 248),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('images/male.png'),
                                height: 75.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'ذكر',
                                style: TextStyle(fontSize: 25.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: !isMale ? const Color.fromARGB(255, 165, 176, 248) : const Color.fromARGB(255, 253, 253, 253),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('images/female.png'),
                                height: 75.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'أنثى',
                                style: TextStyle(fontSize: 25.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "الطول",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${height.round()}',
                            style: const TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5.5,
                          ),
                          const Text(
                            "سم",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        activeColor: const Color.fromARGB(255, 165, 176, 248),
                        value: height,
                        max: 220.0,
                        min: 80.0,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "العمر",
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              '$age',
                              style: const TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (age > 1) age--;
                                    });
                                  },
                                  heroTag: 'age-',
                                  mini: true,
                                  backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  heroTag: 'age+',
                                  mini: true,
                                  backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "الوزن",
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              '$weight',
                              style: const TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 1) weight--;
                                    });
                                  },
                                  heroTag: 'weight-',
                                  mini: true,
                                  backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  heroTag: 'weight+',
                                  mini: true,
                                  backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  double result = weight / pow(height / 100, 2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMIResultScreen(
                        isMale: isMale,
                        age: age,
                        result: result.round(),
                        weight: weight,
                        height: height.toInt(),
                      ),
                    ),
                  );
                },
                height: 60.0,
                child: const Text(
                  "احـــسب",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
