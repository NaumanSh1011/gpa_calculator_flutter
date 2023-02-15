import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CourseUnit extends StatefulWidget {
  const CourseUnit({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  State<CourseUnit> createState() => _CourseUnitState();
}

class _CourseUnitState extends State<CourseUnit> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.index + 1}'),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Course Mark',
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
      ],
    );
  }
}
