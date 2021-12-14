//
//  ViewController.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import UIKit

class ExcerciseOverviewViewController: UIViewController {

    private let viewModel: ExcerciseOverviewViewModel
    private let trainingViewControllerFactory: ([ExcerciseViewModel]) -> TrainingViewController
    private var tableView: UITableView!
    private lazy var dataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupStartButton()
        viewModel.loadExcercises { [weak self] in
            DispatchQueue.main.async {
                self?.updateTableView()
            }
        }
    }

    init(
        viewModel: ExcerciseOverviewViewModel,
        trainingViewControllerFactory: @escaping ([ExcerciseViewModel]) -> TrainingViewController
    ) {
        self.viewModel = viewModel
        self.trainingViewControllerFactory = trainingViewControllerFactory
        super.init(nibName: nil, bundle: nil)
        (self.viewModel as! ExcerciseOverviewViewModelImpl).onExcercisesUpdate = { [unowned self] in
            self.updateTableView()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("This view is not intended to be used with InterfaceBuilder")
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerReusableCell(ExcerciseOverviewCell.self)
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = 50
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        updateTableView()
    }

    private func setupStartButton() {
        let startButton = UIButton(type: .system)
        startButton.setTitle("Start training", for: .normal)
        startButton.addTarget(self, action: #selector(startTraining), for: .touchDown)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margin.standard),
        ])
    }

    private func updateTableView(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ExcerciseViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.excercises, toSection: 0)

        dataSource.apply(snapshot, animatingDifferences: animated)
    }

    @objc private func startTraining() {
        let trainingViewController = trainingViewControllerFactory(viewModel.excercises)
        self.navigationController?.pushViewController(trainingViewController, animated: true)
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
