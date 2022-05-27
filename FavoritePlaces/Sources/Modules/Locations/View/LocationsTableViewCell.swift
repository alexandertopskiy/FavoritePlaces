//
//  Created by Alexander Loshakov on 22/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import SnapKit
import UIKit

final class LocationsTableViewCell: UITableViewCell {
    struct Appearance {
        let iconImageSide: CGFloat = 50
        let iconImageInsets: UIEdgeInsets = .init(top: 5, left: 12, bottom: 5, right: 10)

        let labelTextColor: UIColor =       .black
        let labelInsets: UIEdgeInsets =     .init(top: 25, left: 10, bottom: 25, right: 5)
        let labelFontSize: CGFloat = 15

        let starImageSide: CGFloat = 15
        let starImageInsets: UIEdgeInsets = .init(top: 25, left: 5, bottom: 25, right: 12)
        let starImageColor: UIColor =       .init(red: 255/255, green: 202/255, blue: 2/255, alpha: 1)

        let detailsImageSide: CGFloat = 15
        let detailsImageInset: CGFloat = 20

        let separatorHeight: CGFloat = 1
        let separatorOffset: CGFloat = 12
        let separatorColor: UIColor =       .init(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.05)
    }

    let appearance = Appearance()

    // MARK: -  Subviews

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = self.appearance.labelTextColor
        label.font = .systemFont(ofSize: appearance.labelFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.setRadius(radius: appearance.iconImageSide / 2)
        return view
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView(image: .init(systemName: "star.fill"))
        view.tintColor = appearance.starImageColor
        return view
    }()

    private lazy var detailsImageView: UIImageView = .init(image: .init(named: "icon_show_details"))

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = self.appearance.separatorColor
        return view
    }()

    // MARK: -  Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        contentView.addSubviews(
            iconImageView,
            title,
            starImageView,
            detailsImageView,
            separator
        )
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(appearance.iconImageInsets)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(appearance.iconImageSide)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(appearance.iconImageInsets.right)
            make.top.bottom.equalToSuperview().inset(appearance.labelInsets.top)
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(appearance.starImageInsets.left)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(appearance.starImageSide)
        }
        detailsImageView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(starImageView.snp.trailing).offset(appearance.starImageInsets.right)
            make.trailing.equalToSuperview().inset(appearance.detailsImageInset)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(appearance.detailsImageSide)
        }
        separator.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(appearance.separatorOffset)
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
