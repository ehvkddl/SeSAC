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
    var isValid: Observable<Bool> = Observable(false)
    
    func checkValidity() {
        isValid.value = checkIDValidity() && checkPWValidity()
    }
    
    func checkIDValidity() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: id.value)
    }
    
    func checkPWValidity() -> Bool {
        let pwRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        return NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: pw.value)
    }
    
}
