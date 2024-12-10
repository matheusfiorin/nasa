import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import '../../../routes/app_router.dart';

class ApodListItem extends StatelessWidget {
  final Apod apod;

  const ApodListItem({
    super.key,
    required this.apod,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: 56,
            height: 56,
            child: CachedNetworkImage(
              imageUrl: apod.url,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        title: Text(
          apod.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(apod.date),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouter.detail,
            arguments: apod,
          );
        },
      ),
    );
  }
}
