//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import SnapKit
import UIKit

final class LocationsView: UIView {
    struct Appearance {
        let spinnerColor: UIColor =         .black
        let backgroundColor: UIColor =      .white
        let tableBackgroundColor: UIColor = .white
    }

    var appearance = Appearance()

    weak var switchActionsDelegate: LocationsPreferencesViewDelegate?

    // MARK: -  Subviews

    private var tableView: UITableView = .init()

    private lazy var headerView: LocationsPreferencesView = {
        let view = LocationsPreferencesView()
        view.delegate = switchActionsDelegate
        return view
    }()

    private lazy var errorView: LocationsErrorView = .init()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.color = appearance.spinnerColor
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: -  Lifecycle

    init(frame: CGRect,
         switchDelegate: LocationsPreferencesViewDelegate,
         appearance: Appearance = .init()) {
        super.init(frame: frame)

        switchActionsDelegate = switchDelegate
        backgroundColor = appearance.backgroundColor
        configureTableView()
        addSubviews(
            headerView,
            tableView,
            errorView,
            spinner
        )
        configureLayout()
        [tableView, errorView, spinner].forEach { $0.isHidden = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTableView() {
        tableView.backgroundColor = appearance.tableBackgroundColor
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }

    private func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        [tableView, errorView].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalTo(headerView.snp.bottom)
                make.trailing.leading.bottom.equalToSuperview()
            }
        }
    }

    // MARK: -  Private

    private func show(view: UIView) {
        subviews.forEach {
            $0.isHidden = (view != $0 && $0 != headerView)
        }
    }

    // MARK: -  States

    func showLoading() {
        show(view: spinner)
    }

    func showError(message: String) {
        show(view: errorView)
        errorView.configure(withMessage: message)
    }

    func showTable() {
        show(view: tableView)
    }

    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        showTable()
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.reloadData()
    }
}
