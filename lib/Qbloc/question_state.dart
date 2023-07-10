// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';

import '../repositories/question_model.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionStatus {
  QuestionStatus();

  static var initial = QuestionInitial();
  static var loading = QuestionLoading();
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class onQuestionLoaded extends QuestionState {
  final List<QuestionModel> question;

  const onQuestionLoaded(this.question);

  @override
  List<Object> get props => [question];
}

class QuestionError extends QuestionState {
  final dynamic error;

  const QuestionError(this.error);

  @override
  List<Object> get props => [error];
}
