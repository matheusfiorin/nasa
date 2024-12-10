import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/view/apod_detail/apod_list_viewmodel.dart';
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
  late final ApodDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ApodDetailViewModel(apod: widget.apod);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<ApodDetailViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: viewModel.isFullScreen
                ? null
                : AppBar(
              title: Text(viewModel.apod.title),
            ),
            body: ApodDetailContent(
              apod: viewModel.apod,
              isFullScreen: viewModel.isFullScreen,
              onToggleFullScreen: viewModel.toggleFullScreen,
            ),
          );
        },
      ),
    );
  }
}