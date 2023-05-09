import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:smart_chef_app/config/overrides/auth_route.dart';
import 'package:smart_chef_app/features/layout/appbar/appbar_menu_item.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';

class AppBarMenu extends ConsumerWidget {
  final List<RouteInfo> routes;
  final RouteInfo? route;

  const AppBarMenu({
    super.key,
    required this.routes,
    this.route,
  });

  List<Widget> get unauthenticatedMenu {
    return [];
  }

  List<Widget> get authenticatedMenu {
    return [];
  }

  @override
  Widget build(BuildContext context, ref) {
    final isAuthed = ref.watch(authProvider) is Authenticated;

    final _routes = isAuthed
        ? routes.whereType<AuthPageInfo>()
        : routes.whereType<PageInfo>().where((r) => r is! AuthPageInfo);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var route in _routes) ...[
            AppBarMenuItem(
              isActive: _isActive(route),
              onTap: () {
                context.legendRouter.pushPage(route.name);
              },
              title: route.title,
              icon: route.icon,
            ),
            if (_routes.last != route) const SizedBox(width: 16),
          ]
        ],
      ),
    );
  }

  bool _isActive(RouteInfo route) => route.name == this.route?.name;
}
