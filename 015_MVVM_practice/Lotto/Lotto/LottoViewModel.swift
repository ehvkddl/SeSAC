//
//  LottoViewModel.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/14.
//

import Foundation

class LottoViewModel {
    
    let round: [Int] = (1...1084).reversed()
    var selectRound: Observable<Int> = Observable(1084)
    var titleForSelect: String {
        return "\(selectRound.value)회"
    }
    
    var numberOfRows: Int {
        return round.count
    }
    
    func titleForRow(_ row: Int) -> String {
        return "\(round[row])"
    }
    
    var data: Observable<Lotto?> = Observable(nil)
    
    func fetch(_ round: Int) {
        LottoAPIManager.shared.fetchLotto(round: round) { lotto in
            self.data.value = lotto
        }
    }
    
    init() {
        print("lottoviewmodel")
    }
    
}
