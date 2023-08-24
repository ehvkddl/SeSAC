//
//  ViewController.swift
//  CinemaExplorer
//
//  Created by do hee kim on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class ExplorerViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    let currentMapSearchButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled() // apple system button
        config.title = "현 지도에서 검색"
        config.image = UIImage(systemName: "arrow.clockwise")
        
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.titleAlignment = .center
        
        config.cornerStyle = .capsule
        
        btn.configuration = config
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 1, height: 1)
        btn.layer.shadowRadius = 3
        
        return btn
    }()
    
    let filterButton = {
        let btn = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
        btn.setImage(image, for: .normal)
        
        btn.backgroundColor = .black
        btn.tintColor = .white
        
        btn.layer.cornerRadius = 30
        
        return btn
    }()
    
    var cinemas: [Cinema] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
        
        configureUI()
    }
    
    @objc
    func currentMapSearchButtonClicked() {
        CinemaAPImanager.shared.fetchLocations(around: mapView.region.center) { cinemas in
            self.cinemas = cinemas
            self.setAnnotation(type: nil)
        } failureCompletionHandler: {
            print("fail")
        }
    }
    
    @objc
    func filterButtonClicked() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let mega = UIAlertAction(title: "메가박스", style: .default) { action in
            self.setAnnotation(type: .mega)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { action in
            self.setAnnotation(type: .lotte)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { action in
            self.setAnnotation(type: .cgv)
        }
        let whole = UIAlertAction(title: "전체보기", style: .default) { action in
            self.setAnnotation(type: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(mega)
        actionSheet.addAction(lotte)
        actionSheet.addAction(cgv)
        actionSheet.addAction(whole)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }

}

extension ExplorerViewController {
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "현 위치"
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
    }
    
    func setAnnotation(type: CinemaType?) {
        mapView.removeAnnotations(mapView.annotations)
        
        // MARK: 내 위치 어노테이션
        var currentLocation: CLLocationCoordinate2D
        
        if let location = locationManager.location {
            currentLocation = location.coordinate
        } else {
            currentLocation = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.88627)
        }
        
        addAnnotation(title: "내 위치", coordinate: currentLocation)
        
        // MARK: 영화관 위치 어노테이션
        var annotationCinema: [Cinema] = []
        
        if let type {
            annotationCinema = self.cinemas.filter { $0.type == type }
        } else {
            annotationCinema = self.cinemas
        }
        
        annotationCinema.forEach {
            guard let lat = Double($0.y) else { return }
            guard let long = Double($0.x) else { return }
            
            addAnnotation(title: $0.placeName, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
        }
    }
    
    func addAnnotation(title: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        
        annotation.title = title
        annotation.coordinate = coordinate
        
        mapView.addAnnotation(annotation)
    }
    
}

extension ExplorerViewController {
    
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 할 수 없어요")
                return
            }
            
            let authorization: CLAuthorizationStatus
            
            if #available(iOS 14.0, *) {
                authorization = self.locationManager.authorizationStatus
            } else {
                authorization = CLLocationManager.authorizationStatus()
            }
            
            DispatchQueue.main.async {
                print("[checkDeviceLocationAuthorization] ", authorization)
                self.checkCurrentLocationAuthorization(status: authorization)
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("[checkCurrentLocationAuthorization] ", status)
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
             showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default: print("default")
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            guard let appSetting = URL(string: UIApplication.openSettingsURLString) else { return }
            
            UIApplication.shared.open(appSetting)
        }
        
        alert.addAction(cancel)
        alert.addAction(goSetting)
        
        present(alert, animated: true)
    }
    
}

extension ExplorerViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print("===위치정보 가져오기 성공===")
        print(location.coordinate)
        print("======================")
        
        CinemaAPImanager.shared.fetchLocations(around: location.coordinate) { cinemas in
            self.cinemas = cinemas
            self.setAnnotation(type: nil)
        } failureCompletionHandler: {
            print("fail")
        }
        
        setRegionAndAnnotation(center: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
}

extension ExplorerViewController {
    
    func configureUI() {
        [mapView, currentMapSearchButton, filterButton].forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        currentMapSearchButton.addTarget(self, action: #selector(currentMapSearchButtonClicked), for: .touchUpInside)
        currentMapSearchButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        filterButton.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        filterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(view).inset(16)
            make.size.equalTo(60)
        }
    }
    
}
