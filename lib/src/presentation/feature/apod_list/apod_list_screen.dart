import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/core/di/injection_container.dart';

class ApodListScreen extends StatefulWidget {
  const ApodListScreen({super.key});

  @override
  State<ApodListScreen> createState() => _ApodListScreenState();
}

class _ApodListScreenState extends State<ApodListScreen> {
  late final ApodListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = sl<ApodListController>();
    _controller.loadApods();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ChangeNotifierProvider.value(
        value: _controller,
        child: Consumer<ApodListController>(
          builder: (context, controller, child) {
            if (controller.state.isLoading && controller.state.apods.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.state.error.isNotEmpty &&
                controller.state.apods.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.state.error),
                    ElevatedButton(
                      onPressed: controller.loadApods,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: controller.refresh,
                child: ListView.builder(
                  controller: _controller.scrollController,
                  itemCount: controller.state.apods.length,
                  itemBuilder: (context, index) {
                    final apod = controller.state.apods[index];
                    return ListTile(
                      title: Text(apod.title),
                      subtitle: Text(apod.date.toString()),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
