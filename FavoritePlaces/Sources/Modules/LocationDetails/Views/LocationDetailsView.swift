//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit
import SnapKit

final class LocationDetailsView: UIView {
    struct Appearance {
        let spinnerColor: UIColor = .black
    }

    var appearance = Appearance()

    // MARK: -  Subviews

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.color = appearance.spinnerColor
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: -  Lifecycle

    init(frame: CGRect, appearance: Appearance = .init()) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubviews(spinner)
        configureLayout()
        [spinner].forEach { $0.isHidden = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: -  States

    func showLoading() {
        show(view: spinner)
    }

    private func show(view: UIView) {
        subviews.forEach {
            $0.isHidden = (view != $0)
        }
    }
}
