//
//  DataManagerTest.swift
//  Ted TalkTests
//
//  Created by Angela Lee on 22/09/2022.
//

import XCTest
@testable import Ted_Talk

class DataManagerTest: XCTestCase {
    
    var sut: DataManager!
    
    struct MockProvider: ServiceProtocol {
        var talks: [TedTalkData] = [
            TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", film_date: 14, languages: 5, main_speaker: "speaker1", name: "name1", num_speaker: 1, published_date: 4, speaker_occupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
            TedTalkData(comments: 10, descript: "description2", duration: 10, event: "event", film_date: 16, languages: 3, main_speaker: "speaker1", name: "name2", num_speaker: 1, published_date: 24, speaker_occupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", film_date: 1, languages: 20, main_speaker: "speaker3", name: "name3", num_speaker: 5, published_date: 4, speaker_occupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
        ]
        
        func parseTedTalk(_ completion: @escaping (Result<[TedTalkData], ServiceError>) -> Void) {
            completion(.success(talks))
        }
    }
    
    class MockDataBase: DataBase {
        
        var tedTalks: [TedTalkData] = []
        var isEmpty: Bool { return tedTalks.isEmpty}
        
        func persistData(data: [TedTalkData]) {
            tedTalks = data
        }
        
        func getRealmData() -> [TedTalkData] {
            return tedTalks
        }
        
        func clearData() {
            tedTalks.removeAll()
        }
    }
    
    class MockTableView: DataManagerDelegate {
        
        var callBack: ( ([TedTalkData]) -> Void )?
        
        func refreshData(data: [TedTalkData]) {
            callBack?(data)
        }
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataManager(service: MockProvider(), realmDataBase: MockDataBase())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetDataTedTalksEmptyDataBase() {
        
        let promise = self.expectation(description: "Geting Data")
        
        sut.getDataTedTalks() { result in
            XCTAssertEqual(result.count, 3)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetDataTedTalksInTheDataBase() {
        
        let promise = self.expectation(description: "Geting Data")
        
        sut.getDataTedTalks() { result in
            XCTAssertEqual(self.sut.dataBase.getRealmData()[0].comments, 10)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDelegate() {
        let dataBase = MockDataBase()
        dataBase.tedTalks = [
            TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", film_date: 14, languages: 5, main_speaker: "speaker1", name: "name1", num_speaker: 1, published_date: 4, speaker_occupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
            TedTalkData(comments: 10, descript: "description2", duration: 10, event: "event", film_date: 16, languages: 3, main_speaker: "speaker1", name: "name2", num_speaker: 1, published_date: 24, speaker_occupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", film_date: 1, languages: 20, main_speaker: "speaker3", name: "name3", num_speaker: 5, published_date: 4, speaker_occupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", film_date: 1, languages: 20, main_speaker: "speaker3", name: "name3", num_speaker: 5, published_date: 4, speaker_occupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
        ]
        let sut: DataManager = DataManager(service: MockProvider(), realmDataBase: dataBase)
        let delegate = MockTableView()
        sut.delegate = delegate
        
        let promise = self.expectation(description: "Geting data")
        let servicePromise = self.expectation(description: "Calling delegate")
        
        sut.getDataTedTalks() { data in
            XCTAssertEqual(data.count, 4)
            promise.fulfill()
        }
        
        delegate.callBack = { data in
            XCTAssertEqual(data.count, 3)
            servicePromise.fulfill()
        }
        
        wait(for: [promise,servicePromise], timeout: 5)
    }
}
