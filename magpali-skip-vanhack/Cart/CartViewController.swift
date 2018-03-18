//
//  CartViewController.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearCartButton: UIButton!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        applyLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshCart()
    }

    func configTableView() {
        tableView.register(R.nib.productsTableViewCell(),
                           forCellReuseIdentifier: R.reuseIdentifier.productsTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    func applyLayout() {
        clearCartButton.setTitle(R.string.localizable.cartClearCart(), for: .normal)
        placeOrderButton.setTitle(R.string.localizable.cartPlaceOrder(), for: .normal)
    }
    
    func bind() {

        viewModel.cartList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.productsTableViewCell.identifier,
                                         cellType: ProductsTableViewCell.self)) { _, element, cell in
                                            cell.populate(with: element)
            }.disposed(by: disposeBag)
        
        clearCartButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
            self.viewModel.clearCart()
        }).disposed(by: disposeBag)
        
        placeOrderButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
            if self.viewModel.userIsAuthenticated() {
                self.viewModel.placeOrder()
            } else {
                self.presentLoginFlow()
            }
            
        }).disposed(by: disposeBag)
    }
    
    func presentLoginFlow() {
        let navigation = UINavigationController(rootViewController: LoginViewController())
        self.present(navigation, animated: true, completion: nil)
    }
}
