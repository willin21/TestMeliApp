import Foundation
import RxCocoa
import RxSwift

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
                self.error.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
