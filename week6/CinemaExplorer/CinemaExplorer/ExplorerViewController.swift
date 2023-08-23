//
//  ViewController.swift
//  CinemaExplorer
//
//  Created by do hee kim on 2023/08/23.
//

import UIKit
import CoreLocation

class ExplorerViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
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
        print("===위치정보 가져오기 성공===")
        print(locations)
        print("======================")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
}
