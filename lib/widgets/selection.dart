import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/option.dart';

class SingleSelect extends StatefulWidget {
  final List<CharacterOption> options;
  final ValueChanged<CharacterOption>? onSelected;

  const SingleSelect({super.key, required this.options, required this.onSelected});

  @override
  State<SingleSelect> createState() => _SingleSelectState();
}

class _SingleSelectState extends State<SingleSelect> {
  CharacterOption selectedOption = CharacterOption(id: 0, name: '', language: '');
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.options.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          crossAxisCount: 3,
          childAspectRatio: 82 / (32),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.onSelected!(widget.options[index]);
              setState(() {
                selectedOption = widget.options[index];
              });
/*                                           player.stop();
                                          demotts(voices[index], pitch, _speed); */
            },
            child: Card(
              surfaceTintColor: Colors.white,

              // Check if the index is equal to the selected Card integer
              color: widget.options[index].name == selectedOption.name ? Theme.of(context).primaryColor : Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: widget.options[index].name == selectedOption.name ? Theme.of(context).primaryColor : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                height: 35,
                width: 82,
                child: Center(
                  child: Text(
                    widget.options[index].title ?? widget.options[index].name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: selectedOption.name == widget.options[index].name ? Colors.white : Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class MultiSelect extends StatefulWidget {
  final List<CharacterOption> options;
  final ValueChanged<List<CharacterOption>> onSelected;
  final List<CharacterOption>? selectedOptions;

  const MultiSelect({super.key, required this.options, required this.onSelected, this.selectedOptions});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<CharacterOption> selectedOption = [];

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOptions ?? [];
  }

  bool isSelected(CharacterOption option) {
    for (var item in selectedOption) {
      if (item.name == option.name) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.options.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          crossAxisCount: 3,
          childAspectRatio: 82 / (32),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (isSelected(widget.options[index])) {
                selectedOption.remove(widget.options[index]);
              } else {
                selectedOption.add(widget.options[index]);
              }
              widget.onSelected(selectedOption);
              setState(() {});
/*                                           player.stop();
                                          demotts(voices[index], pitch, _speed); */
            },
            child: Card(
              surfaceTintColor: Colors.white,

              // Check if id of the index is in the selected list
              color: isSelected(widget.options[index]) ? Theme.of(context).primaryColor : Colors.white,
              /*    color: ? Theme.of(context).primaryColor : Colors.white, */
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: selectedOption.contains(widget.options[index]) ? Theme.of(context).primaryColor : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                height: 35,
                width: 82,
                child: Center(
                  child: Text(
                    widget.options[index].name,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: selectedOption.contains(widget.options[index]) ? Colors.white : Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class MultiImageSelect extends StatefulWidget {
  final List<CharacterOption> options;
  final ValueChanged<List<CharacterOption>> onSelected;
  final List<CharacterOption>? selectedOptions;
  final double? aspectRatio;
  final String? title;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;

  const MultiImageSelect(
      {super.key,
      required this.options,
      required this.onSelected,
      this.selectedOptions,
      this.aspectRatio,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.title});

  @override
  State<MultiImageSelect> createState() => _MultiMultiImageSelect();
}

class _MultiMultiImageSelect extends State<MultiImageSelect> {
  List<CharacterOption> selectedOption = [];

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOptions ?? [];
  }

  bool isSelected(CharacterOption option) {
    for (var item in selectedOption) {
      if (item.name == option.name) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: widget.mainAxisSpacing ?? 0,
          crossAxisSpacing: widget.crossAxisSpacing ?? 0,
          crossAxisCount: 2,
          childAspectRatio: widget.aspectRatio ?? 213 / (111),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (isSelected(widget.options[index])) {
                selectedOption.remove(widget.options[index]);
              } else {
                selectedOption.add(widget.options[index]);
              }
              widget.onSelected(selectedOption);
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                image: DecorationImage(image: CachedNetworkImageProvider(widget.options[index].image ?? ''), fit: BoxFit.cover),
                border: Border.all(
                  width: 1,
                  color: isSelected(widget.options[index])
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).inputDecorationTheme.border!.borderSide.color,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected(widget.options[index]) ? Theme.of(context).primaryColor : Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.options[index].name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class SingleImageSelect extends StatefulWidget {
  final List<CharacterOption> options;
  final ValueChanged<CharacterOption> onSelected;
  final CharacterOption? selectedOptions;
  final double? aspectRatio;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;

  const SingleImageSelect(
      {super.key,
      required this.options,
      required this.onSelected,
      this.selectedOptions,
      this.aspectRatio,
      this.mainAxisSpacing,
      this.crossAxisSpacing});

  @override
  State<SingleImageSelect> createState() => _SingleImageSelect();
}

class _SingleImageSelect extends State<SingleImageSelect> {
  CharacterOption selectedOption = CharacterOption(id: -1, name: '', language: '');

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOptions ?? CharacterOption(id: -1, name: '', language: '');
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: widget.mainAxisSpacing ?? 0,
          crossAxisSpacing: widget.crossAxisSpacing ?? 0,
          crossAxisCount: 2,
          childAspectRatio: widget.aspectRatio ?? 213 / (111),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.onSelected!(widget.options[index]);
              setState(
                () {
                  selectedOption = widget.options[index];
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                image: DecorationImage(image: CachedNetworkImageProvider(widget.options[index].image ?? ''), fit: BoxFit.cover),
                border: Border.all(
                  width: 1,
                  color: widget.options[index].name == selectedOption.name
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).inputDecorationTheme.border!.borderSide.color,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.options[index].name == selectedOption.name ? Theme.of(context).primaryColor : Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.options[index].name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
