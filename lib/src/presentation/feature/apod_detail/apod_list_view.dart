import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/controller/apod_list_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/apod_detail_content.dart';

class ApodDetailView extends StatefulWidget {
  final Apod apod;

  const ApodDetailView({
    super.key,
    required this.apod,
  });

  @override
  State<ApodDetailView> createState() => _ApodDetailViewState();
}

class _ApodDetailViewState extends State<ApodDetailView> {
  late final ApodDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ApodDetailController(apod: widget.apod);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<ApodDetailController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: controller.isFullScreen
                ? null
                : AppBar(
              title: Text(controller.apod.title),
            ),
            body: ApodDetailContent(
              apod: controller.apod,
              isFullScreen: controller.isFullScreen,
              onToggleFullScreen: controller.toggleFullScreen,
            ),
          );
        },
      ),
    );
  }
}