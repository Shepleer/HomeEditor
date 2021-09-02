//
//  HomeEditorTests.swift
//  HomeEditorTests
//
//  Created by Ivan Shepler on 02/09/2021.
//

import XCTest
@testable import HomeEditor

class HomeEditorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParcerService() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let names = ["Project 1", "Project 2"]
        let parcer = ProjectParcer()
        var error: Error?
        parcer.fetchProjects(projectsNames: names) { result in
            if let projects = try? result.get(), projects.count == names.count {
                return
            }
            error = NSError(domain: "Parcer error", code: 0, userInfo: nil)
        }
        if let error = error {
            throw error
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
