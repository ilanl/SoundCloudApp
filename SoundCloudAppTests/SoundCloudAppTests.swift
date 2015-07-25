//
//  SoundCloudAppTests.swift
//  SoundCloudAppTests
//
//  Created by Ilan on 7/23/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import UIKit
import XCTest
import SoundCloudApp

class SoundCloudAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQueryTracks(){
        var query = "Bruno Mars"
        
        var client = SoundCloudClient.sharedInstance
        let expectation = expectationWithDescription("retrieve tracks by query")
        
        client.searchTracksByQuery(query,completionHandler: { (tracks, error) -> Void in
            if (tracks.count > 0){
                var firstTrack = tracks.first!
                println("\(firstTrack.streamUrl)")
                expectation.fulfill()
            }
        })
        
        waitForExpectationsWithTimeout(5){ error in
            
        }
        
    }
        
    func testRetrieveTrackInfo() {
        
        var client = SoundCloudClient.sharedInstance
        let expectation = expectationWithDescription("retrieve track info successfully")
        var trackId:String = "132726724"
        
        client.retrieveTrackInfo(trackId, completionHandler: { (track, error) -> Void in
            
            if (track != nil){
                var trackIdReturned:String = "\(track!.trackId)"
                if (trackIdReturned == trackId){
                    expectation.fulfill()
                }
                
            }
        })
        
        waitForExpectationsWithTimeout(5){ error in
            
        }
    }
    
    func testStorage(){
        let key = "someKey"
        let value1 = "someValue1"
        let value2 = "someValue2"
        
        var target = LocalStorage()
        target.save(key, objectToSave: value1)
        
        
        target = LocalStorage()
        
        if let valueRead1 = target.get(key) as? String{
            XCTAssertEqual(valueRead1, value1, "value1 not restored properly")
            target.save(key, objectToSave: value2)
            
            if let valueRead2 = target.get(key) as? String{
                XCTAssertEqual(valueRead2, value2, "value2 not restored properly")
            }
        }
    }
    
    
}
