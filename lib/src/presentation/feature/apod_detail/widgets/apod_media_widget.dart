import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/image_viewer_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodMediaWidget extends StatefulWidget {
  final Apod apod;
  final bool isFullScreen;
  final VoidCallback onToggleFullScreen;

  const ApodMediaWidget({
    super.key,
    required this.apod,
    required this.isFullScreen,
    required this.onToggleFullScreen,
  });

  @override
  State<ApodMediaWidget> createState() => _ApodMediaWidgetState();
}

class _ApodMediaWidgetState extends State<ApodMediaWidget> {
  YoutubePlayerController? _youtubeController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  String? _extractYoutubeId(String url) {
    // Handle both embed and regular YouTube URLs
    RegExp regExp = RegExp(
      r'(?:youtube\.com\/embed\/|youtube\.com\/watch\?v=|youtu\.be\/)([\w-]+)',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  void _initializePlayer() {
    if (widget.apod.mediaType == 'video') {
      final videoId = _extractYoutubeId(widget.apod.url);

      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            disableDragSeek: false,
            loop: false,
            enableCaption: true,
            useHybridComposition: true,
          ),
        );
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.apod.mediaType == 'video') {
      if (!_isInitialized || _youtubeController == null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Could not load video',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
        );
      }

      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: theme.colorScheme.primary,
        progressColors: ProgressBarColors(
          playedColor: theme.colorScheme.primary,
          handleColor: theme.colorScheme.primary,
          bufferedColor: theme.colorScheme.primaryContainer,
          backgroundColor: theme.colorScheme.surfaceVariant,
        ),
        onReady: () {
          debugPrint('Player is ready.');
        },
      );
    }

    // Image handling remains the same
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageViewerScreen(
              imageUrl: widget.apod.url,
              heroTag: widget.apod.url,
            ),
          ),
        );
      },
      child: Hero(
        tag: widget.apod.url,
        child: CachedNetworkImage(
          imageUrl: widget.apod.url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Container(
            color: theme.colorScheme.errorContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: theme.colorScheme.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load image',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
