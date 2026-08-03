import 'package:flutter/material.dart';

class AccountInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const AccountInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: Color(0xFF1A1A2E), size: 22),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(width: 6),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Color(0xFF7A7D8C),
          ),
        ],
      ),
    );
  }
}
