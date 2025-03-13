import Foundation
import RxCocoa
import RxSwift

class OAuthViewModel {
    
    // MARK: - Properties
    private var repository = AppRepository()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Outputs
    let error = PublishSubject<String>()
    
    var oauthBehavior: BehaviorRelay<OAuthToken> = BehaviorRelay(value: OAuthToken())
    
    var oAuthTokenObservable: Observable<[OAuthResponse]> {
        return oauthBehavior.asObservable()
    }
    
    func getOAuthToken(oauth: OAuthRequest) {
        repository.getOAuthToken(oauth: oauth).subscribe(
            onNext: { [weak self] (response) in
                self?.oauthBehavior.accept([response])
            }, onError: { (error) in
                self.error.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func refreshToken() {
        
        var grantType = GrantType.refreshToken

        if let accessToken = UserDefaultsHelper.getString(forKey: Constants.UserDefaults.accessToken), accessToken.isEmpty {
            grantType = .authorizationCode
        }
        
        let oauth = OAuthRequest(
            grantType: grantType.rawValue,
            clientId: Preferences.clientId,
            clientSecret: Preferences.clientSecret,
            code: nil,
            redirectUri: nil,
            refreshToken: Preferences.refreshToken)
        
        repository.refreshToken(oauth: oauth).subscribe(
            onNext: { [weak self] (response) in
                UserDefaultsHelper.saveString(objectToSave: response.accessToken, forKey: Constants.UserDefaults.accessToken)
                self?.oauthBehavior.accept([response])
            }, onError: { (error) in
                self.error.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func getUser() {
        guard let _ = OAuthHelper.shared.getUser() else {
            repository.getUser().subscribe(
                onNext: { (response) in
                    let user = User(
                        id: response.id,
                        nickname: response.nickname,
                        registrationDate: response.registrationDate,
                        firstName: response.firstName,
                        lastName: response.lastName,
                        gender: response.lastName,
                        countryID: response.countryID,
                        email: response.email,
                        points: response.points,
                        siteID: response.siteID)
                    
                    do {
                        try OAuthHelper.shared.saveUser(user)
                    } catch {
                        self.error.onNext(error.localizedDescription)
                    }
                }, onError: { (error) in
                    self.error.onNext(error.localizedDescription)
                }).disposed(by: disposeBag)
            
            return
        }
    }
}

