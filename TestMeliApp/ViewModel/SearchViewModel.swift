import Foundation
import RxCocoa
import RxSwift
import CocoaLumberjack

class SearchViewModel {
    
    // MARK: - Properties
    private var repository = AppRepository()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Outputs
    let error = PublishSubject<String>()
    var searchResultBehavior: BehaviorRelay<[SearchProduct]> = BehaviorRelay(value: [SearchProduct]())
    var autosuggestResultBehavior: BehaviorRelay<[SuggestedQuery]> = BehaviorRelay(value: [SuggestedQuery]())
    
    func getSearchByWord(_ query: String) {
        repository.getSearch(query: query).subscribe(
            onNext: { [weak self] (response) in
                if let results = response.results {
                    self?.searchResultBehavior.accept(results)
                }
            }, onError: { (error) in
                let errorDescription = error.localizedDescription
                self.error.onNext(errorDescription)
                DDLogError("getSearchCollection error: \(errorDescription)")
        }).disposed(by: disposeBag)
    }
    
    func getAutosuggest(_ query: String) {
        let autosuggestRequest = AutosuggestRequest(showFilters: true,
                                                    limit: 6,
                                                    apiVersion: 2,
                                                    query: query)
            
        repository.getAutosuggest(autoSuggestRequest: autosuggestRequest).subscribe(
            onNext: { [weak self] (response) in
                if let results = response.suggestedQueries {
                    self?.autosuggestResultBehavior.accept(results)
                }
            }, onError: { (error) in
                let errorDescription = error.localizedDescription
                self.error.onNext(errorDescription)
                DDLogError("getSearchCollection error: \(errorDescription)")
        }).disposed(by: disposeBag)
    }
}
