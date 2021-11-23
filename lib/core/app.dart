import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/core/provider/data/auth.dart';
import 'package:smartnote/core/screen/common/auth/login.dart';
import 'package:smartnote/utils/service/smartnote_api.dart';
import 'package:smartnote/utils/theme/theme.dart';

class App extends StatelessWidget {
  App(this.api);
  final SmartNoteApi api;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth(api)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "SmartNote",
          theme: CustomTheme.lightTheme,
          home: Login(),
        ));
  }
}
