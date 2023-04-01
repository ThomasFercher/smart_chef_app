import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_widgets/datadisplay/avatar/legend_avatar.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/auth/signIn/signIn.dart';
import 'package:smart_chef_app/features/auth/signup/signup.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';
import 'package:smart_chef_app/widgets/themeSwitcher/themeSwitcher.dart';

class HomeScreenAppBarActions extends ConsumerWidget {
  const HomeScreenAppBarActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authProvider);
    final theme = LegendTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ThemeSwitcher(),
        const SizedBox(width: 8),
        if (authState is Authenticated)
          Container(
            color: Colors.red,
            width: 24,
            height: 24,
          ),
        if (authState is Unauthenticated) ...[
          LegendButton(
            background: theme.appBarColors.background,
            height: 56,
            width: 96,
            selBackground: theme.colors.secondary,
            borderRadius: theme.sizing.radius1.asRadius(),
            onTap: () {
              context.legendRouter.pushPage(SignInScreen.route);
            },
            text: Text(
              "Sign In",
              style: theme.typography.h1.copyWith(
                color: theme.colors.onSecondary,
              ),
            ),
          ),
          LegendButton(
            background: theme.appBarColors.background,
            height: 56,
            width: 96,
            selBackground: theme.colors.secondary,
            borderRadius: theme.sizing.radius1.asRadius(),
            onTap: () {
              context.legendRouter.pushPage(SignInScreen.route);
            },
            text: Text(
              "Sign In",
              style: theme.typography.h1.copyWith(
                color: theme.colors.onSecondary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          LegendButton(
            background: theme.colors.secondary,
            height: 56,
            width: 128,
            borderRadius: theme.sizing.radius1.asRadius(),
            selElevation: 2,
            onTap: () {
              context.legendRouter.pushPage(SignUpScreen.route);
            },
            selBackground: theme.colors.selection,
            text: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: theme.typography.h1.copyWith(
                    color: theme.colors.onSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  color: theme.colors.onSecondary,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
