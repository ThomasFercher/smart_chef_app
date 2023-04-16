import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';

class BlogScreen extends StatelessWidget {
  static String route = "/blog";

  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegendRouteBody(
      builder: (context, s) {
        return Container();
      },
    );
  }
}
