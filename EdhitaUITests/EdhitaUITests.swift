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
            tapElement(element)
            return true
        }
        return false
    }

    private func tapElement(_ element: XCUIElement) {
        if element.isHittable {
            element.tap()
            return
        }

        // Some simulator/device combinations report existence but fail AX scroll-to-visible.
        element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
    }

    private func closeShareSheetIfPresent(_ app: XCUIApplication) {
        let dismissed = tapFirstExisting(
            [
                app.buttons["Cancel"],
                app.buttons["Done"],
                app.buttons["Close"],
                app.buttons["取消"],
                app.buttons["关闭"],
                app.buttons["完成"],
            ],
            timeout: 5
        )
        XCTAssertTrue(dismissed, "Expected share sheet dismiss button to appear")
    }

    private func dismissKeyboardIfNeeded(_ app: XCUIApplication) {
        guard app.keyboards.count > 0 else {
            return
        }

        let modeSwitcher = app.segmentedControls.firstMatch
        if modeSwitcher.waitForExistence(timeout: 2) {
            let previewButton = modeSwitcher.buttons.element(boundBy: 1)
            if previewButton.exists {
                previewButton.tap()
                _ = app.keyboards.firstMatch.waitForNonExistence(timeout: 5)
            }
        }
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchEditAndShareSmoke() throws {
        let app = XCUIApplication()
        app.launchArguments.append("UITEST_BYPASS_ADD_DIALOG")
        app.launch()

        let fileName = "ui-smoke-\(UUID().uuidString.prefix(8)).txt"
        let promptField = app.textFields["prompt.textfield"]
        if !promptField.waitForExistence(timeout: 8) {
            let addButton = app.buttons["finder.add"]
            XCTAssertTrue(addButton.waitForExistence(timeout: 5))
            tapElement(addButton)
        }
        XCTAssertTrue(promptField.waitForExistence(timeout: 5))
        promptField.tap()
        promptField.typeText(fileName)

        let saveButton = app.buttons["prompt.save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        XCTAssertTrue(saveButton.isEnabled)
        saveButton.tap()

        let fileRow = app.buttons.containing(
            NSPredicate(format: "label CONTAINS %@", fileName)
        ).firstMatch
        let fileText = app.staticTexts[fileName]
        XCTAssertTrue(fileRow.waitForExistence(timeout: 5) || fileText.waitForExistence(timeout: 5))
        if fileRow.exists {
            tapElement(fileRow)
        } else {
            tapElement(fileText)
        }

        let editor = app.textViews["editor.text"]
        if !editor.waitForExistence(timeout: 5), fileRow.exists {
            tapElement(fileRow)
        }
        XCTAssertTrue(editor.waitForExistence(timeout: 5))
        tapElement(editor)
        editor.typeText("Smoke UI content")

        let shareButton = app.buttons["editor.share"]
        XCTAssertTrue(shareButton.waitForExistence(timeout: 5))
        dismissKeyboardIfNeeded(app)
        tapElement(shareButton)

        closeShareSheetIfPresent(app)
    }
}
