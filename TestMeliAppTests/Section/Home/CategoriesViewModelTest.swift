import XCTest
import RxSwift
import Combine

@testable import TestMeliApp

final class CategoriesViewModelTest: XCTestCase {
    var viewModel: CategoriesViewModel!
    var mockRepository: MockRepository!
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        viewModel = CategoriesViewModel()
    }
    
    func test_searchCategory_successfulResponse() {
        // Given
        let expectedCategories = [CategoryResponse.mockCategory]
        
        let expectation = self.expectation(description: "Search category should return valid results")
        
        // When
        viewModel.repository.getCategories().subscribe(
            onNext: { (category) in
                XCTAssertEqual(category.count, expectedCategories.count)
                expectation.fulfill()
            }, onError: { (error) in
                XCTFail("Expected success but received an error")
            }).disposed(by: disposeBag)
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_searchCategory_failureResponse() {
        // Given
        let expectedError = "Network error"
        mockRepository.shouldFail = true
        mockRepository.errorMessage = expectedError
        
        let expectation = self.expectation(description: "Search category should return an error")
        
        // When
        viewModel.repository.getCategories().subscribe(
            onNext: { (category) in
                XCTFail("Expected failure but received success")
            }, onError: { (error) in
                XCTFail("Expected success but received an error")
            }).disposed(by: disposeBag)
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
