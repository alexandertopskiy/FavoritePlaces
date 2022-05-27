//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import MapKit
import SnapKit
import UIKit

final class LocationDetailsView: UIView {
    struct Appearance {
        let mapViewHeight: CGFloat = UIScreen.main.bounds.height * 5 / 13
        let mapScale: CGFloat = 2500

        let iconImageSide: CGFloat = 200
        let iconBorderWidth: CGFloat = 5.0

        let labelsHorizontalInset: CGFloat = 20
        let nameLabelTopOffset: CGFloat = 30
        let subtitleLabelTopOffset: CGFloat = 5
        let subtitleLabelsOffset: CGFloat = -10
        let defaultTextColor: UIColor =       .black
        let titleFontSize: CGFloat = 20
        let subtitleFontSize: CGFloat = 15

        let starImageColor: UIColor =       .init(red: 255/255, green: 202/255, blue: 2/255, alpha: 1)
        let starImageInsets: UIEdgeInsets = .init(top: 25, left: 5, bottom: 25, right: 12)
        let starImageSide: CGFloat = 15

        let spinnerColor: UIColor = .black
    }

    var appearance = Appearance()

    // MARK: -  Subviews

    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var iconImageBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.setRadius(radius: appearance.iconImageSide / 2)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = appearance.iconBorderWidth
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = self.appearance.defaultTextColor
        label.font = .systemFont(ofSize: appearance.titleFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView(image: .init(systemName: "star.fill"))
        view.tintColor = appearance.starImageColor
        return view
    }()

    private lazy var parkLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.defaultTextColor
        label.font = .systemFont(ofSize: appearance.subtitleFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.defaultTextColor
        label.font = .systemFont(ofSize: appearance.subtitleFontSize)
        label.textAlignment = .right
        return label
    }()

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
        iconImageBGView.addSubview(iconImageView)
        let views = [
            spinner,
            mapView,
            iconImageBGView,
            nameLabel,
            starImageView,
            stateLabel,
            parkLabel
        ]
        addSubviews(views)
        configureLayout()
        views.forEach { $0.isHidden = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        mapView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(appearance.mapViewHeight)
        }
        [iconImageBGView, iconImageView].forEach { view in
            view.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalTo(mapView.snp.bottom)
                make.width.height.equalTo(appearance.iconImageSide)
            }
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageBGView.snp.bottom).offset(appearance.nameLabelTopOffset)
            make.leading.equalToSuperview().inset(appearance.labelsHorizontalInset)
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(appearance.starImageInsets.left)
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(appearance.starImageSide)
        }
        stateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(appearance.labelsHorizontalInset)
            make.top.equalTo(nameLabel.snp.bottom).offset(appearance.subtitleLabelTopOffset)
        }
        parkLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(stateLabel.snp.leading).offset(appearance.subtitleLabelsOffset)
            make.top.equalTo(stateLabel)
        }
    }

    // MARK: -  Configuratation

    func configure(with viewModel: LocationDetailsViewModel) {
        mapView.setRegion(
            .init(
                center: CLLocationCoordinate2D(
                    latitude: viewModel.geoPosition.latitude,
                    longitude: viewModel.geoPosition.longitude
                ),
                latitudinalMeters: appearance.mapScale,
                longitudinalMeters: appearance.mapScale
            ),
            animated: true
        )
        iconImageView.image = viewModel.image
        nameLabel.text = viewModel.name
        parkLabel.text = viewModel.park
        stateLabel.text = viewModel.state
        starImageView.isHidden = !viewModel.isFavorite
    }

    // MARK: -  States

    func showLoading() {
        subviews.forEach { $0.isHidden = ($0 != spinner) }
    }

    func showView() {
        subviews.forEach { $0.isHidden = ($0 == spinner) }
    }
}
