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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
        
        configureUI()
    }
    
    @objc
    func filterButtonClicked() {
        print("filterButtonClicked")
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
        @unknown default: print("default") // 위치 권한 종류가 더 샐길 가능성 대비
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
            cinemas.forEach { print($0.type.rawValue) }
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
        [mapView, filterButton].forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        filterButton.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        filterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(view).inset(16)
            make.size.equalTo(60)
        }
    }
    
}
