//
//  PlayerView.swift
//  SoundCloudApp
//
//  Created by Ilan on 7/24/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}

public class PlayerView : UIView {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    var player:AVPlayer?
    var playing:Bool=false
    
    public var trackInfo: TrackInfo?{
        willSet{
            
            if (newValue != nil){
                if let url = NSURL(string: newValue!.artworkUrl){
                    self.downloadImage(url)
                }
            }
        }
    }
    
    @IBOutlet weak var btnPlay: UIButton!
    
    required public init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func downloadImage(url:NSURL){
        self.progress.startAnimating()
        self.progress.hidden = false
        self.getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.coverImageView.image = UIImage(data: data!)
                self.coverImageView.contentMode = UIViewContentMode.ScaleAspectFit
                self.progress.hidden = true
                self.progress.stopAnimating()
            }
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    public func togglePlay(){
        
        if (player != nil && self.playing){
            player!.pause()
            self.playing = false
            self.btnPlay.setTitle("Play", forState:UIControlState.Normal)
            return
        }
        
        if let streamUrl = self.trackInfo?.streamUrl{
            let videoURL = NSURL(string: streamUrl)!
            self.player = AVPlayer(URL: videoURL)
            let playerLayer = AVPlayerLayer(player: player!)
            playerLayer.frame = self.bounds
            self.layer.addSublayer(playerLayer)
            player!.play()
            self.playing = true
            self.btnPlay.setTitle("Stop", forState:UIControlState.Normal)
        }
    }
    
    @IBAction func didPressPlay(sender: UIButton) {
        self.togglePlay()
    }
    
}
