//
//  SearchBarAndPickerViewTest.swift
//  Ted TalkTests
//
//  Created by Angela Lee on 31/08/2022.
//

import XCTest
@testable import Ted_Talk

class SearchBarAndPickerViewTest: XCTestCase {
    struct MockProvider: ServiceProtocol {
        let talks: [TedTalkData]
        init(talks: [TedTalkData]) {
            self.talks = talks
        }
        func parseTedTalk(_ completion: @escaping (Result<[TedTalkData], ServiceError>) -> Void) {
            completion(.success(talks))
        }
    }
    
    var sut: ViewModelTedTalk!
    override func setUpWithError() throws {
        try super.setUpWithError()
        let talks: [TedTalkData] = [
            TedTalkData(comments: 10, descript: "description1", duration: 5, event: "event", filmDate: 14, languages: 5, mainSpeaker: "speaker1", name: "name1", numberSpeaker: 1, publishedDate: 4, speakerOccupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
            TedTalkData(comments: 4, descript: "description2", duration: 10, event: "event", filmDate: 16, languages: 3, mainSpeaker: "speaker1", name: "name2", numberSpeaker: 1, publishedDate: 24, speakerOccupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
            TedTalkData(comments: 10, descript: "description3", duration: 32, event: "event", filmDate: 1, languages: 20, mainSpeaker: "speaker3", name: "name3", numberSpeaker: 5, publishedDate: 4, speakerOccupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
        ]
        
        let dataManager = DataManager(service: MockProvider(talks: talks))
        sut = ViewModelTedTalk(dataManager: dataManager)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testSearchEvent() {
        let expectation = expectation(description: "Get talks")
        sut.loadTableView = {
            expectation.fulfill()
        }
        sut.fetchData()
        waitForExpectations(timeout: 10, handler: nil)
        
        sut.searchByFilter(searchText: "nam", picker: 4)
        XCTAssertEqual(sut.getNumberOfRow(), 3, "There is 3 matched when search nam in Name")
        XCTAssertEqual(sut.getTedTalkDetails(selectedPath: 0).name, "name1", "The name of the main speaker of the first event is name1")
        XCTAssertEqual(sut.getTedTalkDetails(selectedPath: 0).name, "name1", "The name of the main speaker of the first event is name1")
        XCTAssertEqual(sut.getTedTalkDetails(selectedPath: 0).date, 14, "There is 3 matched when search nam in Name")
    }
}
