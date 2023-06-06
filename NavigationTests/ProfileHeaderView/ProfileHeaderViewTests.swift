//
//  ProfileHeaderViewTests.swift
//  NavigationTest
//
//  Created by Ульви Пашаев on 01.06.2023.
//

import XCTest

@testable import Navigation
@testable import StorageService


class ProfileHeaderViewTests: XCTestCase {
    
    var sut: ProfileHeaderView!
    var delegate: ProfileHeaderDelegateMock!
    
    override func setUp() {
        sut = ProfileHeaderView()
        delegate = ProfileHeaderDelegateMock()
        sut.delegate = delegate
    }
    
    override func tearDown() {
        sut = nil
        delegate = nil
    }
    
    func testButtonPressed_ShouldCallDelegateMethodWithCorrectValue() {
        // Arrange
        let expectedStatus = "New status"
        sut.statusText = expectedStatus
        
        // Act
        sut.buttonPressed()
        
        // Assert
        XCTAssertEqual(delegate.didSetStatusCallCount, 1)
        XCTAssertEqual(delegate.didSetStatusValue, expectedStatus)
    }
}
