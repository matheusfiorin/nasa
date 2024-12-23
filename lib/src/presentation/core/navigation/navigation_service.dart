import 'package:flutter/material.dart';

abstract class NavigationService {
  Future<T?> navigateTo<T>(
      BuildContext context,
      String route, {
        Object? arguments,
      });
}

class NavigationServiceImpl implements NavigationService {
  @override
  Future<T?> navigateTo<T>(
      BuildContext context,
      String route, {
        Object? arguments,
      }) {
    return Navigator.pushNamed(
      context,
      route,
      arguments: arguments,
    );
  }
}
