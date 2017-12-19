//
//  CGBTests.swift
//  CGBTests
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import XCTest
@testable import CGB

class CGBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_NetworkManager_fetchData(){
        let manager:NetworkManager = NetworkManager()
        let expect = expectation(description: "NetworkManager")
        
        manager.fetchData { (network, data) in
            if network == .Success {
                XCTAssertNotNil(data)
                expect.fulfill()
            }else{
                XCTAssertNil(data)
                expect.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_CardManager_delegate(){
        let manager:CardManager = CardManager()
        
        XCTAssertNil(manager.delegate)
        
    }
    
    func test_CardManager_ItemCollections(){
        
        let manager:CardManager = CardManager()
        
        XCTAssertNotNil(manager.cardCollections)
        
        XCTAssertEqual(manager.cardCollections.count, 0)
        
        let managerN:NetworkManager = NetworkManager()
        let expect = expectation(description: "NetworkManager")
        
        managerN.fetchData { (network, data) in
            if network == .Success {
                XCTAssertNotNil(data)
                manager.load(data: data!)
                
                XCTAssertEqual(manager.cardCollections.count, 22)
                
                XCTAssertEqual(manager.cardCollections[0].id, "chr_0000000001")
                
                expect.fulfill()
            }else{
                XCTAssertNil(data)
                expect.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_Card_DateConverter(){
        let card:Card = Card("chr", date: "2017-10-05T13:00:00.000Z", amount: "", currency: "", description: "", kind: "", heightContent: 0)
        print("card.date\(card.date)")
        XCTAssertEqual(card.date.characters.count, 10)
    }
    
}
