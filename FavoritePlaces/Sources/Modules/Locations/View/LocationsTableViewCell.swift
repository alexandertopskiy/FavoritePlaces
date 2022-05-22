//
//  Created by Alexander Loshakov on 22/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit
import SnapKit

final class LocationsTableViewCell: UITableViewCell {
    struct Appearance {
        let iconSide: CGFloat = 50
        let iconInsets: UIEdgeInsets = .init(top: 5, left: 12, bottom: 5, right: 10)
        let labelOffset: CGFloat = 12
        let separatorHeight: CGFloat = 1
        let defaultFontSize: CGFloat = 15

        let titleColor: UIColor = .black
        let separatorColor: UIColor = .init(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.05)
        let starColor: UIColor = .init(red: 255/255, green: 202/255, blue: 2/255, alpha: 1)
    }

    let appearance = Appearance()

    // MARK: -  Subviews

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = self.appearance.titleColor
        label.font = .systemFont(ofSize: appearance.defaultFontSize)
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.setRadius(radius: appearance.iconSide / 2)
        return view
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        let configuration: UIImage.SymbolConfiguration = .init(font: .systemFont(ofSize: appearance.defaultFontSize))
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        view.image = image
        view.tintColor = appearance.starColor
        return view
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = self.appearance.separatorColor
        return view
    }()

    // MARK: -  Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews(
            iconImageView,
            title,
            starImageView,
            separator
        )
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(appearance.iconInsets)
            make.width.height.equalTo(appearance.iconSide)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(appearance.iconInsets.right)
            make.centerY.equalToSuperview()
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(appearance.labelOffset)
            make.centerY.equalToSuperview()
        }
        separator.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(appearance.labelOffset)
            make.height.equalTo(appearance.separatorHeight)
        }
    }

    // MARK: -  Configuration

    func configure(cellRepresentable: LocationViewModel) {
        title.text = cellRepresentable.title
        iconImageView.image = cellRepresentable.image
        starImageView.isHidden = !cellRepresentable.isFavorite
    }
}
