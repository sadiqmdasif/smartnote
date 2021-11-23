import 'package:flutter/material.dart';
import 'package:smartnote/core/screen/common/auth/login.dart';
import 'package:smartnote/utils/service/config.dart';
import 'package:smartnote/utils/theme/theme.dart';

import 'utils/service/app_controller.dart';

void main() {
  runApp(AppController(
    config: betaServer,
  ));
}
