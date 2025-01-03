import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/apod_list_screen.dart';
import 'package:nasa/src/presentation/feature/apod_detail/apod_detail_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String detail = '/detail';

  static final _apodListView = MaterialPageRoute(
    builder: (_) => const ApodListScreen(),
  );

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return _apodListView;
      case detail:
        final apod = settings.arguments as Apod;
        return MaterialPageRoute(
          builder: (_) => ApodDetailScreen(apod: apod),
        );
      default:
        return _apodListView;
    }
  }
}
