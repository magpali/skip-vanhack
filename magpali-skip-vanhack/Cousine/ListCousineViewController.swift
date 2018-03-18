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
    
    let refreshControll = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.cousineTableViewCell(),
                           forCellReuseIdentifier: R.reuseIdentifier.cousineTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControll
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cousines"
        
        addSubviews()
        bind()

    }
    
    func bind() {
        
        viewModel.cousines.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.cousineTableViewCell.identifier,
                                         cellType: CousineTableViewCell.self)) { _, element, cell in
                                            cell.populate(with: element)
            }.disposed(by: disposeBag)
        
        refreshControll.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] (_) in
            self.viewModel.listCousine()
        }).disposed(by: disposeBag)
        
        viewModel.loading.asObservable().subscribe(onNext: { [unowned self] (value) in
            if value {
                self.refreshControll.beginRefreshing()
            } else {
                self.refreshControll.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.asObservable().subscribe(onNext: { [unowned self] (indexPath) in
            guard let cousineId = self.viewModel.cousines.value[indexPath.row].id else { return }
            let storesViewController = ListStoresViewController(cousineId: cousineId)
            self.navigationController?.pushViewController(storesViewController, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }

}
