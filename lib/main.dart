import 'package:flutter/material.dart';
import 'package:smartnote/utils/service/config.dart';

import 'utils/service/app_controller.dart';

void main() {
  runApp(AppController(
    config: betaServer,
  ));
}
