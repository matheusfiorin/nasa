import 'package:flutter/material.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:nasa/src/presentation/feature/neo_list/controller/neo_list_controller.dart';
import 'package:nasa/src/presentation/feature/neo_list/widgets/neo_list_item.dart';
import 'package:provider/provider.dart';

class NeoListScreen extends StatefulWidget {
  const NeoListScreen({super.key});

  @override
  State<NeoListScreen> createState() => _NeoListScreenState();
}

class _NeoListScreenState extends State<NeoListScreen> {
  late final NeoListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = sl<NeoListController>();
    _controller.loadNeos('2024-01-01', '2024-01-01');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Near Earth Objects'),
      ),
      body: ChangeNotifierProvider.value(
        value: _controller,
        child: Consumer<NeoListController>(
          builder: (context, controller, child) {
            if (controller.state.isLoading) {
              return const LoadingIndicator();
            } else if (controller.state.error.isNotEmpty) {
              return ErrorView(
                message: controller.state.error,
                onRetry: () {
                  controller.loadNeos('2024-01-01', '2024-01-01');
                },
              );
            } else {
              return ListView.builder(
                itemCount: controller.state.neos.length,
                itemBuilder: (context, index) {
                  final neo = controller.state.neos[index];
                  return NeoListItem(neo: neo);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
