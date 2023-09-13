//
//  ViewController.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LottoAPIManager().fetchLotto(round: 1000) { lotto in
            print(lotto)
        }
    }


}

