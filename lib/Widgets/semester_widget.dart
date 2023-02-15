import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class SemesterWidget extends StatefulWidget {
  SemesterWidget({
    Key? key,
    required this.semesterController,
    required this.creditController,
    required this.index,
  }) : super(key: key);

  List<TextEditingController> semesterController;
  List<TextEditingController> creditController;
  int index;

  @override
  State<SemesterWidget> createState() => _SemesterWidgetState();
}

class _SemesterWidgetState extends State<SemesterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.index + 1}'),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.semesterController[widget.index],
            onEditingComplete: () {
              if (widget.semesterController[widget.index].text.isEmpty) {
                widget.semesterController[widget.index].text = '';
              }
            },
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
            controller: widget.creditController[widget.index],
            onEditingComplete: () {
              if (widget.creditController[widget.index].text.isEmpty) {
                widget.creditController[widget.index].text = '';
              }
            },
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
          onPressed: () async {
            var results = await Navigator.pushNamed(context, '/calculator', arguments: {
              'totalSemester': widget.semesterController.length,
              'currentSemester': widget.index + 1,
            });
            if (results != null) {
              Map data = results as Map;
              widget.semesterController[widget.index].text = data['gpa'];
              widget.creditController[widget.index].text = data['credit'];
            }
          },
          child: const Text("Calculate"),
        ),
      ],
    );
  }
}