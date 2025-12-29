import Combine
import Foundation

public final class MovieRepository: NSObject {
    
    public typealias Instance = (RemoteDataSource, LocalDataSource) -> MovieRepository
    
    let remote: RemoteDataSource
    let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    public static let sharedInstance: Instance = { remoteRepo, localRepo in
        return MovieRepository(remote: remoteRepo, local: localRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
 
    public func getMovies() -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getMovies()
            .map { responses in
                return responses.map { response in
                    MovieModel(
                        id: response.id ?? 0,
                        title: response.title ?? "Unknown",
                        overview: response.overview ?? "",
                        posterPath: "https://image.tmdb.org/t/p/w500\(response.posterPath ?? "")",
                        voteAverage: response.voteAverage ?? 0.0,
                        releaseDate: response.releaseDate ?? ""
                    )
                }
            }
            .eraseToAnyPublisher()
    }

    public func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
        return self.local.getFavoriteMovies()
            .map {
                return MovieMapper.mapEntitiesToDomains(input: $0)
            }
            .eraseToAnyPublisher()
    }

    public func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        let entity = MovieMapper.mapDomainToEntity(input: movie)
        return self.local.addMovie(from: entity)
    }
    
    public func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        let entity = MovieMapper.mapDomainToEntity(input: movie)
        return self.local.deleteMovie(from: entity)
    }
    
    public func checkFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.local.checkMovie(id: id)
    }
}
