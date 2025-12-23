import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.context,
    required this.theme,
  });

  final BuildContext context;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Owned books: 10 \nDownloaded books: 6 \nRead books: 4',
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium?.copyWith(color: Theme.of(context).appBarTheme.foregroundColor),
      ),
    );
  }
}