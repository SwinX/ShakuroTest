//
//  PhotoSearchAPI.swift
//  ShakuroTest
//
//  Created by Ilia Isupov on 21.03.15.
//  Copyright (c) 2015 Ilia Isupov. All rights reserved.
//

import Foundation

typealias PhotoSearchHandler = (error: NSError?, url: NSURL?) -> Void


class PhotoSearchAPI {
    
    var manager: AFHTTPRequestOperationManager;
    
    init() {
        self.manager = AFHTTPRequestOperationManager(baseURL: NSURL(string: FlickrBaseUrl));
    }
    
    func searchPhoto(name: String, handler: PhotoSearchHandler?) {
        self.manager.GET("services/rest",
            parameters: photoRequestParams(name),
            success:{ (operation, result) -> Void in
                print(result);
                handler?(error: nil, url: self.urlForFlickrPhoto(result as NSDictionary));
            },
            failure: { (operation, error) -> Void in
                print(error);
                handler?(error: error, url: nil);
            }
        )
    }
    
    private func photoRequestParams(photoName: String) -> NSDictionary {
        return [
            "method": "flickr.photos.search",
            "api_key": FlickrKey,
            "text": photoName,
            "safe_search": 1,
            "per_page": 1,
            "nojsoncallback": 1,
            "format": "json"
        ];
    }
    
    private func urlForFlickrPhoto(photoDescription: NSDictionary) -> NSURL? {
        //Using obj-c collections because AFNetworking returns it
        let photosContainer: NSDictionary = photoDescription["photos"] as NSDictionary;
        let photos: NSArray = photosContainer["photo"] as NSArray;
        if photos.count > 0 {
            return NSURL(string: self.buildUrlForPhoto(photos[0] as NSDictionary));
        } else {
            return nil;
        }
    }
    
    private func buildUrlForPhoto(photo: NSDictionary) -> String {
        let farm: Int = photo["farm"] as Int;
        let server: String = photo["server"] as String;
        let id: String = photo["id"] as String;
        let secret: String = photo["secret"] as String;
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg";
    }
    
}
