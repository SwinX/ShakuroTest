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
        var params = [
            "method": "flickr.photos.search",
            "api_key": FlickrKey,
            "text": name,
            "safe_search": 1,
            "per_page": 1,
            "nojsoncallback": 1,
            "format": "json"
        ];
        self.manager.GET("services/rest",
            parameters: params,
            success:{ (operation, result) -> Void in
                print(result);
                var photo = result["photos"];
                handler?(error: nil, url: nil);
            },
            failure: { (operation, error) -> Void in
                print(error);
                handler?(error: error, url: nil);
            }
        )
    }
}
