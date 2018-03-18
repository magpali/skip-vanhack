//
//  ListCousineViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift

class ListCousineViewModel {
    
    let disposeBag = DisposeBag()
    
    let error = Variable<Error?>(nil)
    let cousines: Variable<[Cousine]> = Variable<[Cousine]>([])
    
    init() {
        listCousine()
    }
    
    func listCousine() {
        APIClient.listCousine().subscribe { (event) in
            switch event {
            case .next(let cousines):
                self.error.value = nil
                self.cousines.value = cousines
            case .error(let error):
                self.error.value = error
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
    }
    
}
