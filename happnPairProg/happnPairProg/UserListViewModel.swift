//
//  UserListViewModel.swift
//  happnPairProg
//
//  Created by Bin CHEN on 13/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class UserListViewModel {
    private let repository: Repository
    var coordinator: UserListCoordinator? = nil
    
    let refresh = PublishRelay<Void>()
    let viewDidLoad = PublishRelay<Void>()
    let userSelectionAction = PublishRelay<User>()
    let bag = DisposeBag()
    
    var users: Observable<[User]> {
        return Observable.merge(refresh.asObservable(),
                                viewDidLoad.asObservable())
           .flatMap {
               return self.fetch()
        }
    }
    
    init(repository: Repository) {
        self.repository = repository
        
        userSelectionAction.subscribe { [weak self]user in
            self?.coordinator?.showProfile(user: user)
        }.disposed(by: bag)

    }
    
    func fetch() -> Observable<[User]> {
        return repository.fetch()
    }
}
