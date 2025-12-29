import Foundation

public final class MovieMapper {
    public static func mapEntitiesToDomains(input: [MovieEntity]) -> [MovieModel] {
        return input.map { result in
            return MovieModel(
                id: result.id,
                title: result.title,
                overview: result.overview,
                posterPath: result.posterPath,
                voteAverage: result.voteAverage,
                releaseDate: result.releaseDate,
            )
        }
    }
    
    public static func mapDomainToEntity(input: MovieModel) -> MovieEntity {
        let newMovie = MovieEntity()
        newMovie.id = input.id
        newMovie.title = input.title
        newMovie.overview = input.overview
        newMovie.posterPath = input.posterPath
        newMovie.voteAverage = input.voteAverage
        newMovie.isFavorite = true
        newMovie.releaseDate = input.releaseDate
        return newMovie
    }
}
