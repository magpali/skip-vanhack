//
//  ListCousine.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift

class ListCousine: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .purple
        
        APIClient.listCousine().subscribe { (event) in
            switch event {
            case .next(let cousines):
                print(cousines[0].id)
                print(cousines[0].name)
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
    }

}
