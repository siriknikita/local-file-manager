import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/file_browser_provider.dart';
import '../providers/search_provider.dart';

/// Widget for the search bar.
///
/// Allows users to search for files by name.
class SearchBar extends ConsumerStatefulWidget {
  /// Creates a new [SearchBar] instance.
  const SearchBar({super.key});

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
      });
      ref.read(searchProvider.notifier).clearSearch();
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final String rootPath = ref.read(fileBrowserProvider).currentPath;
    ref.read(searchProvider.notifier).search(query, rootPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search files...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }
}

