import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController lowerLimitController = TextEditingController(text: "");
  TextEditingController gradePointController = TextEditingController(text: "");
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode1.unfocus();
    focusNode2.unfocus();
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
              child: Container(
                color: Colors.grey[300],
                child: ListView.builder(
                  itemCount: criteria.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: ListTile(
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
                        ),
                      ),
                    );
                  },
                ),
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
                        focusNode: focusNode1,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Lower Limit',
                        ),
                        controller: lowerLimitController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      TextField(
                        focusNode: focusNode2,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Grade Point',
                        ),
                        controller: gradePointController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
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
                                  lowerLimitController.text = "";
                                  gradePointController.text = "";
                                  // Check which text field is currently focused
                                  if (focusNode1.hasFocus) {
                                    // Remove the focus from the first text field
                                    focusNode1.unfocus();
                                  } else if (focusNode2.hasFocus) {
                                    // Remove the focus from the second text field
                                    focusNode2.unfocus();
                                  }
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
