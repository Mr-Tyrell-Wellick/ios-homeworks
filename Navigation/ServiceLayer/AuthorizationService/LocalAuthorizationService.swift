//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Ульви Пашаев on 17.05.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    private let context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        
        let result = context.canEvaluatePolicy(policy, error: &error)
        if result {
            context.evaluatePolicy(policy, localizedReason: "Verify your Identity") { result, error in
                authorizationFinished(result, error)
            }
        } else {
            authorizationFinished(false, self.error)
        }
    }
    
    func biometryTypeClarification() -> LABiometryType {
        let result = context.canEvaluatePolicy(policy, error: &error)
        
        if result {
            return context.biometryType
        }
        return LABiometryType.none
    }
}
