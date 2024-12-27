import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/apod_list_screen.dart';
import 'package:nasa/src/presentation/feature/apod_detail/apod_detail_screen.dart';
import 'package:nasa/src/presentation/feature/neo_list/neo_list_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String detail = '/detail';
  static const String neo = '/neo';

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
      case neo:
        return MaterialPageRoute(
          builder: (_) => const NeoListScreen(),
        );
      default:
        return _apodListView;
    }
  }
}
