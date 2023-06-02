//
//  FavoriteViewControllerTests.swift
//  FavoriteViewControllerTests
//
//  Created by Ульви Пашаев on 01.06.2023.
//

import XCTest

@testable import Navigation
@testable import StorageService


class ProfileHeaderViewTests: XCTestCase {

    // Создаем фиктивный делегат
    class MockProfileHeaderDelegate: ProfileHeaderDelegate {
        var didSetStatusCalled = false
        var didSetStatusValue: String?

        func didSetStatus(_ value: String) {
            didSetStatusCalled = true
            didSetStatusValue = value
        }
    }

    func testButtonPressed_ShouldCallDelegateMethodWithCorrectValue() {
        // Arrange
        let headerView = ProfileHeaderView()
        let delegate = MockProfileHeaderDelegate()
        headerView.delegate = delegate

        let expectedStatus = "New status"
        headerView.statusText = expectedStatus

        // Act
        headerView.buttonPressed()

        // Assert
        XCTAssertTrue(delegate.didSetStatusCalled)
        XCTAssertEqual(delegate.didSetStatusValue, expectedStatus)
    }
}
