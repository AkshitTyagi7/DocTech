import 'package:doctech/widgets/selection.dart';
import 'package:doctech/widgets/spaces.dart';
import 'package:doctech/widgets/textFields.dart';
import 'package:flutter/material.dart';

import '../models/option.dart';

class BottomSelection extends StatefulWidget {
  final List<CharacterOption> options;
  final ValueChanged<List<CharacterOption>>? onSelected;
  const BottomSelection({super.key, required this.options, required this.onSelected});

  @override
  State<BottomSelection> createState() => _BottomSelectionState();
}

class _BottomSelectionState extends State<BottomSelection> {
  List<CharacterOption> selectedOptions = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: InputField(
          lable: "Select",
          controller: TextEditingController(text: selectedOptions.map((e) => e.name).join(", ")),
          readOnly: true,
          onTap: openSelection),
    );
  }

  void openSelection() {
    OpenBottomSheet(context,
        title: "Select Personality",
        child: MultiSelect(
            options: widget.options,
            selectedOptions: selectedOptions,
            onSelected: (value) {
              widget.onSelected!(value);
              setState(() {
                selectedOptions = value;
              });
            }));
  }
}

// ignore: non_constant_identifier_names
void OpenBottomSheet(context, {required Widget child, double? height, String title = ""}) {
  showModalBottomSheet<void>(
    context: context,
    constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.75)),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  mediumSmallSpace(),
                  Container(
                    child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  smallSpace(),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  child,
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
