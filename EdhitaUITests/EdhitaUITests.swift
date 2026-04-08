//
//  EdhitaUITests.swift
//  EdhitaUITests
//
//  Created by Tatsuya Tobioka on 2022/07/24.
//

import XCTest

final class EdhitaUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchEditAndShareSmoke() throws {
        let app = XCUIApplication()
        app.launch()

        let addButton = app.buttons["finder.add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()

        let fileAction = app.sheets.buttons.element(boundBy: 0)
        if fileAction.waitForExistence(timeout: 5) {
            fileAction.tap()
        } else {
            let fallbackFileAction = app.buttons["File"]
            XCTAssertTrue(fallbackFileAction.waitForExistence(timeout: 5))
            fallbackFileAction.tap()
        }

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

        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
    }
}
