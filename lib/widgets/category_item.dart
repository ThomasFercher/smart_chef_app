import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Widget child;

  const CategoryItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
