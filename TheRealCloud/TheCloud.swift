//
//  File.swift
//  TheRealCloud
//
//  Created by Jaime on 4/18/16.
//  Copyright © 2016 Mobile Apps Company. All rights reserved.
//



import Foundation

import SwiftyDropbox


class TheCloud{
    
    //Dropbox credentials
    private let DB_APPKEY = "dg8uy3ycbbjl23l"
    private let DB_APPSECRET = "2mehh71pax70zp7"
    
    //Googledrive credentials
    private let GD_KEY = "AIzaSyDTBVrEjRMh3IpQ24xcvlfTq2rjrweSgO4"
    
    //Box credentials
    private let BOX_KEY = "j30dxzzt29dl3wtueb890701e727oh96"
    private let BOX_SECRET = "2TZ0rOaLESpdszyG4s2zIHBCZOQYDfLk"
    
    //Onedrive
    private let OD_KEY = "000000004C18AD46"
    private let OD_SECRET = "BMytPsdN4mxt9ZlSO3Z01FFYb6I4KSrP"
    
    
    init(controller : UIViewController){
        //DB
        Dropbox.setupWithAppKey(DB_APPKEY)
        if Dropbox.authorizedClient == nil {
            Dropbox.authorizeFromController(controller)
        }
        //DB
        
        //BOX
        
        //BOX
        
    }
    
    func uploadFile(){
        if let client = Dropbox.authorizedClient {
            // Upload a file
            let myImage = UIImage(named: "leftOut")
            let fileData = UIImagePNGRepresentation(myImage!)
            client.files.upload(path: "/leftOut.png", body: fileData!).response { response, error in
                if error != nil{ print(error?.description) }
                else{ response }
            }
        }
    }
    
    func getRootItems( completion : (NSData) ->Void ){
        if let client = Dropbox.authorizedClient {
            // Download a file
            
            let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { temporaryURL, response in
                let fileManager = NSFileManager.defaultManager()
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                // generate a unique name for this file in case we've seen it before
                let UUID = NSUUID().UUIDString
                let pathComponent = "\(UUID)-\(response.suggestedFilename!)"
                return directoryURL.URLByAppendingPathComponent(pathComponent)
            }
            
            client.files.download(path: "/leftOut.png", destination: destination).response { response, error in
                if let (_, url) = response {
                    let data = NSData(contentsOfURL: url)
                    completion(data!)
                }
                else { print(error!) }
            }
        }
    }
}