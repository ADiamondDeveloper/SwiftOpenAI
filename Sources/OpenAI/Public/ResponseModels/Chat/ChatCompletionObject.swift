//
//  ChatCompletionObject.swift
//
//
//  Created by James Rochabrun on 10/10/23.
//

import Foundation

/// Represents a chat [completion](https://platform.openai.com/docs/api-reference/chat/object) response returned by model, based on the provided input.
public struct ChatCompletionObject: Decodable {
   
   /// A unique identifier for the chat completion.
   public let id: String?
   /// A list of chat completion choices. Can be more than one if n is greater than 1.
   public let choices: [ChatChoice]?
   /// The Unix timestamp (in seconds) of when the chat completion was created.
   public let created: Int?
   /// The model used for the chat completion.
   public let model: String?
   /// The service tier used for processing the request. This field is only included if the service_tier parameter is specified in the request.
   public let serviceTier: String?
   /// This fingerprint represents the backend configuration that the model runs with.
   /// Can be used in conjunction with the seed request parameter to understand when backend changes have been made that might impact determinism.
   public let systemFingerprint: String?
   /// The object type, which is always chat.completion.
   public let object: String?
   /// Usage statistics for the completion request.
   public let usage: ChatUsage?
   
   public struct ChatChoice: Decodable {
      
      /// The reason the model stopped generating tokens. This will be stop if the model hit a natural stop point or a provided stop sequence, length if the maximum number of tokens specified in the request was reached, content_filter if content was omitted due to a flag from our content filters, tool_calls if the model called a tool, or function_call (deprecated) if the model called a function.
      public let finishReason: IntOrStringValue?
      /// The index of the choice in the list of choices.
      public let index: Int?
      /// A chat completion message generated by the model.
      public let message: ChatMessage?
      /// Log probability information for the choice.
      public let logprobs: LogProb?

      public struct ChatMessage: Decodable {
         
         /// The contents of the message.
         public let content: String?
         /// The tool calls generated by the model, such as function calls.
         public let toolCalls: [ToolCall]?
         /// The name and arguments of a function that should be called, as generated by the model.
         @available(*, deprecated, message: "Deprecated and replaced by `tool_calls`")
         public let functionCall: FunctionCall?
         /// The role of the author of this message.
         public let role: String?
         /// The reasoning content generated by the model, if available.
         public let reasoningContent: String?
         /// Provided by the Vision API.
         public let finishDetails: FinishDetails?
         /// The refusal message generated by the model.
         public let refusal: String?
         /// If the audio output modality is requested, this object contains data about the audio response from the model. [Learn more](https://platform.openai.com/docs/guides/audio).
         public let audio: Audio?
         
         /// Provided by the Vision API.
         public struct FinishDetails: Decodable {
            let type: String?
         }
         
         public struct Audio: Decodable {
            /// Unique identifier for this audio response.
            public let id: String?
            /// The Unix timestamp (in seconds) for when this audio response will no longer be accessible on the server for use in multi-turn conversations.
            public let expiresAt: Int?
            /// Base64 encoded audio bytes generated by the model, in the format specified in the request.
            public let data: String?
            /// Transcript of the audio generated by the model.
            public let transcript: String?
            
            enum CodingKeys: String, CodingKey {
               case id
               case expiresAt = "expires_at"
               case data
               case transcript
            }
         }
         
         enum CodingKeys: String, CodingKey {
            case content
            case toolCalls = "tool_calls"
            case functionCall = "function_call"
            case role
            case finishDetails = "finish_details"
            case reasoningContent = "reasoning_content"
            case refusal
            case audio
         }
      }
      
      public struct LogProb: Decodable {
         /// A list of message content tokens with log probability information.
         let content: [TokenDetail]?
      }
      
      public struct TokenDetail: Decodable {
         /// The token.
         let token: String?
         /// The log probability of this token.
         let logprob: Double?
         /// A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be null if there is no bytes representation for the token.
         let bytes: [Int]?
         /// List of the most likely tokens and their log probability, at this token position. In rare cases, there may be fewer than the number of requested top_logprobs returned.
         let topLogprobs: [TopLogProb]?
         
         enum CodingKeys: String, CodingKey {
            case token, logprob, bytes
            case topLogprobs = "top_logprobs"
         }
         
         struct TopLogProb: Decodable {
            /// The token.
            let token: String?
            /// The log probability of this token.
            let logprob: Double?
            /// A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be null if there is no bytes representation for the token.
            let bytes: [Int]?
         }
      }
      
      enum CodingKeys: String, CodingKey {
         case finishReason = "finish_reason"
         case index
         case message
         case logprobs
      }
   }
   
   enum CodingKeys: String, CodingKey {
      case id
      case choices
      case created
      case model
      case serviceTier = "service_tier"
      case systemFingerprint = "system_fingerprint"
      case object
      case usage
   }
}
