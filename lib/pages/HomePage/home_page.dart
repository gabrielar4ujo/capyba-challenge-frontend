import 'package:capyba_challenge_frontend/services/event_service.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final EventService _eventService = Provider.of<EventService>(context);
    return CustomStreamBuilder(service: _eventService.getPublicEvents);
  }
}
