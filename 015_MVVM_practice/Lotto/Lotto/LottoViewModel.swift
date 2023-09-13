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
    var lottoNumbers: [Int] {
        guard let data = data.value else { return [] }
        return [data.drwtNo1, data.drwtNo2, data.drwtNo3, data.drwtNo4, data.drwtNo5, data.bnusNo]
    }
    var lottoMoney: String {
        guard let data = data.value else { return "당첨금 0원"}
        return "🎊 당첨금 \(format(for: data.totSellamnt)) 🎊"
    }
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        guard let str = numberFormat.string(for: number) else {
            print("format string 변환 실패")
            return "" }
        
        return str
    }
    
    func fetch(_ round: Int) {
        LottoAPIManager.shared.fetchLotto(round: round) { lotto in
            self.data.value = lotto
        }
    }
    
}
