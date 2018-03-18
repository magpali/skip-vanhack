//
//  ListCousine.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cartography

class ListCousineViewController: UIViewController {
    
    let viewModel = ListCousineViewModel()
    
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.cousineTableViewCell(),
                           forCellReuseIdentifier: R.reuseIdentifier.cousineTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .purple
        
        addSubviews()
        bind()

    }
    
    func bind() {
        
        viewModel.cousines.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.cousineTableViewCell.identifier,
                                         cellType: CousineTableViewCell.self)) { _, element, cell in
                                            cell.nameLabel.text = element.name
            }.disposed(by: disposeBag)
        
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }

}
