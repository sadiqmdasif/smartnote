import 'package:flutter/material.dart';
import 'package:smartnote/core/app.dart';
import 'package:smartnote/core/models/config.dart';
import 'package:smartnote/utils/service/smartnote_api.dart';

class AppController extends StatefulWidget {
  AppController({required this.config});

  final Config config;
  @override
  _AppController createState() => _AppController(config);
}

class _AppController extends State<AppController> {
  _AppController(config)
      : api = SmartNoteApi(config: config),
        _config = config;

  SmartNoteApi api;
  Config _config;
  Key key = UniqueKey();
  var initialized = false;
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: App(api),
    );
  }
}
