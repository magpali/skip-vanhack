//
//  ListProductsViewController.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cartography

class ListProductsViewController: UIViewController {
    
    let viewModel: ListProductsViewModel
    
    let disposeBag = DisposeBag()
    
    let refreshControll = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.productsTableViewCell(),
                           forCellReuseIdentifier: R.reuseIdentifier.productsTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControll
        return tableView
    }()
    
    init(storeId: Int, storeName: String) {
        viewModel = ListProductsViewModel(storeId: storeId)
        super.init(nibName: nil, bundle: nil)
        self.title = storeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubviews()
        bind()
        
    }
    
    func bind() {
        
        viewModel.products.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.productsTableViewCell.identifier,
                                         cellType: ProductsTableViewCell.self)) { _, element, cell in
                                            cell.populate(with: element)
            }.disposed(by: disposeBag)
        
        refreshControll.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] (_) in
            self?.viewModel.refreshProducts()
        }).disposed(by: disposeBag)
        
        viewModel.loading.asObservable().subscribe(onNext: { [weak self] (value) in
            if value {
                self?.refreshControll.beginRefreshing()
            } else {
                self?.refreshControll.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] (indexPath) in
            print(indexPath.row)
        }).disposed(by: disposeBag)
        
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }
    
}



