//
//  TrackInfo.swift
//  SoundCloudApp
//
//  Created by Ilan on 7/23/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import Foundation

public class TrackInfo : NSObject{
    public var trackId: Int
    public var artworkUrl: String
    public var title: String
    public var streamUrl: String
    public var duration: Int
    
    class func parse(JSON:AnyObject)->TrackInfo?{
        
        println("\(JSON)")
        
        var trackInfo:TrackInfo?
        if let trackId = JSON["id"] as? Int,let artworkUrl = JSON["artwork_url"] as? String,let streamUrl = JSON["stream_url"] as? String,let title = JSON["title"] as? String,let duration = JSON["duration"] as? Int{
            trackInfo = TrackInfo(trackId: trackId, artWorkUrl: artworkUrl, streamUrl: streamUrl, title: title, duration: duration)
        }
        return trackInfo
    }
    
    init(trackId:Int,artWorkUrl:String,streamUrl:String,title:String,duration:Int) {
        self.trackId = trackId
        self.artworkUrl = artWorkUrl
        self.streamUrl = streamUrl
        self.title = title
        self.duration = duration
    }
}
