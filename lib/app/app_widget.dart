import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(
          primary: Colors.yellow[900],
          secondary: Colors.yellow[900],
        ),
      ),
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.yellow[900],
          secondary: Colors.yellow[900],
        ),
      ),
      initialRoute: '/',
      home: HomePage(),
    );
  }
}
