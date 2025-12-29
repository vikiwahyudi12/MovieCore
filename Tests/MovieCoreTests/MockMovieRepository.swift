import Foundation
import Combine
@testable import MovieCore

public class MockMovieRepository: MovieRepositoryProtocol {
    public var result: Result<[MovieModel], Error> = .success([])

    public init() {}

    public func getMovies() -> AnyPublisher<[MovieModel], Error> {
        return result.publisher.eraseToAnyPublisher()
    }

    public func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
        return result.publisher.eraseToAnyPublisher()
    }

    public func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func checkFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
