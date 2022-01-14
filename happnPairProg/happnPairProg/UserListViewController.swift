//
//  ViewController.swift
//  AndrzejSampleApp
//
//  Created by Julien Sechaud on 11/05/2021.
//

import UIKit
import RxSwift
import RxCocoa

class UserListViewController: UIViewController {
    let viewModel: UserListViewModel = UserListViewModel(repository: Repository())
	let bag = DisposeBag()
    
	private lazy var tableView: UITableView = {
		$0.tableFooterView = UIView()
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		$0.refreshControl = UIRefreshControl(frame: .zero, primaryAction: UIAction(handler: { _ in
            self.viewModel.refresh.accept(())
		}))
		return $0
    }(UITableView())
		
	override func viewDidLoad() {
		setupUI()
        setupBindings()
        viewModel.coordinator = UserListCoordinator(source: self.navigationController)

        viewModel.viewDidLoad.accept(())
	}
    
    private func setupBindings() {
        viewModel.users.subscribe { [weak self]users in
            self?.tableView.refreshControl?.endRefreshing()
        } onError: { error in
            // TODO: error handlers
        }.disposed(by: bag)
        
        viewModel.users
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = element.firstName
                return cell
            }
            .disposed(by: bag)
        tableView.rx
            .modelSelected(User.self)
            .bind(to: viewModel.userSelectionAction)
            .disposed(by: bag)
    }
	
	private func setupUI() {
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
		])
	}
}
