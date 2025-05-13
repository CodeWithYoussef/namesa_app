import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: WidgetStateProperty.all(Theme.of(context).shadowColor),
      textStyle: WidgetStatePropertyAll(
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      ),
      leading: Icon(Icons.search),
      onTapOutside: (event) => FocusScope.of(context).unfocus,
      hintText: "See availability......",
      hintStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Color(0XFFFBFFFD),
          fontSize: 20,
        ),
      ),
    );
  }
}
