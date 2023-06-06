//
//  ProfileHeaderViewDelegateMock.swift
//  NavigationTests
//
//  Created by Ульви Пашаев on 05.06.2023.
//

@testable import Navigation

class ProfileHeaderDelegateMock: ProfileHeaderDelegate {
    var didSetStatusCallCount = 0
    var didSetStatusValue: String?
    
    func didSetStatus(_ value: String) {
        didSetStatusCallCount += 1
        didSetStatusValue = value
    }
}
