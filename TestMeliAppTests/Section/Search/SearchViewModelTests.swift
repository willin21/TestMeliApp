import XCTest
import RxSwift
import RxCocoa
@testable import TestMeliApp

final class SearchViewModelTests: XCTestCase {

    private var viewModel: SearchViewModel!
    private var mockRepository: MockRepository!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        viewModel = SearchViewModel(repository: mockRepository) // Agregar un inicializador adecuado si no existe
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        disposeBag = nil
        super.tearDown()
    }

    func testGetSearchByWordSuccess() {
        
    }

    func testGetAutosuggestSuccess() {
        // Arrange
        let mockRepository = MockRepository()
        let expectedResults = mockRepository.getMockSearch(query: "Silla").map { $0.results }
        mockRepository.mockAutosuggestResult = .just(AutosuggestResponse(query: "silla", suggestedQueries: expectedResults))
        
        // Act
        let expectation = self.expectation(description: "Autosuggest Results Loaded")
        viewModel.autosuggestResultBehavior.skip(1).subscribe(onNext: { results in
            XCTAssertEqual(results.count, expectedSuggestions.count)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.getAutosuggest("query")
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetSearchWithMockResponse() {
        let mockRepository = MockRepository()
        let viewModel = SearchViewModel()
        
        let expectation = self.expectation(description: "Mock API Response Loaded")
        viewModel.searchResultBehavior.skip(1).subscribe(onNext: { results in
            XCTAssertEqual(results.count, 2) // Asegúrate de que los datos coinciden
            expectation.fulfill()
        }).disposed(by: DisposeBag())
        
        viewModel.getSearchByWord("query")
        
        wait(for: [expectation], timeout: 1.0)
    }

}
