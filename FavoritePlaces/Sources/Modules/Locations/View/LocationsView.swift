//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import SnapKit
import UIKit

final class LocationsView: UIView {
    struct Appearance {
        let spinnerColor: UIColor = .black
    }

    var appearance = Appearance()

    weak var refreshActionsDelegate: LocationsErrorViewDelegate?
    weak var switchActionsDelegate: LocationsPreferencesViewDelegate?

    // MARK: -  Subviews

    private var tableView: UITableView
    private lazy var emptyView: LocationsEmptyView = .init()

    private lazy var headerView: LocationsPreferencesView = {
        let view = LocationsPreferencesView()
        view.delegate = switchActionsDelegate
        return view
    }()

    private lazy var errorView: LocationsErrorView = {
        let view = LocationsErrorView()
        view.delegate = refreshActionsDelegate
        return view
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.color = appearance.spinnerColor
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: -  Lifecycle

    init(
        frame: CGRect,
        tableDataSouce: UITableViewDataSource,
        refreshDelegate: LocationsErrorViewDelegate,
        switchDelegate: LocationsPreferencesViewDelegate,
        appearance: Appearance = .init()
    ) {
        tableView = .init()
        super.init(frame: frame)
        tableView.dataSource = tableDataSouce
        refreshActionsDelegate = refreshDelegate
        switchActionsDelegate = switchDelegate

        backgroundColor = .white
        configureTableView()
        addSubviews(
            headerView,
            tableView,
            emptyView,
            errorView,
            spinner
        )
        configureLayout()
        [tableView, emptyView, errorView, spinner].forEach { $0.isHidden = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTableView() {
        tableView.backgroundColor = .white
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
        [tableView, emptyView, errorView].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalTo(headerView.snp.bottom)
                make.trailing.leading.bottom.equalToSuperview()
            }
        }
    }

    // MARK: -  States

    func showEmptyView(title: String, subtitle: String) {
        show(view: emptyView)
        emptyView.title.text = title
        emptyView.subtitle.text = subtitle
    }

    func showLoading() {
        show(view: spinner)
    }

    func showError(message: String) {
        show(view: errorView)
        errorView.title.text = message
    }

    func showTable() {
        show(view: tableView)
    }

    private func show(view: UIView) {
        subviews.forEach {
            $0.isHidden = (view != $0 && $0 != headerView)
        }
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
