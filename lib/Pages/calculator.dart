import 'package:flutter/material.dart';
import 'package:gpa_calculator/Widgets/course_widget.dart';
import 'package:toast/toast.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double gpa = 0.0;
  bool isCalculated = false;
  int creditHours = 0;

  late List<TextEditingController> courseController;
  late List<TextEditingController> creditController;

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    courseController = List.generate(9, (
        index) => TextEditingController(), growable: false);
    creditController = List.generate(9, (index) =>
        TextEditingController(), growable: false);
  }
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    int total = data['totalSemester'];
    int current = data['currentSemester'];
    String buttonText;
    if (current == total) {
      buttonText = 'Finish';
    } else {
      buttonText = 'Next';
    }
    String gpaString = (gpa == 0.0 && !isCalculated)? "" : gpa.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator for Semester $current'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'GPA: $gpaString',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ListTile(
                      enabled: false,
                      onTap: () {},
                      title: CourseWidget(index: index, courseController: courseController, creditController: creditController),
                    );
                  }),
            ),

            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    isCalculated = true;
                    double gp = 0.0;
                    int credits = 0;
                    for(int i = 0; i < 9; i++){
                      if(courseController[i].text.isNotEmpty && creditController[i].text.isNotEmpty){
                        credits += int.parse(creditController[i].text);
                        gp += double.parse(courseController[i].text) * int.parse(creditController[i].text);
                      }
                      else if(courseController[i].text.isNotEmpty && creditController[i].text.isEmpty) {
                        Toast.show('Please enter credit hours for course ${i+1}', duration: Toast.lengthLong, gravity:  Toast.bottom);
                        isCalculated = false;
                        credits = 0;
                        break;
                      }
                      else if(courseController[i].text.isEmpty && creditController[i].text.isNotEmpty) {
                        Toast.show('Please enter course grade for course ${i+1}', duration: Toast.lengthLong, gravity:  Toast.bottom);
                        isCalculated = false;
                        credits = 0;
                        break;
                      }
                      else {
                        continue;
                      }
                    }
                    setState(() {
                      creditHours = credits;
                      if(credits > 0) {
                        gpa = gp / credits;
                      }
                      else {
                        gpa = 0.0;
                      }
                    });
                  },
                  child: const Text('Calculate'),
                ),
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: () {
                    if(isCalculated && creditHours > 0){
                      isCalculated = false;
                      Navigator.pop(context, {'gpa': gpaString, 'credit': creditHours.toString()});
                    }
                    else {
                      Toast.show('Please calculate GPA first', duration: Toast.lengthLong, gravity:  Toast.bottom);
                    }
                  },
                  child: Text(buttonText),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
