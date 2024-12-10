import 'package:flutter/foundation.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class ApodDetailViewModel extends ChangeNotifier {
  final Apod apod;

  ApodDetailViewModel({
    required this.apod,
  });

  bool _isFullScreen = false;
  bool get isFullScreen => _isFullScreen;

  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    notifyListeners();
  }
}