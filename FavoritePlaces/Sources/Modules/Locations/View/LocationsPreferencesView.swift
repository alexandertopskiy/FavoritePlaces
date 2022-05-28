//
//  Created by Alexander Loshakov on 24/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

protocol LocationsPreferencesViewDelegate: AnyObject {
    func switchValueChanged(_ isOn: Bool)
}

final class LocationsPreferencesView: UIView {
    struct Appearance {
        let labelFontSize: CGFloat = 15
        let labelInsets: UIEdgeInsets = .init(top: 15, left: 12, bottom: 15, right: 12)

        let switchInset: CGFloat = 20

        let separatorHeight: CGFloat = 1
        let separatorOffset: CGFloat = 12
        let separatorColor: UIColor = .init(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.05)
    }

    let appearance: Appearance
    weak var delegate: LocationsPreferencesViewDelegate?

    // MARK: -  Subviews

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Favorites only"
        label.textColor = .black
        label.font = .systemFont(ofSize: appearance.labelFontSize)
        label.textAlignment = .left
        return label
    }()

    private lazy var favoritesOnlySwitch: UISwitch = {
        let favoritesOnlySwitch = UISwitch()
        favoritesOnlySwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return favoritesOnlySwitch
    }()

    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = self.appearance.separatorColor
        return view
    }()

    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = self.appearance.separatorColor
        return view
    }()

    // MARK: -  Lifecycle
    
    init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: .zero)

        addSubviews(
            topSeparator,
            title,
            favoritesOnlySwitch,
            bottomSeparator
        )
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        topSeparator.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.leading.equalToSuperview().offset(appearance.separatorOffset)
            make.height.equalTo(appearance.separatorHeight)
        }
        title.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(appearance.labelInsets.top)
            make.leading.equalToSuperview().inset(appearance.labelInsets.left)
        }
        favoritesOnlySwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(appearance.switchInset)
            make.centerY.equalToSuperview()
        }
        bottomSeparator.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(appearance.separatorOffset)
            make.height.equalTo(appearance.separatorHeight)
        }
    }

    // MARK: -  Actions

    @objc private func switchValueChanged() {
        delegate?.switchValueChanged(favoritesOnlySwitch.isOn)
    }
}
