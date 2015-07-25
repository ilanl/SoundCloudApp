//
//  PlayerViewController.swift
//  SoundCloudApp
//
//  Created by Ilan on 7/25/15.
//  Copyright (c) 2015 Ilan. All rights reserved.
//

import Foundation
import UIKit

class PlayerViewController:UIViewController{
    
    @IBOutlet weak var placeHolder: UIView!
    
    @IBAction func didClose(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}