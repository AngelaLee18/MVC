//
//  ParseTest.swift
//  Ted TalkUITests
//
//  Created by Angela Lee on 25/08/2022.
//

import XCTest
@testable import Ted_Talk

class ParseTest: XCTestCase {
    
    var sut: Parse!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Parse()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testParse() {
        let test = "test"
        let expectation = expectation(description: "Parsing")
        var testTedTalk: [TedTalkData] = []
        sut.parseTedTalk(test) { result in
            switch result {
            case .success(let result):
                testTedTalk = result
                expectation.fulfill()
            case .failure(_):
                XCTFail("Fail")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(testTedTalk.count, 4, "Corret object quantify")
        XCTAssertEqual(testTedTalk[0].duration, 1164, "The duration of the 1rt talk is correct")
    }
}

