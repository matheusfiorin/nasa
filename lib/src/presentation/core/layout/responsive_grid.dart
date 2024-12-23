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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 1200
            ? 4
            : width >= 900
                ? 3
                : width >= 600
                    ? 2
                    : 1;

        return ListView.builder(
          controller: scrollController,
          padding: padding,
          itemCount: (children.length / crossAxisCount).ceil(),
          itemBuilder: (context, rowIndex) {
            final startIndex = rowIndex * crossAxisCount;
            final endIndex =
                (startIndex + crossAxisCount).clamp(0, children.length);
            final rowChildren = children.sublist(startIndex, endIndex);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < rowChildren.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: rowChildren[i],
                      ),
                    ),
                  for (int i = rowChildren.length; i < crossAxisCount; i++)
                    const Expanded(child: SizedBox()),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
