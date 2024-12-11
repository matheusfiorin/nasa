import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/controller/apod_detail_controller.dart';

void main() {
  late ApodDetailController controller;

  setUp(() {
    controller = ApodDetailController(
      apod: const Apod(
        copyright: 'copyright',
        date: 'date',
        explanation: 'explanation',
        mediaType: 'mediaType',
        title: 'title',
        url: 'url',
      ),
    );
  });

  group('ApodDetailController', () {
    test('Initial isFullScreen should be false', () {
      expect(controller.isFullScreen, false);
    });

    test('toggleFullScreen should toggle isFullScreen', () {
      controller.toggleFullScreen();
      expect(controller.isFullScreen, true);

      controller.toggleFullScreen();
      expect(controller.isFullScreen, false);
    });
  });
}
