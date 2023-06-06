//
//  CheckerServiceProtocolMock.swift
//  NavigationTests
//
//  Created by Ульви Пашаев on 05.06.2023.
//

@testable import Navigation

class CheckerServiceProtocolMock: CheckerServiceProtocol {
    
    var checkCredentialsCallCount = 0
    var signUpCallCount = 0
    
    // MARK: - CheckerServiceProtocol
    
    func checkCredentials(
        login: String,
        password: String,
        completion: @escaping (CheckerServiceAuthResult) -> Void
    ) {
        checkCredentialsCallCount += 1
        guard password.count >= 6 else {
            completion(.error("wrong pass"))
            return
        }
        completion(.success)
    }
    
    func signUp(
        login: String,
        password: String,
        completion: @escaping (CheckerServiceSignUpResult) -> Void
    ) {
        signUpCallCount += 1
        completion(.success)
    }
}
