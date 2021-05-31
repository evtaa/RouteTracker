//
//  MapView.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 25.05.2021.
//

import UIKit
import GoogleMaps

class MapView: UIView {
    // MARK: Subview
    let mapView = GMSMapView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure() {
        configureMapView()
        setupConstraints()
    }
    private func configureMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                                        mapView.topAnchor.constraint(equalTo: topAnchor),
                                        mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                        mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        mapView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
