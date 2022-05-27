//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import SnapKit
import UIKit

final class LocationsEmptyView: UIView {
    final class Appearance {
        let titleColor: UIColor =           .black
        let subtitleColor: UIColor =        .gray
        let backgroundColor: UIColor =      .white

        let titleInsets: UIEdgeInsets =     .init(top: 0, left: 33, bottom: 0, right: 32)
        let subtitleInsets: UIEdgeInsets =  .init(top: 8, left: 33, bottom: 8, right: 32)

        var needsTopOffset = false
        var needsBottomOffset = false
    }

    let appearance: Appearance

    // MARK: -  Subviews

    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.backgroundColor
        return view
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = appearance.titleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.textColor = appearance.subtitleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: -  Lifecycle

    init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: CGRect.zero)
        view.addSubviews(title, subtitle)
        addSubview(view)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        view.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(appearance.titleInsets)
        }
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(appearance.subtitleInsets.top)
            make.leading.trailing.bottom.equalToSuperview().inset(appearance.subtitleInsets)
        }
    }
}
