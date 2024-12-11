import 'package:flutter/foundation.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class ApodDetailController extends ChangeNotifier {
  final Apod apod;

  ApodDetailController({
    required this.apod,
  });

  bool _isFullScreen = false;
  bool get isFullScreen => _isFullScreen;

  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    notifyListeners();
  }
}