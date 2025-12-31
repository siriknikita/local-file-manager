import 'package:flutter/material.dart';

import '../../domain/entities/storage_info.dart';

/// Widget for displaying storage information.
///
/// Shows total, used, and free storage space with a visual indicator.
class StorageInfoCard extends StatelessWidget {
  /// Creates a new [StorageInfoCard] instance.
  ///
  /// [storageInfo] The storage information to display.
  const StorageInfoCard({
    required this.storageInfo,
    super.key,
  });

  /// The storage information to display.
  final StorageInfo storageInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: storageInfo.usedPercentage,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Used: ${storageInfo.usedGB.toStringAsFixed(2)} GB'),
                Text('Free: ${storageInfo.freeGB.toStringAsFixed(2)} GB'),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Total: ${storageInfo.totalGB.toStringAsFixed(2)} GB',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

