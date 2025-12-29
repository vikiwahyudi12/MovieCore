import Combine
import Foundation

public protocol FavoriteUseCase {
    func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
}

public class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MovieRepositoryProtocol

    public required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
        return repository.getFavoriteMovies()
    }
}
