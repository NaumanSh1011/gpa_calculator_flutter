import 'package:flutter/material.dart';
import 'package:gpa_calculator/Classes/criteria_unit.dart';
import 'package:gpa_calculator/Widgets/criteria_widget.dart';
import 'dart:convert';

import 'package:toast/toast.dart';

class Criteria extends StatefulWidget {
  const Criteria({Key? key}) : super(key: key);

  @override
  State<Criteria> createState() => _CriteriaState();
}

class _CriteriaState extends State<Criteria> {
  List<CriteriaUnit> criteria = [];
  bool isDistribute = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController lowerLimitController = TextEditingController(text: "");
    TextEditingController gradePointController = TextEditingController(text: "");
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Criteria'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  criteria = [];
                });
              },
              child: const Text('Clear'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: criteria.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    enabled: false,
                    onTap: () {},
                    title: CriteriaWidget(
                      index: index,
                      gradeController: List.generate(
                        criteria.length,
                            (index) => TextEditingController(),
                        growable: true,
                      ),
                      limitController: List.generate(
                        criteria.length,
                            (index) => TextEditingController(),
                        growable: true,
                      ),
                      criteria: criteria,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          criteria.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    )
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Lower Limit',
                        ),
                        controller: lowerLimitController,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Grade Point',
                        ),
                        controller: gradePointController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Opacity(
                        opacity: criteria.isEmpty? 0:1,
                        child: CheckboxListTile(
                          value: isDistribute,
                          onChanged: (bool? value) {
                            setState(() {
                              isDistribute = value!;
                            });
                          },
                          title: const Text("Distribute?"),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if(lowerLimitController.text.isEmpty || gradePointController.text.isEmpty){
                                  Toast.show("Please enter both limit and grade inorder to insert", duration: Toast.lengthShort, gravity: Toast.bottom);
                                  return;
                                }
                                CriteriaUnit cu = CriteriaUnit(lowerLimit: int.parse(lowerLimitController.text), gradePoints: double.parse(gradePointController.text), isDistributed: isDistribute);

                                setState(() {
                                  isDistribute = false;
                                  criteria.add(cu);
                                });
                              },
                              child: const Text('Insert'),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(child: ElevatedButton(onPressed: () {
                            print(jsonEncode(criteria.map((criterion) => criterion.toJson()).toList()));
                          }, child: const Text("Save"))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
