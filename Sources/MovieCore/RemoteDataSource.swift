import Foundation
import Combine

public protocol RemoteDataSourceProtocol {
    func getMovies() -> AnyPublisher<[MovieItemResponse], Error>
}

public final class RemoteDataSource: NSObject {
    private override init() { }
    public static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
    private let apiKey = "b5999c18e4531a496caee578d56b5997"
    private let baseUrl = "https://api.themoviedb.org/3/movie/popular"

    public func getMovies() -> AnyPublisher<[MovieItemResponse], Error> {
        guard let url = URL(string: "\(baseUrl)?api_key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
