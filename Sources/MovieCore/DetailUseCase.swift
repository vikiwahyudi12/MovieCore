import Combine
import Foundation

public protocol DetailUseCase {
    func getMovie() -> MovieModel
    func addFavorite() -> AnyPublisher<Bool, Error>
    func deleteFavorite() -> AnyPublisher<Bool, Error>
    func checkFavorite() -> AnyPublisher<Bool, Error>
}

public class DetailInteractor: DetailUseCase {
    
    private let repository: MovieRepositoryProtocol
    private let movie: MovieModel

    public required init(repository: MovieRepositoryProtocol, movie: MovieModel) {
        self.repository = repository
        self.movie = movie
    }

    public func getMovie() -> MovieModel {
        return movie
    }

    public func addFavorite() -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(movie: movie)
    }

    public func deleteFavorite() -> AnyPublisher<Bool, Error> {
        return repository.deleteFavorite(movie: movie)
    }

    public func checkFavorite() -> AnyPublisher<Bool, Error> {
        return repository.checkFavorite(id: movie.id)
    }
}
