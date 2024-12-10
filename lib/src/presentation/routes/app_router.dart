import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/view/apod_detail/apod_list_view.dart';
import 'package:nasa/src/presentation/view/apod_list/apod_list_view.dart';

class AppRouter {
  static const String initial = '/';
  static const String detail = '/detail';

  static final _apodListView = MaterialPageRoute(
    builder: (_) => const ApodListView(),
  );

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return _apodListView;
      case detail:
        final apod = settings.arguments as Apod;
        return MaterialPageRoute(
          builder: (_) => ApodDetailView(apod: apod),
        );
      default:
        return _apodListView;
    }
  }
}
