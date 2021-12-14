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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame.inset(by: view.safeAreaInsets), style: .plain)
    }

    init(viewModel: ExcerciseOverviewViewModel = MockExcerciseOverviewViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("This view is not intended to be used with InterfaceBuilder")
    }
}

