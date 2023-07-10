import 'package:flutter/material.dart';
import 'package:listviewflutter_testing/homepage.dart';

class RouteGenerator {
  RouteGenerator();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      // case VideoEditorScreen.route:
      //   Map arguments = settings.arguments as Map;
      //   return MaterialPageRoute(
      //     builder: (_) => VideoEditorScreen(
      //       file: arguments['file'] as File,
      //       width: arguments['width'] as int?,
      //       height: arguments['height'] as int?,
      //     ),
      //   );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error 404'),
            backgroundColor: Theme.of(_).scaffoldBackgroundColor,
          ),
          body: const Center(
            child: Text('Something went wrong!'),
          ),
        );
      },
    );
  }
}
