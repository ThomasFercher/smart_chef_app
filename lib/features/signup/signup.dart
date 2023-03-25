import 'package:flutter/widgets.dart';
import 'package:legend_design_core/libraries/scaffold.dart';

class SignUpScreen extends StatelessWidget {
  static String route = "/signup";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LegendRouteBody(
      builder: (context, s) {
        return const Text("Sign Up");
      },
    );
  }
}
