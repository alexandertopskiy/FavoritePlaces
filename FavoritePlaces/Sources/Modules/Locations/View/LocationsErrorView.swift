//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import SnapKit
import UIKit

protocol LocationsErrorViewDelegate: AnyObject {
    func reloadButtonWasTapped()
}

final class LocationsErrorView: UIView {
    final class Appearance {
        let titleColor: UIColor =                   .black
        let backgroundColor: UIColor =              .white
        let buttonTitleColor: UIColor =             .darkGray
        let buttonTitleHighlightedColor: UIColor =  .lightGray
        let buttonBackgroundColor: UIColor =        .init(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.1)

        let buttonCornerRadius: CGFloat = 4
        let refreshButtonHeight: CGFloat = 48
        let titleInsets: UIEdgeInsets =             .init(top: 0.35, left: 33, bottom: 0, right: 32)
        let refreshButtonInsets: UIEdgeInsets =     .init(top: 24, left: 88, bottom: 0, right: 87)

        let buttonText = "Try again"
    }

    let appearance: Appearance
    weak var delegate: LocationsErrorViewDelegate?

    // MARK: -  Subviews

    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = appearance.titleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var refteshButton: UIButton = {
        let button = UIButton()
        button.setTitle(appearance.buttonText, for: .normal)
        button.setTitleColor(appearance.buttonTitleColor, for: .normal)
        button.setTitleColor(appearance.buttonTitleHighlightedColor, for: .highlighted)
        button.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: -  Lifecycle

    init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: CGRect.zero)
        backgroundColor = appearance.backgroundColor
        addSubviews(title, refteshButton)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(appearance.titleInsets.left)
            make.trailing.equalToSuperview().inset(appearance.titleInsets.right)
        }
        refteshButton.snp.makeConstraints { make in
            make.centerX.equalTo(title.snp.centerX)
            make.top.equalTo(title.snp.bottom).offset(appearance.refreshButtonInsets.top)
        }
    }

    // MARK: -  Actions

    @objc private func refreshButtonPressed() {
        delegate?.reloadButtonWasTapped()
    }
}
