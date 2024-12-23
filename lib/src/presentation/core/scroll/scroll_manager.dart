// lib/src/presentation/core/scroll/scroll_manager.dart
import 'dart:async';
import 'package:flutter/widgets.dart';

class ScrollManager {
  final ScrollController controller;
  final VoidCallback onLoadMore;
  final double threshold;
  final Duration debounceDuration;

  Timer? _scrollDebounce;
  bool _isDisposed = false;

  ScrollManager({
    required this.controller,
    required this.onLoadMore,
    this.threshold = 1000,
    this.debounceDuration = const Duration(milliseconds: 150),
  }) {
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollDebounce?.isActive ?? false) return;

    _scrollDebounce = Timer(debounceDuration, () {
      if (_isDisposed) return;

      if (controller.position.pixels >=
          controller.position.maxScrollExtent - threshold) {
        onLoadMore();
      }
    });
  }

  void dispose() {
    _isDisposed = true;
    _scrollDebounce?.cancel();
  }
}
