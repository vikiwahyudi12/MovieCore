import XCTest
import Combine
@testable import MovieCore

final class HomeUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testGetMoviesSuccessful() {
        // Given
        let mockRepository = MockMovieRepository()
        let dummyMovies = [
            MovieModel(id: 1, title: "Movie Test", overview: "Desc", posterPath: "", voteAverage: 8.0, releaseDate: "")
        ]
        mockRepository.result = .success(dummyMovies)
        let useCase = HomeInteractor(repository: mockRepository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movies")
        var resultMovies: [MovieModel] = []
        
        useCase.getMovies()
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                resultMovies = movies
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(resultMovies.count, 1)
        XCTAssertEqual(resultMovies.first?.title, "Movie Test")
    }
}
