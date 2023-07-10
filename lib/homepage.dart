import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Qbloc/question_cubit.dart';
import 'Qbloc/question_state.dart';
import 'listdata.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show fix size List')),
      body: BlocBuilder<QuestionCubit, QuestionState>(
        builder: (context, state) {
          if (state is QuestionInitial) {
            debugPrint('intial state');

            // Handle the initial state
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuestionLoading) {
            debugPrint('loading state');
            // Handle the loading state
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is onQuestionLoaded) {
            debugPrint('data Loaded state');
            // Handle the loaded state
            final dataList = state.question;
            return ListData(dataList: dataList);
          } else if (state is QuestionError) {
            // Handle the error state
            final error = state.error;
            debugPrint('error--> $error');
          }
          return Container();
        },
      ),
    );
  }
}
