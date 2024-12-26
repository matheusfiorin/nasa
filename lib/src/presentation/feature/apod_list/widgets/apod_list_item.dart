import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa/src/presentation/core/navigation/navigation_service.dart';
import 'package:nasa/src/presentation/feature/apod_list/model/apod_ui_model.dart';

import '../../../routes/app_router.dart';

class ApodListItem extends StatelessWidget {
  final ApodUiModel apod;
  final NavigationService navigationService;

  const ApodListItem({
    super.key,
    required this.apod,
    required this.navigationService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: InkWell(
        onTap: () => navigationService.navigateTo(
          context,
          AppRouter.detail,
          arguments: apod.toEntity(),
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: _buildMediaPreview(),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      apod.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: _buildMetadata(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    return ClipRRect(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          CachedNetworkImage(
            imageUrl: apod.thumbnailUrl ?? apod.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const _LoadingPlaceholder(),
            errorWidget: (context, url, error) => const _ErrorPlaceholder(),
          ),
          if (apod.isVideo) const _VideoOverlay(),
        ],
      ),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final iconColor = theme.colorScheme.onSurfaceVariant;

    return DefaultTextStyle(
      style: textStyle!,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_outlined, size: 14, color: iconColor),
          const SizedBox(width: 4),
          Text(apod.date),
          const SizedBox(width: 12),
          Icon(
            apod.isVideo ? Icons.play_circle_outline : Icons.photo_outlined,
            size: 14,
            color: iconColor,
          ),
          const SizedBox(width: 4),
          Text(apod.mediaType.toUpperCase()),
        ],
      ),
    );
  }
}

class _MediaPreview extends StatelessWidget {
  final ApodUiModel apod;

  const _MediaPreview({required this.apod});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: apod.thumbnailUrl ?? apod.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const _LoadingPlaceholder(),
            errorWidget: (context, url, error) => const _ErrorPlaceholder(),
          ),
          if (apod.isVideo) const _VideoOverlay(),
        ],
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  final ApodUiModel apod;

  const _ItemInfo({required this.apod});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apod.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: null,
          ),
          const SizedBox(height: 8),
          _ItemMetadata(apod: apod),
        ],
      ),
    );
  }
}

class _ItemMetadata extends StatelessWidget {
  final ApodUiModel apod;

  const _ItemMetadata({required this.apod});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final iconColor = theme.colorScheme.onSurfaceVariant;

    return Row(
      children: [
        Icon(Icons.calendar_today_outlined, size: 14, color: iconColor),
        const SizedBox(width: 4),
        Text(apod.date, style: textStyle),
        const SizedBox(width: 12),
        Icon(
          apod.isVideo ? Icons.play_circle_outline : Icons.photo_outlined,
          size: 14,
          color: iconColor,
        ),
        const SizedBox(width: 4),
        Text(apod.mediaType.toUpperCase(), style: textStyle),
      ],
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      key: const Key('error-container'),
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 4),
          Text(
            'Error loading image',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _VideoOverlay extends StatelessWidget {
  const _VideoOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.white,
            size: 48,
          ),
        ),
      ),
    );
  }
}
