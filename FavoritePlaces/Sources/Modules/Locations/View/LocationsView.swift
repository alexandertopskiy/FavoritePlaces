//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit
import SnapKit

final class LocationsView: UIView {
    struct Appearance {
        let errorTitle: String = "Error loading data 💩"
        let emptyTitle: String = "Nothing to do here 🚀"
        let emptySubtitle: String = "Maybe later"

        let spinnerColor: UIColor = .black
    }

    var appearance = Appearance()

    weak var refreshActionsDelegate: LocationsErrorViewDelegate?

    // MARK: -  Subviews

    var tableView: UITableView

    private lazy var emptyView: LocationsEmptyView = {
        let view = LocationsEmptyView()
        
        return view
    }()

    private lazy var errorView: LocationsErrorView = {
        let view = LocationsErrorView()

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

    init(frame: CGRect, tableDataSouce: UITableViewDataSource, refreshDelegate: LocationsErrorViewDelegate, appearance: Appearance = .init()) {
        tableView = .init()
        super.init(frame: frame)
        tableView.dataSource = tableDataSouce
        refreshActionsDelegate = refreshDelegate

        backgroundColor = .white
        configureTableView()
        addSubviews(
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
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }

    private func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        [tableView, emptyView, errorView].forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
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
        subviews.forEach { $0.isHidden = (view != $0) }
    }

    func updateTableViewData() {
        showTable()
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.reloadData()
    }
}
