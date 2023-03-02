import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CriteriaWidget extends StatefulWidget {
  CriteriaWidget({
    Key? key,
    required this.limitController,
    required this.gradeController,
    required this.distributionController,
    required this.index,
  }) : super(key: key);

  List<TextEditingController> limitController;
  List<TextEditingController> gradeController;
  List<TextEditingController> distributionController;
  int index;
  @override
  State<CriteriaWidget> createState() => _CriteriaWidgetState();
}

class _CriteriaWidgetState extends State<CriteriaWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (bool? value) {
                setState(() {
                  widget.distributionController[widget.index].text = value.toString();
                });
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: widget.limitController[widget.index],
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
                controller: widget.gradeController[widget.index],
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Credit Hours',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}