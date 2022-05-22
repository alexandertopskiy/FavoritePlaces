//
//  Created by Alexander Loshakov on 22/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit
import SnapKit

final class LocationsTableViewCell: UITableViewCell {
    struct Appearance {
        let labelOffset: CGFloat = 12
        let separatorHeight: CGFloat = 1
        let separatorColor = UIColor(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.05)
        let titleColor: UIColor = .black
    }

    let appearance = Appearance()

    // MARK: -  Subviews

    lazy var title: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = self.appearance.titleColor
        typeLabel.numberOfLines = 2
        return typeLabel
    }()

    lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = self.appearance.separatorColor
        return view
    }()

    // MARK: -  Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews(title, separator)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(appearance.labelOffset)
        }
        separator.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(appearance.separatorHeight)
            make.left.equalToSuperview().offset(appearance.labelOffset)
        }
    }

    // MARK: -  Configuration

    func configure(cellRepresentable: LocationViewModel) {
        title.text = cellRepresentable.title
    }
}

