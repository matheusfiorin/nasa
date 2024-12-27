import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.padding,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemsPerRow = width >= 1200
        ? 4
        : width >= 900
            ? 3
            : width >= 600
                ? 2
                : 1;

    return ListView.builder(
      key: const Key('responsive_grid'),
      controller: scrollController,
      padding: padding,
      itemCount: (children.length / itemsPerRow).ceil(),
      itemBuilder: (context, index) {
        final startIndex = index * itemsPerRow;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < itemsPerRow; i++)
              if (startIndex + i < children.length)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: children[startIndex + i],
                  ),
                )
              else
                const Expanded(child: SizedBox())
          ],
        );
      },
    );
  }
}
