//
//  FilePreference.swift
//  SoundCloudApp
//
//  Created by Ilan on 7/25/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import Foundation

public class LocalStorage:NSObject{

    let dataKey:String = "LocalStorage"
    
    public func save(key:String,objectToSave:AnyObject){
        NSUserDefaults.standardUserDefaults().synchronize()
        var data : [String : [String : AnyObject]]?  =  NSUserDefaults.standardUserDefaults().objectForKey(dataKey) as? [String : [String : AnyObject]]
        if(data == nil)
        {
            data = [String : [String : AnyObject]]()
        }
        
        var dictData : [String : AnyObject] = [String : AnyObject]()
        dictData[key] = objectToSave
        NSUserDefaults.standardUserDefaults().setObject(dictData, forKey: dataKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    public func get(key:String)->AnyObject?{
        if let dictData : [String : AnyObject]  =  NSUserDefaults.standardUserDefaults().objectForKey(dataKey) as? [String : AnyObject]{
            return dictData[key]
        }
        return nil
    }
    
    
}
