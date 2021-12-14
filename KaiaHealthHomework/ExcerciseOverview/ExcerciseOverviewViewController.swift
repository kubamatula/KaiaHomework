//
//  ViewController.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import UIKit

class ExcerciseOverviewViewController: UIViewController {

    private let viewModel: ExcerciseOverviewViewModel
    private var tableView: UITableView!
    private lazy var dataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    init(viewModel: ExcerciseOverviewViewModel = MockExcerciseOverviewViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        (self.viewModel as! MockExcerciseOverviewViewModel).onExcercisesUpdate = { [unowned self] in
            self.updateTableView()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("This view is not intended to be used with InterfaceBuilder")
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.frame.inset(by: view.safeAreaInsets), style: .plain)
        tableView.registerReusableCell(ExcerciseOverviewCell.self)
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = 50
        tableView.allowsSelection = false
        view.addSubview(tableView)
        updateTableView()
    }

    private func updateTableView(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ExcerciseViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.excercises, toSection: 0)

        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

private extension ExcerciseOverviewViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Int, ExcerciseViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, excerciseViewModel in
                let cell: ExcerciseOverviewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configureCell(viewModel: excerciseViewModel)
                return cell
            }
        )
    }
}
