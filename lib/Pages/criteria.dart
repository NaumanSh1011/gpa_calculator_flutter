import 'package:flutter/material.dart';

class Criteria extends StatefulWidget {
  const Criteria({Key? key}) : super(key: key);

  @override
  State<Criteria> createState() => _CriteriaState();
}

class _CriteriaState extends State<Criteria> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Criteria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count = 0;
                });
              },
              child: const Text('Clear'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  return ListTile(
                    enabled: false,
                    onTap: () {},
                    title: const Text('Placeholder'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
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
