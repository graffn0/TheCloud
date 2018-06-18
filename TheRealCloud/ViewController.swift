//
//  ViewController.swift
//  TheRealCloud
//
//  Created by Jaime on 4/18/16.
//  Copyright © 2016 Mobile Apps Company. All rights reserved.
//

import UIKit

import SwiftyDropbox

class SimpleCell: UITableViewCell {
    @IBOutlet weak var imgClloud: UIImageView!
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tblCloud: UITableView!
    var cloudDict = [ String : [NSData]]()
    
    var cloud  : TheCloud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatch_after(UInt64(0.01), dispatch_get_main_queue(), {
            self.cloud = TheCloud(controller: self)
        })
    }
    
    
    @IBAction func btnUpload(sender: AnyObject) {
        cloud?.uploadFile()
    }
    @IBAction func btnDownload(sender: AnyObject) {
        cloud?.getRootItems({ (data: NSData) in
            self.cloudDict["Dropbox"] = [data]
            self.tblCloud.reloadData()
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Array(cloudDict.keys).count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let aCloudKey = Array(cloudDict.keys)[section]
        return (cloudDict[aCloudKey]?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SimpleCell
        
        let aCloudKey = Array(cloudDict.keys)[indexPath.section]
        let aCloudArray = cloudDict[aCloudKey]
        myCell.imgClloud.image = UIImage(data: aCloudArray![indexPath.row] )
        return myCell
    }
}

