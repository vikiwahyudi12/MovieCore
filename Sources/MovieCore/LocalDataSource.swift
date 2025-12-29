import Foundation
import RealmSwift
import Combine

public protocol LocalDataSourceProtocol {
    func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error>
    func addMovie(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func deleteMovie(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func checkMovie(id: Int) -> AnyPublisher<Bool, Error>
}

public final class LocalDataSource: NSObject {
    
    private override init() { }
    
    public static let sharedInstance: LocalDataSource = LocalDataSource()
    
    public func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            if let realm = try? Realm() {
                let movies: Results<MovieEntity> = realm.objects(MovieEntity.self)
                    .sorted(byKeyPath: "title", ascending: true)
                completion(.success(movies.toArray(ofType: MovieEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func addMovie(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = try? Realm() {
                do {
                    try realm.write {
                        movie.isFavorite = true
                        realm.add(movie, update: .all)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteMovie(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = try? Realm() {
                do {
                    try realm.write {
                        if let objectToDelete = realm.object(ofType: MovieEntity.self, forPrimaryKey: movie.id) {
                            realm.delete(objectToDelete)
                            completion(.success(true))
                        } else {
                            completion(.failure(DatabaseError.requestFailed))
                        }
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func checkMovie(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = try? Realm() {
                let object = realm.object(ofType: MovieEntity.self, forPrimaryKey: id)
                completion(.success(object != nil))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database cannot be instantiated."
        case .requestFailed: return "Database request failed."
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
