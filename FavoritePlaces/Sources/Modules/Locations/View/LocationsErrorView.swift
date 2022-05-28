//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import SnapKit
import UIKit

final class LocationsErrorView: UIView {
    final class Appearance {
        let titleColor: UIColor =                   .black
        let backgroundColor: UIColor =              .white
        let titleInsets: UIEdgeInsets =             .init(top: 0.35, left: 33, bottom: 0, right: 32)
    }

    let appearance: Appearance

    // MARK: -  Subviews

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = appearance.titleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: -  Lifecycle

    init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: CGRect.zero)
        
        backgroundColor = appearance.backgroundColor
        addSubview(title)
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
    }

    // MARK: -  Configuration

    func configure(withMessage errorMessage: String) {
        title.text = errorMessage
    }
}
