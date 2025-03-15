import Foundation
import RxCocoa
import RxSwift
import CocoaLumberjack

class CategoriesViewModel {
    
    // MARK: - Properties
    var repository = AppRepository()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Outputs
    let error = PublishSubject<String>()
    
    var categoriesBehavior: BehaviorRelay<Categories> = BehaviorRelay(value: Categories())
    
    var firstCategoryBehavior: BehaviorRelay<[SearchProduct]> = BehaviorRelay(value: [SearchProduct]())
    
    var lastCategoryBehavior: BehaviorRelay<[SearchProduct]> = BehaviorRelay(value: [SearchProduct]())
    
    func getCategories() {
        repository.getCategories().subscribe(
            onNext: { [weak self] (response) in
                self?.saveCategories(response)
                self?.categoriesBehavior.accept(response)
            }, onError: { (error) in
                let errorDescription = error.localizedDescription
                self.error.onNext(errorDescription)
                DDLogError("getCategories error: \(errorDescription)")
            }).disposed(by: disposeBag)
    }
    
    func getFirstCategory() {
        let id = CategoriesHelper.shared.getLocalCategories().first?.id ?? ""
        
        if id.isEmpty { return }
        
        repository.getSearchByCategory(id: id).subscribe(
            onNext: { [weak self] (response) in
                if let results = response.results {
                    self?.firstCategoryBehavior.accept(results)
                }
            }, onError: { (error) in
                let errorDescription = error.localizedDescription
                self.error.onNext(errorDescription)
                DDLogError("getSearchByCategory error: \(errorDescription)")
            }).disposed(by: disposeBag)
    }
    
    func getLastCategory() {
        let id = CategoriesHelper.shared.getLocalCategories().last?.id ?? ""
        
        if id.isEmpty { return }
        
        repository.getSearchByCategory(id: id).subscribe(
            onNext: { [weak self] (response) in
                if let results = response.results {
                    self?.lastCategoryBehavior.accept(results)
                }
            }, onError: { (error) in
                let errorDescription = error.localizedDescription
                self.error.onNext(errorDescription)
                DDLogError("getSearchByCategory error: \(errorDescription)")
            }).disposed(by: disposeBag)
    }
    
    private func saveCategories(_ categories: Categories) {
        do {
            try CategoriesHelper.shared.save(categories)
        } catch {
            let errorDescription = error.localizedDescription
            self.error.onNext(errorDescription)
            DDLogError("saveCategories error: \(errorDescription)")
        }
    }
}

