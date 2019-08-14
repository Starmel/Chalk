import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/ui/app_colors.dart';

class IssueSearch extends StatefulWidget {
  final Function(String) onSearchTap;

  IssueSearch({Key key, this.onSearchTap}) : super(key: key);

  @override
  _IssueSearchState createState() => _IssueSearchState();
}

class _IssueSearchState extends State<IssueSearch> {
  final _searchInputController = TextEditingController();

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        children: <Widget>[
          inputField(),
          searchButton(),
        ],
      ),
    );
  }

  Padding searchButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: RaisedButton(
        child: Text("Search"),
        onPressed: () {
          widget.onSearchTap(_searchInputController.text);
        },
      ),
    );
  }

  Expanded inputField() {
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: AppColors.border,
      ),
      borderRadius: BorderRadius.zero,
    );

    return Expanded(
      child: TextField(
        controller: _searchInputController,
        decoration: InputDecoration(
          hintText: "Task Id",
          fillColor: Colors.red,
          focusedBorder: inputBorder,
          contentPadding: EdgeInsets.all(8),
          border: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
        ),
      ),
    );
  }
}
