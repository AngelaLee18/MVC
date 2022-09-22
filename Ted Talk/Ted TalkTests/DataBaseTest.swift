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
        TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", film_date: 14, languages: 5, main_speaker: "speaker1", name: "name1", num_speaker: 1, published_date: 4, speaker_occupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
        TedTalkData(comments: 4, descript: "description2", duration: 10, event: "event", film_date: 16, languages: 3, main_speaker: "speaker1", name: "name2", num_speaker: 1, published_date: 24, speaker_occupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
        TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", film_date: 1, languages: 20, main_speaker: "speaker3", name: "name3", num_speaker: 5, published_date: 4, speaker_occupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
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
        let result = sut.realm.objects(TedTalkData.self).first(where: { $0.comments == 10 })!
        XCTAssertEqual(result.duration, 5)
        XCTAssertEqual(result.name, "name1")
    }
    
    func testGetRealmData() {
        XCTAssertEqual(sut.getRealmData().count, 3)
    }
    
    func testClearData() {
        sut.clearData()
        XCTAssertTrue(sut.realm.isEmpty)
    }
}
