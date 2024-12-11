import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/widgets/apod_media_widget.dart';

class ApodDetailContent extends StatelessWidget {
  final Apod apod;
  final bool isFullScreen;
  final VoidCallback onToggleFullScreen;

  const ApodDetailContent({
    super.key,
    required this.apod,
    required this.isFullScreen,
    required this.onToggleFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ApodMediaWidget(
              apod: apod,
              isFullScreen: isFullScreen,
              onToggleFullScreen: onToggleFullScreen,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apod.title,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  apod.date,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  apod.explanation,
                  style: theme.textTheme.bodyMedium,
                ),
                if (apod.copyright != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    '© ${apod.copyright}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
