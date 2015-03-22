//
//  ViewController.swift
//  ShakuroTest
//
//  Created by Ilia Isupov on 21.03.15.
//  Copyright (c) 2015 Ilia Isupov. All rights reserved.
//

import UIKit

typealias ShowImageCallback = (error: NSError?) -> Void

class ViewController: UIViewController {
    
    private let ProgressText = "Loading image..."
    private let NotFoundText = "No images found."
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    var photoSearchAPI: PhotoSearchAPI!;
    var progressHud: BFRadialWaveHUD!;
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.photoSearchAPI = PhotoSearchAPI();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressHud = BFRadialWaveHUD(view: self.view, fullScreen: false, circles: ProgressHudCirclesAmount, circleColor: nil, mode: BFRadialWaveHUDMode.Default, strokeWidth: CGFloat(ProgressHudStrokeWidth))
    }

    //Actions
    @IBAction func search() {
        //progress later
        let searchText = self.searchTextField.text;
        if (countElements(searchText) != 0) {
            self.showProgress();
            self.photoSearchAPI.searchPhoto(searchText, handler: {[unowned self] (error, url) -> Void in
                if (error != nil) {
                    self.hideProgress();
                    return self.showError(error!);
                }
                if (url != nil) {
                    self.showImage(url!, callback: { (error) -> Void in
                        self.hideProgress();
                        if (error != nil) {
                             return self.showError(error!);
                        }
                        self.displayPicture();
                    })
                } else {
                    self.hideProgress();
                    self.showNoImageMessage();
                }

            })
        }
    }
    
    private func showProgress() {
        progressHud.showWithMessage(ProgressText);
    }
    
    private func hideProgress() {
        progressHud.dismiss();
    }
    
    private func showError(error: NSError) {
        UIAlertView(title: "Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show();
    }
    
    private func showNoImageMessage() {
        self.displayMessage();
        self.message.text = NotFoundText;
    }
    
    private func showImage(url: NSURL, callback: ShowImageCallback?) {
        self.picture.sd_setImageWithURL(url, completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, url: NSURL!) -> Void in
            if (callback != nil) {
                callback!(error: error);
            }
        });
    }
    
    private func displayMessage() {
        self.picture.hidden = true;
        self.message.hidden = false;
    }
    
    private func displayPicture() {
        self.picture.hidden = false;
        self.message.hidden = true;
    }
}

