import 'package:flutter/material.dart';
import 'package:nasa/src/domain/entity/neo.dart';

class NeoListItem extends StatelessWidget {
  final Neo neo;

  const NeoListItem({super.key, required this.neo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(neo.name),
      subtitle:
          Text('Miss Distance: ${neo.closeApproachData.first.missDistance} km'),
      trailing: neo.isPotentiallyHazardous
          ? const Icon(Icons.warning, color: Colors.red)
          : const Icon(Icons.check_circle, color: Colors.green),
    );
  }
}
