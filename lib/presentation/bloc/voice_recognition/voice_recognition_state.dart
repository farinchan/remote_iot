part of 'voice_recognition_bloc.dart';

@immutable
sealed class VoiceRecognitionState {}

final class VoiceRecognitionInitial extends VoiceRecognitionState {}

final class VoiceRecognitionDataReceived extends VoiceRecognitionState {
  final bool isListening;
  final String text;

  VoiceRecognitionDataReceived({this.text = "", this.isListening = false});
}

final class VoiceRecognitionError extends VoiceRecognitionState {
  final String message;

  VoiceRecognitionError(this.message);
}
