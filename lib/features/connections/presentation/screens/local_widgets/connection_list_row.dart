import 'package:flutter/material.dart';
import '../../../domain/entities/connection_entity.dart';

class ConnectionListRow extends StatelessWidget {
  const ConnectionListRow({
    super.key,
    required this.connection,
    required this.actionLabel,
    required this.actionColor,
    this.onActionTap,
  });

  final ConnectionEntity connection;
  final String actionLabel;
  final Color actionColor;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(connection.avatarUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(connection.name, style: textTheme.headlineSmall),
          ),
          OutlinedButton(
            onPressed: onActionTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: actionColor),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            child: Text(
              actionLabel,
              style: textTheme.labelMedium?.copyWith(color: actionColor),
            ),
          ),
        ],
      ),
    );
  }
}
