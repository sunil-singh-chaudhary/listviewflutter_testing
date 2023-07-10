// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listviewflutter_testing/services/service_locator.dart';

import '../repositories/question_model.dart';
import 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionStatus.initial);

  void fetchQuestionsWebSocket() async {
    try {
      emit(QuestionStatus.loading);

      List jsonData = await apicall.fetchData();
      // debugPrint('data- $jsonData');
      var mappinjson = jsonData.map((e) => QuestionModel.fromJson(e)).toList();

      try {
        // final question = QuestionModel.fromJson(jsonData);
        emit(onQuestionLoaded(mappinjson));
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
      // Emit a new state with the updated list
    } catch (e) {
      emit(QuestionError(e.toString()));
    }
  }

  void stopFetchingQuestions() {
    // eventSource!.close();
  }
}
