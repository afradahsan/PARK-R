import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/home/searchresult.dart';
import 'package:parkr/presentation/screens/home/widgets/dropdownhome.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  bool onChanged = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SearchBar(
          controller: widget.controller,
          onChanged: (value) {
            onChanged = value.isNotEmpty;
            setState(() {});
          },
          onSubmitted: (value) {
            onChanged = false;
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SearchRes(searchQuery: widget.controller.text,);
            },));
          },
          padding: const MaterialStatePropertyAll(
              EdgeInsets.only(left: 12, right: 12, bottom: 0, top: 0)),
          backgroundColor: MaterialStateProperty.all(whitet50),
          trailing: [
            onChanged == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();
                        onChanged = false;
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      size: 15,
                      color: whitet150,
                    ))
                : sizedwfive(context)
          ],
          elevation: const MaterialStatePropertyAll(0),
          leading: Icon(
            Icons.search,
            color: whitet150,
          ),
          hintText: 'Search for a Location',
          textStyle:
              MaterialStatePropertyAll(KTextTheme.darkTextTheme.bodyMedium),
          hintStyle: MaterialStatePropertyAll(TextStyle(color: whitet150)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          constraints:
              BoxConstraints(minHeight: 47, maxWidth: screenW(context) - 120),
        ),
        sizedwten(context),
        DropDownhome()
      ],
    );
  }
}
