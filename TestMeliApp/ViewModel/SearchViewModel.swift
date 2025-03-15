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
    
    var searchResultBehavior: BehaviorRelay<Search> = BehaviorRelay(value: Search())
    
    var searchResultObservable: Observable<Search> {
        return searchResultBehavior.asObservable()
    }
    
    func getSearchCollection(_ query: String) {
        repository.getSearch(query: query).subscribe(
            onNext: { [weak self] (response) in
                self?.searchResultBehavior.accept([response])
            }, onError: { (error) in
                let errorDescription = error.localizedDescription
                self.error.onNext(errorDescription)
                DDLogError("getSearchCollection error: \(errorDescription)")
        }).disposed(by: disposeBag)
    }
}
