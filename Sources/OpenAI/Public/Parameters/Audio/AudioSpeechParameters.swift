//
//  AudioSpeechParameters.swift
//
//
//  Created by James Rochabrun on 11/14/23.
//

import Foundation

/// [Generates audio from the input text.](https://platform.openai.com/docs/api-reference/audio/createSpeech)
public struct AudioSpeechParameters: Encodable {
   
   /// One of the available [TTS models](https://platform.openai.com/docs/models/tts): tts-1 or tts-1-hd
   let model: String
   /// The text to generate audio for. The maximum length is 4096 characters.
   let input: String
   /// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer. Previews of the voices are available in the [Text to speech guide.](https://platform.openai.com/docs/guides/text-to-speech/voice-options)
   let voice: String
   /// Defaults to mp3, The format to audio in. Supported formats are mp3, opus, aac, and flac.
   let responseFormat: String?
   /// Control the voice of your generated audio with additional instructions. Does not work with tts-1 or tts-1-hd
   let instructions: String?
   /// Defaults to 1,  The speed of the generated audio. Select a value from 0.25 to 4.0. 1.0 is the default.
   let speed: Double?
   
   public enum TTSModel: String {
      case tts1 = "tts-1"
      case tts1HD = "tts-1-hd"
      case gpt4oMiniTTS = "gpt-4o-mini-tts"
   }
   
   public enum Voice: String {
      case alloy
      case ballad
      case echo
      case fable
      case onyx
      case nova
      case shimmer
      case ash
      case coral
      case sage
      case verse
   }
   
   public enum ResponseFormat: String {
      case mp3
      case opus
      case aac
      case flac
      case wav
      case pcm
   }
   
   enum CodingKeys: String, CodingKey {
       case model
       case input
       case voice
       case instructions
       case responseFormat = "response_format"
       case speed
   }
   
   public init(
      model: TTSModel,
      input: String,
      voice: Voice,
      responseFormat: ResponseFormat? = nil,
      instructions: String? = nil,
      speed: Double? = nil)
   {
       self.model = model.rawValue
       self.input = input
       self.voice = voice.rawValue
       self.responseFormat = responseFormat?.rawValue
       self.instructions = instructions
       self.speed = speed
   }
}
