//
//  ThreadItem.swift
//  InsectIdentifier
//
//  Created by Hussnain on 15/03/2025.
//

import Foundation

struct ThreadItem: Identifiable {
    let id: Int
    let isUser: Bool
    let threadState: ThreadState
}

enum ThreadState {
    case loading
    case error
    case success(SuccessData)

    struct SuccessData {
        let prompt: String
        let attachedUri: String?
        let choices: [String]?
        let gemini: GeminiModel?
    }
}

struct GeminiModel: Codable {
    let candidates: [Candidate]?
    let modelVersion: String?
}

// Candidate response from Gemini API
struct Candidate: Codable {
    let avgLogprobs: Double?
    let content: Content?
    let finishReason: String?
}

// Content in Gemini response
struct Content: Codable {
    let parts: [Part]?
    let role: String?
}

// Individual parts of a response (text/image)
struct Part: Codable {
    let text: String?
    let inlineData: InlineData?
}

// Inline data for images
struct InlineData: Codable {
    let data: String
    let mimeType: String
}

