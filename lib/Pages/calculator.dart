import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
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
    double gpa = 0.0;
    int creditHours = 0;
    bool isCalculated = false;
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
                'GPA: ${gpa.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return ListTile(
                      enabled: false,
                      onTap: () {},
                      title: Text('Course ${index + 1}'),
                    );
                  }),
            ),

            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    isCalculated = true;
                  },
                  child: const Text('Calculate'),
                ),
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: () {
                    if(isCalculated && creditHours > 0){
                      isCalculated = false;
                      //Navigator.pushNamed(context, '/results');
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
