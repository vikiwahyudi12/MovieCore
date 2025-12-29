import Foundation

public struct MovieModel: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String
    public let voteAverage: Double
    public let releaseDate: String

        public init(
            id: Int,
            title: String,
            overview: String,
            posterPath: String,
            voteAverage: Double,
            releaseDate: String
        ) {
            self.id = id
            self.title = title
            self.overview = overview
            self.posterPath = posterPath
            self.voteAverage = voteAverage
            self.releaseDate = releaseDate
        }
    
}
