import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';

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
    return GestureDetector(
      onTap: onToggleFullScreen,
      child: isFullScreen ? _buildFullScreenImage() : _buildDetailView(context),
    );
  }

  Widget _buildFullScreenImage() {
    return CachedNetworkImage(
      imageUrl: apod.hdUrl ?? apod.url,
      fit: BoxFit.contain,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildDetailView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: apod.url,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      apod.date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (apod.copyright != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '© ${apod.copyright}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  apod.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  apod.explanation,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
