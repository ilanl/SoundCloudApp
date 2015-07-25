//
//  LayoutPreference.swift
//  SoundCloudApp
//
//  Created by Ilan on 7/25/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import Foundation
import UIKit

public enum LayoutTrackTypes{
    case GridStyle
    case ListStyle
}

public extension LayoutTrackTypes{
    public func getLayout()->UICollectionViewLayout!{
        switch(self){
        case .GridStyle:
            return GridLayout()
        case .ListStyle:
            return ListLayout()
        }
    }
    
    public func getValueForLayout()->String!{
    
        switch(self){
        case .GridStyle:
            return "GridStyle"
        case .ListStyle:
            return "ListStyle"
        }
    }
}

public class LayoutPreference:NSObject{
    
    private var storage:LocalStorage!
    let storageKey:String = "Layout preference"
    
    public init(storage:LocalStorage){
        super.init()
        self.storage = storage
    }
    
    private var layoutType: LayoutTrackTypes?
    
    public func setLayout(type:LayoutTrackTypes){
        self.layoutType = type
        self.storage.save(storageKey, objectToSave: self.layoutType!.getValueForLayout())
    }

    public func getLastLayoutUsed()->LayoutTrackTypes?{
        let layoutGrid = LayoutTrackTypes.GridStyle
        let layoutList = LayoutTrackTypes.ListStyle
        
        if let prefLayoutSaved = self.storage.get(storageKey) as? String{
            if (prefLayoutSaved == layoutGrid.getValueForLayout()){
                self.layoutType = layoutGrid
                return self.layoutType
            }
            else if (prefLayoutSaved == layoutList.getValueForLayout()){
                self.layoutType = layoutList
                return self.layoutType
            }
        }
        
        return nil
    }
}

class ListLayout:UICollectionViewFlowLayout{
    override init() {
        super.init()
        super.itemSize = CGSize(width: 320, height: 46)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class GridLayout:UICollectionViewFlowLayout{
    override init() {
        super.init()
        super.itemSize = CGSize(width: 100, height: 100)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
