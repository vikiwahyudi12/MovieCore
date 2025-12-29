import Combine

public protocol MovieRepositoryProtocol {
    func getMovies() -> AnyPublisher<[MovieModel], Error>
    func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func checkFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
