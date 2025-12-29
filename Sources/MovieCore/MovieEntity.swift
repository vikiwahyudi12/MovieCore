import Foundation
import RealmSwift

public class MovieEntity: Object {
    @Persisted(primaryKey: true) public var id: Int = 0
    @Persisted public var title: String = ""
    @Persisted public var overview: String = ""
    @Persisted public var posterPath: String = ""
    @Persisted public var voteAverage: Double = 0.0
    @Persisted public var isFavorite: Bool = false
    @Persisted public var releaseDate: String = ""
    
    public override init() {
        super.init()
    }
}
