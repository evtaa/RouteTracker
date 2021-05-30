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
    let startTrackButton = UIButton()
    let stopTrackButton = UIButton()
    let viewRouteButton = UIButton()
    let mapView = GMSMapView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configureUI() {
        configureMapView()
        configureStartTrackButton()
        configureStopTrackButton()
        configureViewRoute()
        setupConstraints()
    }
    private func configureMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
    }
    private func  configureStartTrackButton() {
        startTrackButton.translatesAutoresizingMaskIntoConstraints = false
        startTrackButton.setImage(UIImage(named: "startRouteDisabled-60"), for: .normal)
        mapView.addSubview(startTrackButton)
    }
    private func  configureStopTrackButton() {
        stopTrackButton.translatesAutoresizingMaskIntoConstraints = false
        stopTrackButton.setImage(UIImage(named: "stopRouteDisaled-60"), for: .normal)
        mapView.addSubview(stopTrackButton)
    }
    private func  configureViewRoute() {
        viewRouteButton.translatesAutoresizingMaskIntoConstraints = false
        viewRouteButton.setImage(UIImage(named: "viewRoute-60"), for: .normal)
        mapView.addSubview(viewRouteButton)
    }
    
    private func setupConstraints() {
        let widthOfButton = CGFloat(50)
        let heightOfButton = CGFloat(50)
        let indentOfButtonFromEdgeRightLeft = CGFloat(5)
        let indentOfButtonFromEdgeBottom = CGFloat(20)
        let indentBetweenButton = CGFloat(5)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stopTrackButton.widthAnchor.constraint(equalToConstant: widthOfButton),
            stopTrackButton.heightAnchor.constraint(equalToConstant: heightOfButton),
            stopTrackButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -indentOfButtonFromEdgeRightLeft),
            stopTrackButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -indentOfButtonFromEdgeBottom),
            
            startTrackButton.bottomAnchor.constraint(equalTo: stopTrackButton.topAnchor, constant: -indentBetweenButton),
            startTrackButton.widthAnchor.constraint(equalToConstant: widthOfButton),
            startTrackButton.heightAnchor.constraint(equalToConstant: heightOfButton),
            startTrackButton.trailingAnchor.constraint(equalTo: stopTrackButton.trailingAnchor),
            
            viewRouteButton.widthAnchor.constraint(equalToConstant: widthOfButton),
            viewRouteButton.heightAnchor.constraint(equalToConstant: heightOfButton),
            viewRouteButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: indentOfButtonFromEdgeRightLeft),
            viewRouteButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -indentOfButtonFromEdgeBottom),
        ])
    }
}
