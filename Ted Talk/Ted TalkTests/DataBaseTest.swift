//
//  DataBase.swift
//  Ted TalkTests
//
//  Created by Angela Lee on 22/09/2022.
//

import XCTest
@testable import Ted_Talk

class DataBaseTest: XCTestCase {
    
    var sut: RealmDB!
    let tedTalks: [TedTalkData] = [
        TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", filmDate: 14, languages: 5, mainSpeaker: "speaker1", name: "name1", numberSpeaker: 1, publishedDate: 4, speakerOccupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
        TedTalkData(comments: 4, descript: "description2", duration: 10, event: "event", filmDate: 16, languages: 3, mainSpeaker: "speaker1", name: "name2", numberSpeaker: 1, publishedDate: 24, speakerOccupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
        TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", filmDate: 1, languages: 20, mainSpeaker: "speaker3", name: "name3", numberSpeaker: 5, publishedDate: 4, speakerOccupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
    ]

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RealmDB()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testPersistData() {
        sut.persistData(data: tedTalks)
        XCTAssertFalse(sut.isEmpty)
    }
    
    func testGetRealmData() {
        XCTAssertEqual(sut.getData().count, 3)
    }
    
    func testClearData() {
        sut.clearData()
        XCTAssertTrue(sut.isEmpty)
    }
}
