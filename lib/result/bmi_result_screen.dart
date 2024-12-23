import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_bmi/models/infoitem.dart';
import 'package:calculator_bmi/sharing/color_const.dart';
import 'package:calculator_bmi/sharing/sharing.dart';
import 'package:calculator_bmi/theme/mode_theme.dart';

class BMIResultScreen extends StatelessWidget {
  final int result;
  final bool isMale;
  final int age;
  final int weight;
  final int height;

  const BMIResultScreen({
    Key? key,
    required this.age,
    required this.result,
    required this.isMale,
    required this.weight,
    required this.height,
  }) : super(key: key);

  String getBMICategory(int bmi) {
    if (bmi < 18.5) {
      return 'نقص في الوزن';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'وزن طبيعي';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'زيادة في الوزن';
    } else if (bmi >= 30 && bmi < 34.9) {
      return 'سمنة من الدرجة الأولى';
    } else if (bmi >= 35 && bmi < 39.9) {
      return 'سمنة من الدرجة الثانية';
    } else {
      return 'سمنة مفرطة (الدرجة الثالثة)';
    }
  }

  String getHealthAdvice(int bmi, int age, int weight) {
    if (age < 18) {
      if (bmi < 18.5) {
        return 'ينصح بزيادة تناول الطعام الصحي ومراجعة الطبيب للتأكد من عدم وجود مشاكل صحية.';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        return 'تتمتع بوزن صحي. استمر في اتباع نمط حياة صحي وممارسة الرياضة بانتظام.';
      } else {
        return 'ينصح باستشارة الطبيب ومراقبة الوزن.';
      }
    } else if (age >= 18 && age < 60) {
      if (bmi < 18.5) {
        return 'ينصح بزيادة تناول الطعام الصحي وممارسة الرياضة بانتظام.';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        return 'تتمتع بوزن صحي. استمر في اتباع نمط حياة صحي وممارسة الرياضة بانتظام.';
      } else if (bmi >= 25 && bmi < 29.9) {
        return 'ينصح باتباع نظام غذائي متوازن وممارسة الرياضة بانتظام.';
      } else {
        return 'ينصح باستشارة الطبيب واتباع نظام غذائي صحي وممارسة الرياضة.';
      }
    } else {
      if (bmi < 18.5) {
        return 'ينصح بزيادة تناول الطعام الصحي واستشارة الطبيب للحفاظ على الصحة.';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        return 'تتمتع بوزن صحي. استمر في اتباع نمط حياة صحي وممارسة الرياضة بانتظام.';
      } else {
        return 'ينصح باستشارة الطبيب لمراقبة الوزن والنظام الغذائي.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final bmiCategory = getBMICategory(result);
    final healthAdvice = getHealthAdvice(result, age, weight);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: const ShareButton(),
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
        backgroundColor: isDarkMode
            ? AppColors.kTextAndIconColor
            : AppColors.kscaffoldBackgroundColor,
        body: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  InfoCard(
                    isDarkMode: isDarkMode,
                    items: [
                      InfoItem('العمر', age.toString()),
                      InfoItem('الوزن', weight.toString()),
                      InfoItem('الطول', height.toString()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ResultCard(
                    isDarkMode: isDarkMode,
                    value: result.toString(),
                    label: bmiCategory,
                  ),
                  const SizedBox(height: 20),
                  AdviceCard(
                    isDarkMode: isDarkMode,
                    advice: healthAdvice,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final bool isDarkMode;
  final String value;
  final String label;

  const ResultCard({
    Key? key,
    required this.isDarkMode,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode
        ? AppColors.kTextAndIconColor
        : AppColors.kscaffoldBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdviceCard extends StatelessWidget {
  final bool isDarkMode;
  final String advice;

  const AdviceCard({
    Key? key,
    required this.isDarkMode,
    required this.advice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode
        ? AppColors.kTextAndIconColor
        : AppColors.kscaffoldBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'النصائح الصحية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                advice,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final bool isDarkMode;
  final List<InfoItem> items;

  const InfoCard({
    Key? key,
    required this.isDarkMode,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode
        ? AppColors.kTextAndIconColor
        : AppColors.kscaffoldBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
