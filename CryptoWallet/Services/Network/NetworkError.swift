import Foundation

enum NetworkError: Error {
    case invalidParams
    case invalidURL
    case invalidResponse(String?)
    case unknown
}

