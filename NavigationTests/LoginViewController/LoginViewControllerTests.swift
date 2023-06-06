//
//  LoginViewControllerTests.swift
//  NavigationTests
//
//  Created by Ульви Пашаев on 05.06.2023.
//

import XCTest

@testable import Navigation

final class LoginViewControllerTests: XCTestCase {

    var sut: LogInViewController!
    var checkerService: CheckerServiceProtocolMock!

    override func setUp() {
        sut = LogInViewController()
        checkerService = CheckerServiceProtocolMock()
        sut.checkerService = checkerService
    }

    override func tearDown() {
        sut = nil
        checkerService = nil
    }

    func test_enteredShortAndWrongPassword() {
        // Arrange
        _ = sut.view
        sut.logInTextField.text = "q"
        sut.passwordTextField.text = "q"

        // Act
        sut.logInbutton.sendActions(for: .touchUpInside)

        // Assert
        XCTAssertEqual(checkerService.checkCredentialsCallCount, 1)
        XCTAssertEqual(checkerService.signUpCallCount, 0)
    }
}
