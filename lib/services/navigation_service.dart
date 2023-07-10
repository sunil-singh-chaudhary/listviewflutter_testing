import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String? getCurrentRoute() {
    return ModalRoute.of(navigatorKey.currentState!.context)?.settings.name;
  }

  Future<dynamic> pushScreen(
    String routeName, {
    dynamic arguments,
    bool makeHapticFeedback = false,
  }) {
    if (makeHapticFeedback) {
      HapticFeedback.selectionClick();
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void pushScreensAndReplaceFirst(
    List<String> routeNames, {
    required List<dynamic> arguments,
  }) {
    for (int i = 0; i < routeNames.length; i++) {
      if (i == 0) {
        pushReplacementScreen(routeNames[i], arguments: arguments[i]);
      }
      pushScreen(routeNames[i], arguments: arguments[i]);
    }
  }

  Future<dynamic> popAndPushScreen(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.pop();
    return pushScreen(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementScreen(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndPushReplacement(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.pop();
    return pushReplacementScreen(routeName, arguments: arguments);
  }

  Future<dynamic> removeAllAndPush(
    String routeName,
    String tillRoute, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(tillRoute),
      arguments: arguments,
    );
  }

  Future<dynamic> pushDialog(Widget dialog, {bool isDismissible = false}) {
    return Platform.isAndroid
        ? showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: isDismissible,
            builder: (BuildContext context) {
              return dialog;
            },
          )
        : showCupertinoDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: isDismissible,
            builder: (BuildContext context) {
              return dialog;
            },
          );
  }

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) =>
      ScaffoldMessenger.of(navigatorKey.currentContext!)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: duration,
            content: Text(message),
          ),
        );

  Future<void> pop({dynamic sendDataBack, bool changeColor = true}) async {
    return navigatorKey.currentState!.pop(sendDataBack);
  }
}
