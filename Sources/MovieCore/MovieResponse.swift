import Foundation

public struct MovieResponse: Decodable {
    public let results: [MovieItemResponse]
    
    public init(results: [MovieItemResponse]) {
        self.results = results
    }
}

public struct MovieItemResponse: Decodable {
    public let id: Int?
    public let title: String?
    public let overview: String?
    public let posterPath: String?
    public let voteAverage: Double?
    public let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    public init(id: Int?, title: String?, overview: String?, posterPath: String?, voteAverage: Double?, releaseDate: String?) {
            self.id = id
            self.title = title
            self.overview = overview
            self.posterPath = posterPath
            self.voteAverage = voteAverage
            self.releaseDate = releaseDate
        }
}
