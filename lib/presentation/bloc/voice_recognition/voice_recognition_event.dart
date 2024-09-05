part of 'voice_recognition_bloc.dart';

@immutable
sealed class VoiceRecognitionEvent {}

class InitVoiceRecognition extends VoiceRecognitionEvent {}

class StartVoiceRecognition extends VoiceRecognitionEvent {}

class StopVoiceRecognition extends VoiceRecognitionEvent {}


