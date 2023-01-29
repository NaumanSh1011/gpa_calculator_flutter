import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final semesters = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  int placeholder = 0;
  late List<TextEditingController> semesterController;

  @override
  void initState() {
    super.initState();
    semesterController = List.generate(8, (index) => TextEditingController(), growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
        child: Column(
          children: [
            const Text(
              'Welcome to GPA Calculator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/semesters');
              },
              child: const Text('Define Grading Criteria'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Semesters: '),
                DropdownButton(
                  items: semesters.map((semester) {
                    return DropdownMenuItem(
                      value: semester,
                      child: Text("$semester"),
                    );
                  }).toList(),
                  onChanged: (semester){
                    setState(() {
                      placeholder = semester as int;
                    });
                  },
                  value: placeholder == 0 ? null : placeholder,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (placeholder == 0)
              const Expanded(
                child: Center(
                  child: Text('Please select the number of semesters'),
                ),
              ),
            if (placeholder != 0)
              Expanded(
                child: ListView.builder(
                  itemCount: placeholder,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: SemesterUnit(semesterController: semesterController, index: index),
                      enabled: false,
                      onTap: () {},
                    );
                  }
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (placeholder == 0) return;
                Navigator.pushNamed(context, '/results', arguments: {
                  'semesters': placeholder,
                  'semesterController': semesterController,
                });
              },
              child: const Text('Get Results'),
            ),
          ],
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class SemesterUnit extends StatefulWidget {
  int index;
  SemesterUnit({
    Key? key,
    required this.semesterController,
    required this.index,
  }) : super(key: key);

  final List<TextEditingController> semesterController;

  @override
  State<SemesterUnit> createState() => _SemesterUnitState();
}

class _SemesterUnitState extends State<SemesterUnit> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.index + 1}'),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.semesterController[widget.index],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Semester GPA',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Credit Hours',
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/calculator', arguments: {
              'semester': widget.index + 1,
            });
          },
          child: const Text("Calculate"),
        ),
      ],
    );
  }
}
