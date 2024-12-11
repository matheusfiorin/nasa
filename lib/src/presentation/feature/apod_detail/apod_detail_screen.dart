import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/controller/apod_detail_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/apod_detail_content.dart';

class ApodDetailScreen extends StatefulWidget {
  final Apod apod;
  final ApodDetailController? controller;

  const ApodDetailScreen({
    super.key,
    required this.apod,
    this.controller,
  });

  @override
  State<ApodDetailScreen> createState() => _ApodDetailScreenState();
}

class _ApodDetailScreenState extends State<ApodDetailScreen>
    with SingleTickerProviderStateMixin {
  late final ApodDetailController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _appBarAnimation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ApodDetailController(apod: widget.apod);
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _appBarAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _controller.addListener(_handleFullScreenChange);
  }

  void _handleFullScreenChange() {
    if (_controller.isFullScreen) {
      _animationController.forward();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      _animationController.reverse();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.removeListener(_handleFullScreenChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<ApodDetailController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            extendBodyBehindAppBar: true,
            appBar: controller.isFullScreen
                ? null
                : AppBar(
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness:
                          theme.brightness == Brightness.light
                              ? Brightness.dark
                              : Brightness.light,
                      statusBarBrightness: theme.brightness == Brightness.light
                          ? Brightness.light
                          : Brightness.dark,
                    ),
                    leading: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    title: FadeTransition(
                      opacity: _appBarAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          controller.apod.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
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
