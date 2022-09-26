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
            TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", filmDate: 14, languages: 5, mainSpeaker: "speaker1", name: "name1", numberSpeaker: 1, publishedDate: 4, speakerOccupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
            TedTalkData(comments: 10, descript: "description2", duration: 10, event: "event", filmDate: 16, languages: 3, mainSpeaker: "speaker1", name: "name2", numberSpeaker: 1, publishedDate: 24, speakerOccupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", filmDate: 1, languages: 20, mainSpeaker: "speaker3", name: "name3", numberSpeaker: 5, publishedDate: 4, speakerOccupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
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
        
        func getData() -> [TedTalkData] {
            return tedTalks
        }
        
        func clearData() {
            tedTalks.removeAll()
        }
    }
    
    class MockDataManagerDelegate: DataManagerDelegate {
        
        var callBack: ( ([TedTalkData]) -> Void )?
        
        func refreshData(data: [TedTalkData]) {
            callBack?(data)
        }
    }
    
    class MockServiceFailure: ServiceProtocol {
        var talks: [TedTalkData] = [
            TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", filmDate: 14, languages: 5, mainSpeaker: "speaker1", name: "name1", numberSpeaker: 1, publishedDate: 4, speakerOccupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432)]
        func parseTedTalk(_ completion: @escaping (Result<[TedTalkData], ServiceError>) -> Void) {
            completion(.failure(.emptyData))
        }
        
        
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataManager(service: MockProvider(), dataBase: MockDataBase())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testDataTedTalksWithEmptyDatabaseAndServiceFailure() {
        sut = DataManager(service: MockServiceFailure(), dataBase: MockDataBase())
        let promise = self.expectation(description: "Scaling")

        sut.getDataTedTalks() { result in
            XCTAssertEqual(result.isEmpty, true)
                promise.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
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
            XCTAssertEqual(result[0].comments, 10)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDelegate() {
        let dataBase = MockDataBase()
        dataBase.tedTalks = [
            TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", filmDate: 14, languages: 5, mainSpeaker: "speaker1", name: "name1", numberSpeaker: 1, publishedDate: 4, speakerOccupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
            TedTalkData(comments: 10, descript: "description2", duration: 10, event: "event", filmDate: 16, languages: 3, mainSpeaker: "speaker1", name: "name2", numberSpeaker: 1, publishedDate: 24, speakerOccupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", filmDate: 1, languages: 20, mainSpeaker: "speaker3", name: "name3", numberSpeaker: 5, publishedDate: 4, speakerOccupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", filmDate: 1, languages: 20, mainSpeaker: "speaker3", name: "name3", numberSpeaker: 5, publishedDate: 4, speakerOccupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
        ]
        let sut: DataManager = DataManager(service: MockProvider(), dataBase: dataBase)
        let delegate = MockDataManagerDelegate()
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
