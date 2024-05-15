import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

void alertdialog(BuildContext context, Widget title, Widget content, Function() onTapyes) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('No', style: KTextTheme.darkTextTheme.labelLarge,)),
          TextButton(onPressed: onTapyes, child: Text('Yes', style: KTextTheme.darkTextTheme.labelLarge))
        ],
        backgroundColor: darkbgColor,
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 8),
      );
    },
  );
}
