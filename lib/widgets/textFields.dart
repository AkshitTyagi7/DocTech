import 'package:doctech/widgets/spaces.dart';
import 'package:doctech/widgets/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/option.dart';

// ignore: non_constant_identifier_names
Widget InputField(
    {required String lable,
    int? maxLines,
    int? minLines,
    TextEditingController? controller,
    bool? readOnly,
    Function()? onTap,
    int? maxLength,
    EdgeInsets? padding,
    TextAlign? textAlign,
    TextInputType? keyboardType = TextInputType.text,
    bool isNumber = false,
    ValueChanged<String>? onChanged}) {
  return TextField(
    textAlign: textAlign ?? TextAlign.start,
    controller: controller,
    keyboardType: keyboardType,
    onTap: onTap,
    onChanged: onChanged,
    readOnly: readOnly ?? false,
    maxLines: maxLines,
    maxLength: maxLength,
    inputFormatters: isNumber ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
    minLines: minLines,
    decoration: InputDecoration(
      contentPadding: padding,
      hintMaxLines: maxLines,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      hintStyle: const TextStyle(fontSize: 14),
      hintText: lable,
    ),
  );
}

class FunctionInputField extends StatefulWidget {
  final String lable;
  final String title;
  final int? maxLines;
  final int? minLines;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  const FunctionInputField(
      {super.key, required this.lable, this.maxLength, required this.controller, this.maxLines, this.minLines, this.onChanged, required this.title});
  @override
  State<FunctionInputField> createState() => _FunctionInputFieldState();
}

class _FunctionInputFieldState extends State<FunctionInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.title),
            Expanded(child: Container()),
            /* Copy to Clipboard iconbutton */
            IconButton(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.controller.text.validate()));
                },
                icon: const Icon(Icons.copy)),
            IconButton(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                onPressed: () async {
                  /* Translate the text in controller to device language*/
                  String translation = await getTranslatedText(text: widget.controller.text.validate(), target: 'en');
                  setState(() {
                    widget.controller.text = translation;
                  });
                },
                icon: const Icon(Icons.translate))
          ],
        ),
        smallSpace(),
        InputField(
            lable: widget.lable, controller: widget.controller, onChanged: widget.onChanged, maxLines: widget.maxLines, minLines: widget.minLines),
      ],
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final List<String> list;
  const DropdownMenuExample({super.key, required this.list});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class AppDropDown extends StatefulWidget {
  final List<CharacterOption> list;

  final ValueChanged<CharacterOption> onSelected;
  const AppDropDown({super.key, required this.list, required this.onSelected});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  String dropdownValue = '';
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list[0].name;
    widget.onSelected(widget.list[0]);
    list = widget.list.map((e) => e.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 40,
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onSelected(widget.list.firstWhere((element) => element.name == value));
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
    );
  }
}
