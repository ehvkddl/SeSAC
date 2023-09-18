//
//  LoginViewModel.swift
//  Netfilx
//
//  Created by do hee kim on 2023/09/13.
//

import Foundation

class LoginViewModel {
    
    var id: Observable<String> = Observable("")
    var pw: Observable<String> = Observable("")
    var nickname: Observable<String> = Observable("")
    var location: Observable<String> = Observable("")
    var recommendCode: Observable<String> = Observable("")
    
    var isValid: Observable<Bool> = Observable(false)
    
    func checkValidity() {
        isValid.value = checkIDValidity() && checkPWValidity() && checkNicknameValidity() && checkRecommendCodeValidity()
    }
    
    func checkIDValidity() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let phoneRegex = "^01[0-1, 7][0-9]{7,8}$"

        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: id.value) || NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: id.value)
    }
    
    func checkPWValidity() -> Bool {
        let pwRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        return NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: pw.value)
    }
    
    func checkNicknameValidity() -> Bool {
        return nickname.value.count >= 2 && nickname.value.count <= 8 ? true : false
    }
    
    func checkRecommendCodeValidity() -> Bool {
        return recommendCode.value.count == 6 || recommendCode.value.isEmpty
    }
    
}
