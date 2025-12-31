import 'package:flutter/material.dart';

/// Widget for displaying breadcrumb navigation.
///
/// Shows the current path as a series of clickable breadcrumbs
/// allowing users to navigate back to parent directories.
class BreadcrumbNavigation extends StatelessWidget {
  /// Creates a new [BreadcrumbNavigation] instance.
  ///
  /// [currentPath] The current directory path.
  const BreadcrumbNavigation({
    required this.currentPath,
    super.key,
  });

  /// The current directory path.
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    if (currentPath.isEmpty || currentPath == '/') {
      return const SizedBox.shrink();
    }

    final List<String> parts = currentPath.split('/')
        .where((part) => part.isNotEmpty)
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // TODO: Navigate to parent directory
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBreadcrumbItem(context, 'Home', '/'),
                  ...parts.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String part = entry.value;
                    final String path = '/${parts.sublist(0, index + 1).join('/')}';
                    return _buildBreadcrumbItem(context, part, path);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single breadcrumb item.
  Widget _buildBreadcrumbItem(
    BuildContext context,
    String label,
    String path,
  ) {
    final bool isLast = path == currentPath;

    return GestureDetector(
      onTap: isLast
          ? null
          : () {
              // TODO: Navigate to path
            },
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
              color: isLast ? Colors.blue : Colors.grey,
            ),
          ),
          if (!isLast) const Text(' / '),
        ],
      ),
    );
  }
}

