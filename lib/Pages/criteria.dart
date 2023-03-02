import 'package:flutter/material.dart';
import 'package:gpa_calculator/Classes/criteria_unit.dart';
import 'package:gpa_calculator/Widgets/criteria_widget.dart';

class Criteria extends StatefulWidget {
  const Criteria({Key? key}) : super(key: key);

  @override
  State<Criteria> createState() => _CriteriaState();
}

class _CriteriaState extends State<Criteria> {
  List<CriteriaUnit> criteria = [];

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if(criteria.isEmpty) {
                    criteria.add(CriteriaUnit(lowerLimit: 85, gradePoints: 4.0, isDistributed: false));
                  }
                  else if(criteria.length == 1){
                    criteria.add(CriteriaUnit(lowerLimit: 80, gradePoints: 3.7, isDistributed: false));
                  }
                });
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
