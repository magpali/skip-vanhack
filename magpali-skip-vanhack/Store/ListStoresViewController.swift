//
//  ListStoresViewController.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cartography

class ListStoresViewController: UIViewController {
    
    let viewModel: ListStoresViewModel
    
    let disposeBag = DisposeBag()
    
    let refreshControll = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.storeTableViewCell(),
                           forCellReuseIdentifier: R.reuseIdentifier.storeTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControll
        return tableView
    }()
    
    init(cousineId: Int) {
        viewModel = ListStoresViewModel(cousineId: cousineId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stores"
        
        addSubviews()
        bind()
    }
    
    func bind() {
        
        viewModel.stores.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.storeTableViewCell.identifier,
                                         cellType: StoreTableViewCell.self)) { _, element, cell in
                                            cell.populate(with: element)
            }.disposed(by: disposeBag)
        
        refreshControll.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] (_) in
            self.viewModel.refreshStores()
        }).disposed(by: disposeBag)
        
        viewModel.loading.asObservable().subscribe(onNext: { [unowned self] (value) in
            if value {
                self.refreshControll.beginRefreshing()
            } else {
                self.refreshControll.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.asObservable().subscribe(onNext: { [unowned self] (indexPath) in
            guard let storeId = self.viewModel.stores.value[indexPath.row].id,
            let storeName = self.viewModel.stores.value[indexPath.row].name else { return }
            let productsViewController = ListProductsViewController(storeId: storeId, storeName: storeName)
            self.navigationController?.pushViewController(productsViewController, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }
    
}

