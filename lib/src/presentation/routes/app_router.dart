import 'package:flutter/material.dart';
import 'package:nasa/src/presentation/view/apod_list/apod_list_view.dart';

class AppRouter {
  static const String initial = '/';
  static const String detail = '/detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    const w = Material(child: Center(child: Text('Placeholder')));
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          builder: (_) => const ApodListView(),
        );
      case detail:
        return MaterialPageRoute(
          builder: (_) => w,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => w,
        );
    }
  }
}
