import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';

class ProfileScreen extends ConsumerWidget {
  static const route = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    final authState = ref.watch(authProvider);

    final verified =
        authState is Authenticated && authState.info.user?.isVerified == true;

    return LegendRouteBody(
      maxContentWidth: 600,
      builder: (context, s) {
        if (authState is! Authenticated) {
          return const LegendText("Not logged in");
        }
        return ElevatedCard(
          margin: const EdgeInsets.only(top: 120),
          border: Border.all(color: theme.colors.primary, width: 0.5),
          elevation: 0,
          background: theme.colors.background2,
          borderRadius: theme.sizing.radius2.asRadius(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LegendText(
                "Profile",
                style: theme.typography.h4,
                color: theme.colors.primary,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LegendText(
                    "Email",
                    style: theme.typography.h2,
                  ),
                  LegendText(
                    authState.info.user?.email,
                    style: theme.typography.h1,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LegendText(
                    "Verified",
                    style: theme.typography.h2,
                  ),
                  Icon(
                    verified ? Icons.check : Icons.close,
                    color: verified ? Colors.green : Colors.red,
                  )
                ],
              ),
              const SizedBox(height: 48),
              DynamicRow(
                vSpacing: 24,
                children: [
                  if (!verified)
                    LegendButton(
                      background: theme.colors.secondary,
                      height: 48,
                      width: 120,
                      borderRadius: BorderRadius.circular(12),
                      margin: const EdgeInsets.only(right: 16),
                      text: LegendText(
                        "Verify Email",
                        color: theme.colors.primary,
                        selectable: false,
                      ),
                      onTap: () {
                        Logger.log("TODO: Verify email");
                      },
                    ),
                  LegendButton(
                    background: theme.colors.secondary,
                    height: 48,
                    width: 120,
                    borderRadius: BorderRadius.circular(12),
                    text: LegendText(
                      "Logout",
                      color: theme.colors.primary,
                      selectable: false,
                    ),
                    onTap: () => ref.read(authProvider.notifier).logout().then(
                      (success) {
                        if (success) context.legendRouter.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  LegendButton(
                    background: theme.colors.error,
                    height: 48,
                    width: 120,
                    borderRadius: BorderRadius.circular(12),
                    text: LegendText(
                      "Delete",
                      color: theme.colors.error.lighten(0.5),
                      selectable: false,
                    ),
                    onTap: () {
                      Logger.log("TODO: Delete account");
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
