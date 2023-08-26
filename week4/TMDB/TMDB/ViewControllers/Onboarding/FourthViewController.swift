//
//  FourthViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/26.
//

import UIKit
import SnapKit

class FourthViewController: UIViewController {
    
    let gotoTrendViewButton = {
        var btn = UIButton()
        
        btn.setTitle("메인 화면으로 가기", for: .normal)
        btn.backgroundColor = .blue
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        view.addSubview(gotoTrendViewButton)
        gotoTrendViewButton.addTarget(self, action: #selector(gotoTrendViewButtonClicked), for: .touchUpInside)
        gotoTrendViewButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaInsets).inset(30)
        }
    }

    @objc
    func gotoTrendViewButtonClicked() {
        UserDefaults.standard.set(true, forKey: "isLaunched")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TrendViewController.identifier) as? TrendViewController else { return }
        
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
