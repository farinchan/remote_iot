import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'voice_recognition_event.dart';
part 'voice_recognition_state.dart';

class VoiceRecognitionBloc
    extends Bloc<VoiceRecognitionEvent, VoiceRecognitionState> {
  String speechText = "";
  stt.SpeechToText speech = stt.SpeechToText();
  VoiceRecognitionBloc() : super(VoiceRecognitionInitial()) {
    on<InitVoiceRecognition>((event, emit) async {
      emit(VoiceRecognitionDataReceived());
    });

    on<StartVoiceRecognition>((event, emit) async {
      emit(VoiceRecognitionDataReceived(isListening: true));

      bool available = await speech.initialize(
        onStatus: (status) => log('onStatus: $status'),
        onError: (errorNotification) => {
          log('onError: $errorNotification'),
          emit(VoiceRecognitionError(errorNotification.errorMsg)),
        },
      );

      if (available) {
        speech.listen(
          onResult: (result) {
            // log('onResult: ${result.recognizedWords}');
            speechText = result.recognizedWords;
            emit(VoiceRecognitionDataReceived(
                isListening: true, text: result.recognizedWords));
          },
        );
      } else {
        log('The user has denied the use of speech recognition.');
        emit(VoiceRecognitionError(
            "The user has denied the use of speech recognition."));
      }
    });

    on<StopVoiceRecognition>((event, emit) async {
      await speech.stop();
      Future.delayed(Duration(milliseconds: 500));
      log('onStop: $speechText');
      emit(VoiceRecognitionDataReceived(isListening: false, text: speechText));
    });
  }
}
