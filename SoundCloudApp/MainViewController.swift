//
//  ViewController.swift
//  SoundCloudApp
//
//  Created by Ilan on 7/23/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var btnSearch: UIButton!
    func filterContentForSearchText(searchText: String) {
        
        soundClient.searchTracksByQuery(searchText, completionHandler: { (tracks, error) -> Void in
            self.trackArray = tracks
            self.collection.reloadData()
        })
    }
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var trackArray:[TrackInfo]?
    let soundClient = SoundCloudClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var layout:UICollectionViewLayout? = LayoutTrackTypes.ListStyle.getLayout()
        self.preference = LayoutPreference(storage: LocalStorage())
        if let layoutType = self.preference.getLastLayoutUsed(){
            layout = layoutType.getLayout()
        }
        
        self.collection.setCollectionViewLayout(layout!, animated: true)
        self.filterContentForSearchText("bruno mars")
    }
 
    var preference:LayoutPreference!
    
    @IBAction func didSelectGridLayout(sender: UIButton) {
        let selectedLayout = LayoutTrackTypes.GridStyle
        self.preference.setLayout(selectedLayout)
        self.collection.setCollectionViewLayout(selectedLayout.getLayout(), animated: true)
    }
    
    @IBAction func didSelectListLayout(sender: UIButton) {
        let selectedLayout = LayoutTrackTypes.ListStyle
        self.preference.setLayout(selectedLayout)
        self.collection.setCollectionViewLayout(selectedLayout.getLayout(), animated: true)
    }
    
    //MARK: Collection selection
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let track:TrackInfo? = self.trackArray?[indexPath.row]{
            var playerViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PlayerViewController") as!PlayerViewController
            
            self.presentViewController(playerViewController, animated: true) { () -> Void in
                if let playerView = UIView.loadFromNibNamed("PlayerInterface", bundle: nil) as? PlayerView{
                    
                    playerViewController.view.addSubview(playerView)
                    playerView.center = playerViewController.view.center
                    playerView.trackInfo = track
                    playerView.addGestureRecognizer(UITapGestureRecognizer(target: playerView, action: "togglePlay"))
                    //playerView.togglePlay()
                }
            }
        }
        
    }
    
    @IBAction func didPressSearch(sender: UIButton) {
        self.searchBarSearchButtonClicked(self.searchBar)
    }
    
    //MARK: Search Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        self.filterContentForSearchText(searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    //MARK: UICollectionVIew delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        if (self.trackArray == nil){
            return 0
        }
        return self.trackArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collection.dequeueReusableCellWithReuseIdentifier("TrackInfoTileImageCell", forIndexPath: indexPath) as! TrackInfoTileImageCell
        
        let track:TrackInfo = self.trackArray![indexPath.row]
        
        cell.title.text = "\(track.title)"
        
        return cell

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

