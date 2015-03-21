//
//  ViewController.swift
//  ShakuroTest
//
//  Created by Ilia Isupov on 21.03.15.
//  Copyright (c) 2015 Ilia Isupov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var picture: UIImageView!
    
    var photoSearchAPI: PhotoSearchAPI;
    
    required init(coder aDecoder: NSCoder) {
        self.photoSearchAPI = PhotoSearchAPI();
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Actions
    @IBAction func search() {
        //progress later
        let searchText = self.searchTextField.text;
        if (countElements(searchText) != 0) {
            self.photoSearchAPI.searchPhoto(searchText, handler: { (error, url) -> Void in
                if (error == nil) {
                    return print(error);
                }
                return print(url);
            })
        }
    }
}

