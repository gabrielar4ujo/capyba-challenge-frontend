import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/models/event_model.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final Event event;
  const CustomExpansionTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _lightGray = Color(AppColors.get("lightGray"));
    final Color _darkBlue = Color(AppColors.get("darkBlue"));
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ExpansionTile(
        backgroundColor: _darkBlue,
        collapsedBackgroundColor: _darkBlue,
        collapsedTextColor: _lightGray,
        collapsedIconColor: _lightGray,
        iconColor: _lightGray,
        textColor: _lightGray,
        title: Text(event.name),
        subtitle: Text(
          event.owner,
          style: const TextStyle(fontSize: 12),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              'Sobre o evento:\n\n${event.about}\n',
              style: TextStyle(color: _lightGray, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
