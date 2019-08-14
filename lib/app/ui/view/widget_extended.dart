import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownC<T> extends StatefulWidget {
  final T selectedItem;
  final List<T> items;
  final DropdownMenuItem<T> Function(T item) map;
  final Widget hint;

  DropDownC({key, this.selectedItem, this.items, this.map, this.hint}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DropDownCState(selectedItem, items, map, hint);
}

class DropDownCState<T> extends State<DropDownC<T>> {
  T selectedItem;
  List<T> items;
  DropdownMenuItem<T> Function(T item) map;
  Widget hint;

  DropDownCState(this.selectedItem, this.items, this.map, this.hint);

  @override
  Widget build(BuildContext context) => DropdownButton(
        isExpanded: true,
        hint: hint,
        value: selectedItem,
        onChanged: (value) => setState(() {
          selectedItem = value;
        }),
        items: items.map(map).toList(),
      );
}
