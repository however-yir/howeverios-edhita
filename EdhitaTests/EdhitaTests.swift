//
//  EdhitaTests.swift
//  EdhitaTests
//
//  Created by Tatsuya Tobioka on 2022/07/24.
//

import XCTest

@testable import Edhita

final class EdhitaTests: XCTestCase {
    private var temporaryDirectories: [URL] = []

    override func tearDownWithError() throws {
        for directory in temporaryDirectories {
            try? FileManager.default.removeItem(at: directory)
        }
        temporaryDirectories.removeAll()
    }

    private func makeTemporaryDirectory() throws -> URL {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        temporaryDirectories.append(directory)
        return directory
    }

    func testFinderItemUpdateAndDuplicateCreatesCopies() throws {
        let directory = try makeTemporaryDirectory()
        let fileURL = directory.appendingPathComponent("note.md")
        try "hello".write(to: fileURL, atomically: true, encoding: .utf8)

        let item = FinderItem(url: fileURL)
        XCTAssertEqual(item.content, "hello")

        item.update(content: "updated")
        XCTAssertEqual(try String(contentsOf: fileURL), "updated")

        item.duplicate()
        let firstCopyName = String(format: NSLocalizedString("Copy of %@", comment: ""), "note.md")
        let firstCopyURL = directory.appendingPathComponent(firstCopyName)
        XCTAssertTrue(FileManager.default.fileExists(atPath: firstCopyURL.path))

        item.duplicate()
        let secondCopyURL = directory.appendingPathComponent("\(firstCopyName) 2")
        XCTAssertTrue(FileManager.default.fileExists(atPath: secondCopyURL.path))
    }

    func testFinderListAddItemAndRelativePath() throws {
        let directory = try makeTemporaryDirectory()
        let list = FinderList(url: directory)

        list.addItem(name: "draft.txt", isDirectory: false)

        let createdFileURL = directory.appendingPathComponent("draft.txt")
        XCTAssertTrue(FileManager.default.fileExists(atPath: createdFileURL.path))
        XCTAssertTrue(list.items.contains(where: { $0.filename == "draft.txt" }))

        XCTAssertEqual(FinderList.relativePath(for: FinderList.rootURL), "/")
        let nested = FinderList.rootURL.appendingPathComponent("folder").appendingPathComponent("sub")
        XCTAssertEqual(FinderList.relativePath(for: nested), "/folder/sub")
    }

    func testFinderItemRenameMoveAndDestroyLifecycle() throws {
        let sourceDirectory = try makeTemporaryDirectory()
        let destinationDirectory = try makeTemporaryDirectory()
        let originalURL = sourceDirectory.appendingPathComponent("note.txt")
        try "content".write(to: originalURL, atomically: true, encoding: .utf8)

        let item = FinderItem(url: originalURL)
        item.rename(name: "renamed.txt")

        let renamedURL = sourceDirectory.appendingPathComponent("renamed.txt")
        XCTAssertTrue(FileManager.default.fileExists(atPath: renamedURL.path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: originalURL.path))

        let renamedItem = FinderItem(url: renamedURL)
        renamedItem.move(directory: destinationDirectory)

        let movedURL = destinationDirectory.appendingPathComponent("renamed.txt")
        XCTAssertTrue(FileManager.default.fileExists(atPath: movedURL.path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: renamedURL.path))

        FinderItem(url: movedURL).destroy()
        XCTAssertFalse(FileManager.default.fileExists(atPath: movedURL.path))
    }

    func testLargeDocumentUpdatePerformance() throws {
        let directory = try makeTemporaryDirectory()
        let fileURL = directory.appendingPathComponent("large.txt")
        try "".write(to: fileURL, atomically: true, encoding: .utf8)
        let item = FinderItem(url: fileURL)
        let payload = String(repeating: "0123456789abcdef", count: 80_000)

        measure {
            item.update(content: payload)
            _ = item.content.count
        }
    }
}
