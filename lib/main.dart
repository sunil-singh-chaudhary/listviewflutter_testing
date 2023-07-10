import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listviewflutter_testing/homepage.dart';
import 'package:listviewflutter_testing/services/route_generator.dart';
import 'package:listviewflutter_testing/services/service_locator.dart';
import 'package:provider/provider.dart';

import 'Qbloc/question_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.amber,
            centerTitle: true,
            elevation: 10,
            shadowColor: Colors.black,
          )),
      initialRoute: '/',
      home: MultiBlocProvider(
        providers: [
          Provider<QuestionCubit>(
            create: (_) => QuestionCubit()..fetchQuestionsWebSocket(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
