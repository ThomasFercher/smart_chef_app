import 'package:flutter/widgets.dart';

class GridItem extends StatelessWidget {
  final Widget child;

  const GridItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
