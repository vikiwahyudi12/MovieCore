import Foundation

public enum NetworkError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Respon dari server tidak valid."
        case .addressUnreachable(let url): return "Tidak dapat menghubungi \(url.absoluteString)."
        case .invalidURL: return "URL tidak valid."
        }
    }
}
