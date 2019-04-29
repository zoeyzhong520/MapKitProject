//
//  ShowLocationView.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShowLocationView: UIView {

    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.bounds)
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
//        mapView.showsUserLocation = true
        //设置用户跟踪模式
//        mapView.userTrackingMode = MKUserTrackingMode.follow
        return mapView
    }()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        if !CLLocationManager.locationServicesEnabled() {
            self.showAlertWith(message: "请开启定位:设置 > 隐私 > 位置 > 定位服务")
        }
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        return locationManager
    }()
    
    lazy var geocoder: CLGeocoder = {
        let geocoder = CLGeocoder()
        return geocoder
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    func addViews() {
        locationManager.startUpdatingLocation()
        addSubview(mapView)
    }

    ///地理编码
    func locationEnCode(address: String) {
        if address.count == 0 || address.contains(" ") {
            return
        }
        
        geocoder.geocodeAddressString(address) { (placeMarks, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            let placeMark = placeMarks?.first
            let latitude = placeMark?.location?.coordinate.latitude
            let longitude = placeMark?.location?.coordinate.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            annotation.title = address
            self.mapView.addAnnotation(annotation)
            
            var span = MKCoordinateSpan()
            //地图的范围 越小越精确
            span.latitudeDelta = 0.1
            span.longitudeDelta = 0.1
            //设置地图显示范围
            self.mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: span), animated: true)
        }
    }
    
}

extension ShowLocationView: MKMapViewDelegate,CLLocationManagerDelegate {
    
    //MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let location = userLocation.location
        let coordinate = location?.coordinate
        print("经度 = \(coordinate?.latitude), 纬度 = \(coordinate?.longitude)")
    }
    
}
