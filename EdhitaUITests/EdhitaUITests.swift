//
//  EdhitaUITests.swift
//  EdhitaUITests
//
//  Created by Tatsuya Tobioka on 2022/07/24.
//

import XCTest

final class EdhitaUITests: XCTestCase {
    @discardableResult
    private func tapFirstExisting(_ elements: [XCUIElement], timeout: TimeInterval) -> Bool {
        for element in elements where element.waitForExistence(timeout: timeout) {
            element.tap()
            return true
        }
        return false
    }

    private func closeShareSheetIfPresent(_ app: XCUIApplication) {
        let dismissed = tapFirstExisting(
            [
                app.buttons["Cancel"],
                app.buttons["Done"],
                app.buttons["关闭"],
                app.buttons["完成"],
            ],
            timeout: 5
        )
        XCTAssertTrue(dismissed, "Expected share sheet dismiss button to appear")
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchEditAndShareSmoke() throws {
        let app = XCUIApplication()
        app.launch()

        let addButton = app.buttons["finder.add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()

        let didChooseFileType = tapFirstExisting(
            [
                app.sheets.buttons["File"],
                app.sheets.buttons["文件"],
                app.sheets.buttons.element(boundBy: 0),
                app.buttons["File"],
                app.buttons["文件"],
            ],
            timeout: 5
        )
        XCTAssertTrue(didChooseFileType, "Expected file creation action to be present")

        let fileName = "ui-smoke-\(UUID().uuidString.prefix(8)).txt"
        let promptField = app.textFields["prompt.textfield"]
        XCTAssertTrue(promptField.waitForExistence(timeout: 5))
        promptField.tap()
        promptField.typeText(fileName)

        let saveButton = app.buttons["prompt.save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        XCTAssertTrue(saveButton.isEnabled)
        saveButton.tap()

        let createdFile = app.staticTexts[fileName]
        XCTAssertTrue(createdFile.waitForExistence(timeout: 5))
        createdFile.tap()

        let editor = app.textViews["editor.text"]
        XCTAssertTrue(editor.waitForExistence(timeout: 5))
        editor.tap()
        editor.typeText("Smoke UI content")

        let shareButton = app.buttons["editor.share"]
        XCTAssertTrue(shareButton.waitForExistence(timeout: 5))
        shareButton.tap()

        closeShareSheetIfPresent(app)
    }
}
